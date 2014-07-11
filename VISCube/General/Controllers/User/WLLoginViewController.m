//
//  WLLoginViewController.m
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "WLLoginViewController.h"
#import "RESideMenu.h"


@interface WLLoginViewController ()
{
    
}

- (void)loginAction:(id)sender;

@end

@implementation WLLoginViewController

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
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startBtn setFrame:CGRectMake(50, 300, 220, 60)];
    [startBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"开始注册" forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
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

- (void)loginAction:(id)sender
{
    
}

@end
