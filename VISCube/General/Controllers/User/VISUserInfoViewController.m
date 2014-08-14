//
//  VISUserInfoViewController.m
//  VISCube
//
//  Created by liwang on 14-8-14.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISUserInfoViewController.h"
#import "VISResetPwdViewController.h"
#import "VISLoginViewController.h"


#define kButtonWidth 260

@interface VISUserInfoViewController ()

@end

@implementation VISUserInfoViewController

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
    self.title = @"用户详情";
    _rowHeight = [UPDeviceInfo isPad] ? 80 : 60;
    self.tableView = [self tableViewWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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
 
        case 1:
        {
            VISResetPwdViewController *reset = [[VISResetPwdViewController alloc] init];
            [self.navigationController pushViewController:reset animated:YES];
        }
            break;
        case 2:
        {
            VISLoginViewController *login = [[VISLoginViewController alloc] init];
            login.reLogin = YES;
            [login showModalBarButtonWithTitle:@"放弃"];
            UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:login];
            [self presentViewController:n animated:YES completion:^{
                
            }];
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
    return _rowHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}



- (void)buttonAction
{
    VISLoginViewController *login = [[VISLoginViewController alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:login];
    [UIApplication sharedApplication].keyWindow.rootViewController = n;
    [[NSUserDefaults standardUserDefaults] setObject:kValueNO forKey:kLoginned];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"userCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        
        // add next
        CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
        UIImage *next = [UIImage imageNamed:@"next"];
        CGFloat nextHeight = next.size.height/3;
        CGFloat nextWidth = next.size.width/3;
        CGFloat y = (_rowHeight-nextHeight)/2;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:next];
        imageView.frame = CGRectMake(self.viewMaxWidth - margin - nextWidth, y, nextWidth, nextHeight);
        imageView.tag = 100;
        [cell.contentView addSubview:imageView];
    }
    
    UIView *view = [cell.contentView viewWithTag:100];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
            view.hidden = YES;
        }
            
            break;
        case 1:
            cell.textLabel.text = @"修改登录密码";
            break;
        case 2:
            cell.textLabel.text = @"切换用户";
            break;
        case 3:
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((CGRectGetWidth(tableView.frame)-kButtonWidth)/2, (_rowHeight-44)/2, kButtonWidth, 44);
            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"退出登录" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"turnoff"] forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
            cell.userInteractionEnabled = YES;
            
            view.hidden = YES;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


@end
