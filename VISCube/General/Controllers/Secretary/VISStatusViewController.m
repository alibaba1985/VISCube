//
//  VISStatusViewController.m
//  VISCube
//
//  Created by liwang on 14-8-11.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISStatusViewController.h"
#import "UPFile.h"

@interface VISStatusViewController ()
{
    CGFloat _rowHeight;
}

@property(nonatomic, strong)NSMutableArray *activeDevices;
@property(nonatomic, strong)NSMutableArray *allDevices;
@property(nonatomic, strong)NSMutableArray *allSwitchers;


- (void)sortActiveDevices;

@end

@implementation VISStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"运行状态";
    [self sortActiveDevices];
    _rowHeight = [UPDeviceInfo isPad] ? 80 : 60;
    self.tableView = [self tableViewWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)findInsertIndexByHour:(CGFloat)hour
{
    NSInteger index = 0;
    for (NSInteger i = 0 ; i<self.activeDevices.count; i++) {
        NSDictionary *item = [self.activeDevices objectAtIndex:i];
        CGFloat h = [[item objectForKey:kDeviceActiveTime] floatValue];
        if (hour > h) {
            index = i;
            break;
        }
        else if (i == self.activeDevices.count-1)
        {
            index = self.activeDevices.count;
        }
    }
    
    return index;
}


- (void)sortActiveDevices
{
    NSString *path = [UPFile pathForFile:kFileName writable:YES];
    self.allDevices = [NSMutableArray arrayWithArray:[UPFile readFile:path forKey:@"Devices"]];
    self.activeDevices = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in self.allDevices) {
        if ([[item objectForKey:kDeviceStatus] isEqualToString:kValue0]) {
            CGFloat hour = [[item objectForKey:kDeviceActiveTime] floatValue];
            NSInteger insertIndex = [self findInsertIndexByHour:hour];
            [self.activeDevices insertObject:item atIndex:insertIndex];
        }
    }
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _rowHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)rowsNumber
{
    NSInteger number = 0;
    
    NSString *path = [UPFile pathForFile:kFileName writable:YES];
    NSArray *bars = [NSArray arrayWithArray:[UPFile readFile:path forKey:@"Devices"]];
    for (NSDictionary *item in bars) {
        if ([[item objectForKey:kDeviceStatus] isEqualToString:kValue0]) {
            number++;
        }
    }
    
    return number;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.activeDevices.count;
}

- (void)switchAction:(UISwitch *)switcher
{
    [self showLoadingWithMessage:@"正在发送请求..."];
    
    if (!switcher.isOn)
    {
        NSMutableDictionary *device = [NSMutableDictionary dictionaryWithDictionary:[self.activeDevices objectAtIndex:switcher.tag]];
        [device setObject:kValue1 forKey:kDeviceStatus];
        for (NSInteger i = 0 ; i<self.allDevices.count; i++ ) {
            NSDictionary *item = [self.activeDevices objectAtIndex:i];
            if ([[device objectForKey:kIMEI] isEqual:[item objectForKey:kIMEI]]) {
                [self.allDevices replaceObjectAtIndex:i withObject:device];
                NSString *path = [UPFile pathForFile:kFileName writable:YES];
                [UPFile writeFile:path withValue:self.allDevices forKey:@"Devices"];
                break;
            }
        }
        
        [self.activeDevices removeObjectAtIndex:switcher.tag];
        [self.tableView reloadData];
        
    }
    
    [self dismissLoading];

    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"optimizerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    NSDictionary *item = [self.activeDevices objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        
    }
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UISwitch class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGRect frame = CGRectMake(CGRectGetWidth(tableView.frame)-80, (_rowHeight - 30) /2, 60, 30);
    UISwitch *switcher = [[UISwitch alloc] initWithFrame:frame];
    [switcher setOn:YES animated:YES];
    switcher.tag = indexPath.row;
    [switcher addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switcher];
    
    
    NSString *device = [item objectForKey:kDeviceName];
    NSString *time = [item objectForKey:kDeviceActiveTime];
    cell.textLabel.text = device;
    cell.textLabel.textColor = [UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"连续工作%@小时", time];
    
    return cell;
}


@end
