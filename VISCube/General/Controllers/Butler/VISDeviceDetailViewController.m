//
//  VISDeviceDetailViewController.m
//  VISCube
//
//  Created by liwang on 14-7-26.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISDeviceDetailViewController.h"
#import "UPDeviceInfo.h"

@interface VISDeviceDetailViewController ()
{
    NSDictionary *_deviceDetails;
    CGFloat _tableCellRowHeight;
    NSInteger _cellNumber;
    NSArray *_titles;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation VISDeviceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithDeviceDetails:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        // Custom initialization
        _deviceDetails = [NSDictionary dictionaryWithDictionary:details];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备详情";
    _titles = @[@"设备名称:", @"设备位置:", @"设备状态:", @"启用时间:", @"工作时间:", @"总耗电量:", @"总耗电费:"];
    CGFloat y = 30;
    CGFloat imageSize = 112;
    UIImage *image = [UIImage imageNamed:[_deviceDetails objectForKey:kDeviceImage]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake((self.viewMaxWidth - imageSize)/2, y, imageSize, imageSize);
    [self.view addSubview:imageView];
    
    y += (30 + imageSize);
    
    _cellNumber = _deviceDetails.allKeys.count-1;
    _tableCellRowHeight = [UPDeviceInfo isPad] ? 60 : 44;
    CGFloat tableHeight = (_cellNumber*_tableCellRowHeight>(self.viewMaxHeight - 60 - imageSize)) ? self.viewMaxHeight-y : _cellNumber*_tableCellRowHeight;
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.viewMaxWidth, tableHeight) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.userInteractionEnabled = (tableHeight == self.viewMaxHeight-y) ? YES : NO;
        tableView;
    });
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

}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableCellRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return _cellNumber;
}

- (NSString *)contentAtRow:(NSInteger)row
{
    NSString *content = nil;
    switch (row) {
        case 0:
            content = [_deviceDetails objectForKey:kDeviceName];
            break;
        case 1:
            content = [_deviceDetails objectForKey:kDeviceLocation];
            break;
        case 2:
        {
            NSString *status = [_deviceDetails objectForKey:kDeviceStatus];
            if ([status isEqualToString:kValue0]) {
                content = @"已开启";
            }else if ([status isEqualToString:kValue1]){
                content = @"已关闭";
            }else if ([status isEqualToString:kValue2]){
                content = @"已损坏";
            }
        }
            break;
        case 3:
            content = [_deviceDetails objectForKey:kDeviceStartTime];
            break;
        case 4:
            content = [_deviceDetails objectForKey:kDeviceActiveTime];
            break;
        case 5:
            content = [_deviceDetails objectForKey:kDeviceTotalPower];
            break;
        case 6:
            content = [_deviceDetails objectForKey:kDeviceTotalMoney];
            break;
        
            
        default:
            break;
    }
    
    return content;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSInteger row = [indexPath row];
    
    NSString *content = [self contentAtRow:row];
    NSString *title = [_titles objectAtIndex:row];
    
    CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
    CGFloat labelHeight = [UPDeviceInfo isPad] ? 26 : 20;
    CGFloat y = (_tableCellRowHeight-labelHeight)/2;
    CGFloat titleWidth = [UPDeviceInfo isPad] ? 120 : 100;
    CGRect titleFrame = CGRectMake(margin, y, titleWidth, labelHeight);
    VISLabel *titleLabel = [VISViewCreator wrapLabelWithFrame:titleFrame
                            text:title
                            font:[UIFont fontWithName:@"HelveticaNeue" size:labelHeight-2]
                       textColor:[UIColor blackColor]];
    
    titleLabel.verticalAlignment = VISVerticalAlignmentMiddle;
    [cell.contentView addSubview:titleLabel];
    
    CGRect contentFrame = CGRectMake(margin+titleWidth, y, CGRectGetWidth(tableView.frame)-margin-titleWidth, labelHeight);
    VISLabel *contentLabel = [VISViewCreator
                wrapLabelWithFrame:contentFrame
                              text:content
                              font:[UIFont fontWithName:@"HelveticaNeue" size:labelHeight-2]
                         textColor:[UIColor blackColor]];
    contentLabel.verticalAlignment = VISVerticalAlignmentMiddle;
    [cell.contentView addSubview:contentLabel];
    
    return cell;
}


@end
