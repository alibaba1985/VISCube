//
//  VISAboutViewController.m
//  VISCube
//
//  Created by liwang on 14-8-14.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISAboutViewController.h"
#import "VISViewCreator.h"

@interface VISAboutViewController ()

@end

@implementation VISAboutViewController

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
    self.title = @"版本信息";
    CGFloat y = 60;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 24 : 18;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    CGRect frame = CGRectMake(0, y, self.viewMaxWidth, 44);
    VISLabel *name = [VISViewCreator middleTruncatingLabelWithFrame:frame
                                                               text:@"产品名称:卫仕魔方" font:font textColor:[UIColor blackColor]];
    [self.view addSubview:name];
    frame.origin.y += 60;
    VISLabel *version = [VISViewCreator middleTruncatingLabelWithFrame:frame
                                                               text:@"产品版本:v1.0.0" font:font textColor:[UIColor blackColor]];
    [self.view addSubview:version];
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

@end
