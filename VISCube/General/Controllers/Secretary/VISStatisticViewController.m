//
//  VISStatisticViewController.m
//  VISCube
//
//  Created by liwang on 14-8-11.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISStatisticViewController.h"
#import "UPFile.h"
#import "PNBarChart.h"

@interface VISStatisticViewController ()
{
    CGFloat _rowHeight;
    NSArray *_titles;
    NSMutableArray *_barViews;
}

@end

@implementation VISStatisticViewController

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
    self.title = @"用电统计";
    _rowHeight = [UPDeviceInfo isPad] ? 400 : 200;
    self.tableView = [self tableViewWithStyle:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
    
    _barViews = [[NSMutableArray alloc] init];
    _titles = @[@"月耗电统计(元)", @"年度耗电统计(元)", @"设备耗电统计(元)"];
}


//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [_barViews makeObjectsPerformSelector:@selector(stokeChartAnimation)];
//}

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
- (NSArray *)devicesBars
{
    NSString *path = [UPFile pathForFile:kFileName writable:NO];
    NSArray *bars = [NSArray arrayWithArray:[UPFile readFile:path forKey:@"Devices"]];;
    return bars;
}

- (NSArray *)yearBars
{
    NSString *path = [UPFile pathForFile:kFileName writable:NO];
    NSArray *bars = [NSArray arrayWithArray:[UPFile readFile:path forKey:@"YearMoney"]];;
    return bars;
}

- (NSArray *)monthBars
{
    NSString *path = [UPFile pathForFile:kFileName writable:NO];
    NSArray *bars = [NSArray arrayWithArray:[UPFile readFile:path forKey:@"MonthMoney"]];;
    return bars;
}

- (PNBarChart *)barViewWithFrame:(CGRect)frame Bars:(NSArray *)bars
{
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:frame bars:bars];
    barChart.backgroundColor = [UIColor clearColor];
    barChart.barDelayDuration = 0.15;
    [barChart strokeChart];
    return barChart;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    cell.userInteractionEnabled = NO;
    CGRect barFrame = CGRectZero;
    NSArray *bars = nil;
    switch (indexPath.section) {
        case 0:
            barFrame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), _rowHeight);
            bars = [self monthBars];
            break;
        case 1:
            barFrame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), _rowHeight);
            bars = [self yearBars];
            break;
        case 2:
            barFrame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), _rowHeight);
            bars = [self devicesBars];
            break;
            
        default:
            break;
    }

    
    
    PNBarChart *barChart = [self barViewWithFrame:barFrame Bars:bars];
    [cell.contentView addSubview:barChart];
    [_barViews addObject:barChart];
    [barChart stokeChartAnimation];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(10, 0, CGRectGetWidth(tableView.frame) - 20, 30);
    NSString *text = _titles[section];
    CGFloat fontSize = [UPDeviceInfo isPad] ? 20 : 18;
    VISLabel *headLabel = [VISViewCreator wrapLabelWithFrame:frame text:text font:[VISViewCreator defaultFontWithSize:fontSize] textColor:[UIColor blackColor]];
    headLabel.backgroundColor = self.view.backgroundColor;
    return headLabel;
}


@end
