//
//  VISRegisterViewController.m
//  VISCube
//
//  Created by liwang on 14-8-5.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISRegisterViewController.h"

@interface VISRegisterViewController ()

@end

@implementation VISRegisterViewController

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
    self.title = @"注册";
    _loadingMessage = @"正在玩儿命注册...";
    [_mainButton setTitle:@"注    册" forState:UIControlStateNormal];
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

#pragma mark - Override

- (void)addHelpInfos
{
    
}

- (void)gotoNextPage
{
    [self showToastMessage:@"注册成功！\n请登录。"];
    [self.navigationController popViewControllerAnimated:YES];

}

@end
