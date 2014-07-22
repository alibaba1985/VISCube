//
//  VISRootViewController.m
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISRootViewController.h"
#import "VISLoginViewController.h"
#import "VISHomeViewController.h"

@interface VISRootViewController ()
{
    VISLoginViewController *_loginVC;
}



- (void)createScrolls;

- (void)showLoginAction:(id)sender;

@end

@implementation VISRootViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    _loginVC = [[VISLoginViewController alloc] init];
    //[self.view addSubview:_loginVC.view];
    
    [self createScrolls];
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

#pragma mark - Member Functions



- (void)createScrolls
{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startBtn setFrame:CGRectMake(50, 300, 220, 60)];
    [startBtn addTarget:self action:@selector(showLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"开始体验" forState:UIControlStateNormal];
    [self.contentScrollView addSubview:startBtn];
}



- (void)showLoginAction:(id)sender
{
    VISHomeViewController *home = [[VISHomeViewController alloc] init];
    [self presentViewController:home animated:YES completion:nil];

}

@end
