//
//  DEMOMenuViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "VISLeftMenuViewController.h"
#import "VISSourceManager.h"
#import "UPDeviceInfo.h"

@interface VISLeftMenuViewController ()
{
    CGFloat _tableCellRowHeight;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation VISLeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _tableCellRowHeight = [UPDeviceInfo isPad] ? 80 : 60;
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - _tableCellRowHeight * 6) / 2.0f, self.view.frame.size.width, _tableCellRowHeight * 6) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = [[VISSourceManager currentSource].menuViewControllers objectAtIndex:indexPath.row];
    
    [self.sideMenuViewController setContentViewController:viewController
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.textLabel.font = [UPDeviceInfo isPad] ? [UIFont fontWithName:@"HelveticaNeue" size:30] : cell.textLabel.font;
    }
    
    NSArray *titles = @[@"首页", @"卫仕管家", @"卫仕秘书", @"卫仕商城", @"卫仕魔方", @"卫仕中心"];
    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconSettings", @"IconProfile"];
    cell.textLabel.text = titles[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

@end
