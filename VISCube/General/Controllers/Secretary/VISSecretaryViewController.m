//
//  VISSecretaryViewController.m
//  VISCube
//
//  Created by liwang on 14-7-27.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISSecretaryViewController.h"
#import "VISWebViewController.h"
#import "VISRankViewController.h"
#import "VISStatisticViewController.h"
#import "VISOptimizerViewController.h"
#import "VISStatusViewController.h"


@interface VISSecretaryViewController ()
{
    NSArray *_titles;
}

@end

@implementation VISSecretaryViewController

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
    self.title = @"卫仕秘书";
    self.tableView = [self tableViewWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self addNavigationMenuItem];
    
    _titles = @[@"我的耗电统计", @"我的用电排名", @"我的优化方案", @"我的设备状况", @"为您推荐"];
    
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
    switch (indexPath.row) {
        case 0:
        {
            VISStatisticViewController *statisticVC = [[VISStatisticViewController alloc] init];
            [self.navigationController pushViewController:statisticVC animated:YES];
        }
            
            break;
        case 1:
        {
            VISRankViewController *rankVC = [[VISRankViewController alloc] init];
            [self.navigationController pushViewController:rankVC animated:YES];
        }
            break;
        case 2:
        {
            VISOptimizerViewController *optimizerVC = [[VISOptimizerViewController alloc] init];
            [self.navigationController pushViewController:optimizerVC animated:YES];
        }
            break;
        case 3:
        {
            VISStatusViewController *statusVC = [[VISStatusViewController alloc] init];
            [self.navigationController pushViewController:statusVC animated:YES];
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [UPDeviceInfo isPad] ? 80 : 60;
    
    if (indexPath.section == 3) {
        height = 100;
    }
    else if (indexPath.section == 4)
    {
        height = 200;
    }

    
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 1;
}

- (NSAttributedString *)textWithPrefix:(NSString *)prefixString colorString:(NSString *)colorString sufixString:(NSString *)sufixString
{
    NSString *text = [NSString stringWithFormat:@"%@%@%@", prefixString, colorString, sufixString];
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor blackColor],
                                 };;
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    NSRange colorRange = [text rangeOfString:colorString options:NSLiteralSearch];;
    [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f]}
                        range:colorRange];
    
    return attrString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"rankCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    
    switch (indexPath.section) {
        case 0:
        {
            NSAttributedString *text = [self textWithPrefix:@"当月用电量：" colorString:@"126.00" sufixString:@" 元"];
            cell.textLabel.attributedText = text;
            
            text = [self textWithPrefix:@"2014年度用电量：" colorString:@"1250.00" sufixString:@" 元"];
            cell.detailTextLabel.attributedText = text;
        }
            
            break;
        case 1:
        {
            NSAttributedString *text = [self textWithPrefix:@"月度用电排名：" colorString:@"128" sufixString:@" 名"];
            cell.textLabel.attributedText = text;
            
            text = [self textWithPrefix:@"2014年度用电排名：" colorString:@"190" sufixString:@" 名"];
            cell.detailTextLabel.attributedText = text;
        }
            break;
        case 2:
        {
            NSAttributedString *text = [self textWithPrefix:@"通过优化，您可以节约" colorString:@"12.80" sufixString:@"元"];
            cell.textLabel.attributedText = text;
            
            text = [self textWithPrefix:@"当前已经有" colorString:@"1200" sufixString:@"用户选择了优化"];
            cell.detailTextLabel.attributedText = text;
        }
            break;
        case 3:
        {
            NSAttributedString *text = [self textWithPrefix:@"" colorString:@"客厅空调" sufixString:@"连续工作12.30小时，耗电21.00KWH"];
            cell.textLabel.attributedText = text;
            cell.detailTextLabel.text = @"设备总数：8\n工作数：3";
            cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
            cell.textLabel.numberOfLines = 0;
            
            cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
            cell.detailTextLabel.numberOfLines = 0;
        }
            break;
        case 4:
        {
            CGRect adContentFrame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 200);
            XLCycleScrollView *csView = [[XLCycleScrollView alloc] initWithFrame:adContentFrame];
            csView.backgroundColor = [UIColor clearColor];
            csView.delegate = self;
            csView.datasource = self;
            [cell.contentView addSubview:csView];
        }
            break;
            
        default:
            break;
    }
    
    
    
    // add next
    if (indexPath.section != 4) {
        CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
        UIImage *next = [UIImage imageNamed:@"next"];
        CGFloat nextHeight = next.size.height/3;
        CGFloat nextWidth = next.size.width/3;
        CGFloat cellHeight = (indexPath.section == 3) ? 100 : ([UPDeviceInfo isPad] ? 80 : 60);
        CGFloat y = (cellHeight-nextHeight)/2;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:next];
        imageView.frame = CGRectMake(self.viewMaxWidth - margin - nextWidth, y, nextWidth, nextHeight);
        [cell.contentView addSubview:imageView];
    }
    
    
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

#pragma mark- XLCycleScrollViewDelegate

- (NSInteger)numberOfPages
{
    return 5;
}

- (UIView *)scrollView:(XLCycleScrollView *)scrollView pageAtIndex:(NSInteger)index
{
    NSString *imageName = nil;
    
    switch (index) {
        case 0:
            imageName = @"ad01.jpg";
            break;
        case 1:
            imageName = @"ad02.jpg";
            break;
        case 2:
            imageName = @"ad03.jpg";
            break;
        case 3:
            imageName = @"ad04.jpg";
            break;
        case 4:
            imageName = @"ad05.jpg";
            break;
        case 5:
            imageName = @"ad06.jpg";
            break;
            
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = scrollView.bounds;
    imageView.backgroundColor = [UIColor clearColor];
    
    return imageView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    NSString *urlString = @"http://www.163.com";
    VISWebViewController *web = [[VISWebViewController alloc] initWithUrl:[NSURL URLWithString:urlString] barTitle:nil];
    [self.navigationController pushViewController:web animated:YES];
    
}


@end
