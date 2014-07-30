//
//  VISAccountViewController.m
//  VISCube
//
//  Created by liwang on 14-7-30.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISAccountViewController.h"


@interface VISAccountViewController ()
{
    NSDictionary *_userAccountInfo;
    CGFloat _tableCellRowHeight;
    CGFloat _avatarCellRowHeight;
    NSInteger _cellNumber;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;
@end

@implementation VISAccountViewController

- (id)initWithUserAccountInfo:(NSDictionary *)userAccountInfo
{
    self = [super init];
    if (self) {
        // Custom initialization
        _userAccountInfo = [NSDictionary dictionaryWithDictionary:userAccountInfo];
    }
    return self;
}


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
    
    /**
     头像
     账户名
     当前居所->切换居所
     绑定手机
     修改密码
     
     
     **/
    
    
    
    // Do any additional setup after loading the view.
    _cellNumber = 5;
    _tableCellRowHeight = [UPDeviceInfo isPad] ? 80 : 60;
    _avatarCellRowHeight = [UPDeviceInfo isPad] ? 120 : 80;
    CGFloat tableHeight = _avatarCellRowHeight + (_cellNumber-1)*_tableCellRowHeight;
    CGFloat y = (self.viewMaxHeight - tableHeight) / 2;
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.viewMaxWidth, tableHeight) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.bounces = NO;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 0) ? _avatarCellRowHeight : _tableCellRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return _cellNumber;
}

- (UITableViewCell *)cellWithImage:(UIImage *)image title:(NSString *)title
{
    CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
    CGFloat x = margin;
    CGFloat y = margin;
    CGFloat height = _avatarCellRowHeight - margin * 2;
    
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
    
    // add next
    UIImage *next = [UIImage imageNamed:@"next"];
    CGFloat nextHeight = next.size.height/3;
    CGFloat nextWidth = next.size.width/3;
    y = (_tableCellRowHeight-nextHeight)/2;
    imageView = [[UIImageView alloc] initWithImage:next];
    imageView.frame = CGRectMake(self.viewMaxWidth - margin - nextWidth, y, nextWidth, nextHeight);
    [cell.contentView addSubview:imageView];
    
    
    return cell;
}

- (UITableViewCell *)cellWithTitle:(NSString *)title
{
    CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
    CGFloat x = margin;
    CGFloat y = margin;
    CGFloat height = _avatarCellRowHeight - margin * 2;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // add title
    CGFloat fontSize = [UPDeviceInfo isPad] ? 24 : 18;
    CGRect titleFrame = CGRectMake(x, y, self.viewMaxWidth-x, height);
    VISLabel *titleLabel = [VISViewCreator wrapLabelWithFrame:titleFrame
                                                         text:title
                                                         font:
                            [UIFont fontWithName:@"HelveticaNeue" size:fontSize]
                                                    textColor:[UIColor blackColor]];
    
    titleLabel.verticalAlignment = VISVerticalAlignmentMiddle;
    [cell.contentView addSubview:titleLabel];
    
    // add next
    UIImage *next = [UIImage imageNamed:@"next"];
    CGFloat nextHeight = next.size.height/3;
    CGFloat nextWidth = next.size.width/3;
    y = (_tableCellRowHeight-nextHeight)/2;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:next];
    imageView.frame = CGRectMake(self.viewMaxWidth - margin - nextWidth, y, nextWidth, nextHeight);
    [cell.contentView addSubview:imageView];
    
    
    return cell;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell =  [self cellWithImage:[UIImage imageNamed:@"1"] title:@"头像"];
    }else {
        cell = [self cellWithTitle:@"账户信息"];
    }
    
    return cell;
}


@end
