//
//  VISButlerViewController.m
//  VISCube
//
//  Created by liwang on 14-7-24.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISButlerViewController.h"
#import "VISDevice.h"

@interface VISButlerViewController ()

- (void)addDevices;

@end

@implementation VISButlerViewController

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    [self addDevices];
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

- (void)addDevices
{
    CGRect frame = CGRectMake(50, 50, 100, 100);
    VISDevice *device = [[VISDevice alloc] initWithFrame:frame info:nil];
    [self.contentScrollView addSubview:device];
    
    frame = CGRectMake(50, 200, 100, 100);
    device = [[VISDevice alloc] initWithFrame:frame info:nil];
    [self.contentScrollView addSubview:device];
}

@end
