//
//  VISOptimizerViewController.m
//  VISCube
//
//  Created by liwang on 14-8-11.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISOptimizerViewController.h"
#import "UPFile.h"

@interface VISOptimizerViewController ()
{
    CGFloat _rowHeight;
    BOOL _didOptimized;
}


@property(nonatomic, strong)NSMutableArray *optimizerArray;

- (void)findOptimizeDevice;

- (void)startOptimize;

@end

@implementation VISOptimizerViewController

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
    self.title = @"优化方案";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"一键优化" style:UIBarButtonItemStylePlain target:self action:@selector(startOptimize)];
    [self findOptimizeDevice];
    _rowHeight = [UPDeviceInfo isPad] ? 80 : 60;
    self.tableView = [self tableViewWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    //
    
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

- (void)findOptimizeDevice
{
    self.optimizerArray = [[NSMutableArray alloc] init];
    NSString *path = [UPFile pathForFile:kFileName writable:NO];
    NSArray *array = [NSArray arrayWithArray:[UPFile readFile:path forKey:@"Devices"]];
    
    NSString *stringValue = nil;
    CGFloat floatValue = 0;
    for (NSDictionary *item in array) {
        stringValue = [item objectForKey:kValue];
        floatValue = [stringValue floatValue];
        if (floatValue >= 100) {
            [self.optimizerArray addObject:item];
        }
    }
    
}

- (void)endOptimize
{
    [self.tableView reloadData];
    [self showToastMessage:@"优化成功!"];
}

- (void)checkOptimize
{
    [self showToastMessage:@"已优化,无需重复操作."];
}

- (void)startOptimize
{
    if (_didOptimized) {
        [self showLoadingWithMessage:nil];
        [self performSelector:@selector(checkOptimize) withObject:nil afterDelay:0.8];
    }
    else
    {
        [self showLoadingWithMessage:@"正在优化,请稍侯..."];
        _didOptimized = YES;
        [self performSelector:@selector(endOptimize) withObject:nil afterDelay:2.5];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.optimizerArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"optimizerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    NSString *option = @"优化方案：在凌晨00:00-07:00可以自动关闭。";
    NSDictionary *item = [self.optimizerArray objectAtIndex:indexPath.row];
    NSString *device = [item objectForKey:kDeviceName];
    
    NSString *text = _didOptimized ? [NSString stringWithFormat:@"%@-已优化", device] : device;
    
    cell.textLabel.text = text;
    cell.textLabel.textColor = [UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f];
    cell.detailTextLabel.text = option;
    
    return cell;
}


@end
