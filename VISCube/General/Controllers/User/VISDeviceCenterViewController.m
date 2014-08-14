//
//  VISDeviceCenterViewController.m
//  VISCube
//
//  Created by liwang on 14-8-14.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISDeviceCenterViewController.h"

@interface VISDeviceCenterViewController ()
{
    BOOL _isOn;
}

@end

@implementation VISDeviceCenterViewController

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
    self.title = @"设备中心";
    _isOn = [[[NSUserDefaults standardUserDefaults] objectForKey:kCubeConnection] isEqualToString:kValueYES];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(10, 0, CGRectGetWidth(tableView.frame) - 20, 30);
    NSString *text = @"当前连接的魔方";
    CGFloat fontSize = [UPDeviceInfo isPad] ? 20 : 18;
    VISLabel *headLabel = [VISViewCreator wrapLabelWithFrame:frame text:text font:[VISViewCreator defaultFontWithSize:fontSize] textColor:[UIColor blackColor]];
    headLabel.backgroundColor = self.view.backgroundColor;
    return headLabel;
}

- (UITableViewCell *)cellWithImage:(UIImage *)image title:(NSString *)title
{
    CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
    CGFloat x = margin;
    CGFloat height = 27;
    CGFloat y = (_rowHeight - height) / 2;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    // add head image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(x, y, height, height);
    [cell.contentView addSubview:imageView];
    
    // add title
    x = margin*2 + height;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 24 : 18;
    CGRect titleFrame = CGRectMake(x, y, self.viewMaxWidth-x, height);
    VISLabel *titleLabel = [VISViewCreator wrapLabelWithFrame:titleFrame
                                                         text:title
                                                         font:
                            [UIFont fontWithName:@"HelveticaNeue" size:fontSize]
                                                    textColor:[UIColor blackColor]];
    
    titleLabel.verticalAlignment = VISVerticalAlignmentMiddle;
    [cell.contentView addSubview:titleLabel];
    
    return cell;
}


- (void)switchAction:(UISwitch *)switcher
{
    NSString *message = _isOn ? @"正在断开连接..." : @"正在连接魔方...";
    [self showLoadingWithMessage:message];
    
    if (switcher.isOn) {
        [[VISSourceManager currentSource] initAllDevices];
        [[NSUserDefaults standardUserDefaults] setObject:kValueYES forKey:kCubeConnection];
    }
    else
    {
        kSourceManager.allDevices = nil;
        [kSourceManager checkDeviceStatus];
        [[NSUserDefaults standardUserDefaults] setObject:kValueNO forKey:kCubeConnection];
    }
    
    [self performSelector:@selector(dismissLoading) withObject:nil afterDelay:1.5];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    UITableViewCell *cell = [self cellWithImage:[UIImage imageNamed:@"edit_delfromhome"] title:@"cube-000001"];
    
    CGRect frame = CGRectMake(CGRectGetWidth(tableView.frame)-80, (_rowHeight - 30) /2, 60, 30);
    UISwitch *switcher = [[UISwitch alloc] initWithFrame:frame];
    
    [switcher setOn:_isOn animated:YES];
    switcher.tag = indexPath.row;
    [switcher addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switcher];

    
    
    return cell;
}


@end
