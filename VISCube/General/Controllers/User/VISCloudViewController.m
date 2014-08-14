//
//  VISCloudViewController.m
//  VISCube
//
//  Created by liwang on 14-8-14.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISCloudViewController.h"

@interface VISCloudViewController ()

@end

@implementation VISCloudViewController

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
    self.title = @"云同步";
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


- (void)endCloud
{
    [self showToastMessage:@"同步成功!"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showLoadingWithMessage:@"正在同步,请稍候..."];
    [self performSelector:@selector(endCloud) withObject:nil afterDelay:1.5];
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



- (UITableViewCell *)cellWithImage:(UIImage *)image title:(NSString *)title
{
    CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
    
    CGFloat height = 27;
    CGFloat y = (_rowHeight - height) / 2;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 24 : 18;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat x = (self.viewMaxWidth-height-margin-titleSize.width)/2;
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    // add head image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(x, y, height, height);
    [cell.contentView addSubview:imageView];
    
    // add title
    x += (margin + height);
    
    CGRect titleFrame = CGRectMake(x, y, self.viewMaxWidth-x, height);
    VISLabel *titleLabel = [VISViewCreator wrapLabelWithFrame:titleFrame
                                                         text:title
                                                         font:font
                                                    textColor:[UIColor blackColor]];
    
    titleLabel.verticalAlignment = VISVerticalAlignmentMiddle;
    
    
    
    
    
    
    [cell.contentView addSubview:titleLabel];
    
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    UITableViewCell *cell = [self cellWithImage:[UIImage imageNamed:@"cloud"] title:@"开始同步..."];
    
    
    return cell;
}



@end
