//
//  VISBaseViewController.m
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"

@interface VISBaseViewController ()
{
    CGFloat _viewMaxWidth;
    CGFloat _viewMaxHeight;
}

- (UIScrollView *)createScrollView;

@end

@implementation VISBaseViewController
@synthesize contentScrollView;
@synthesize viewMaxWidth = _viewMaxWidth;
@synthesize viewMaxHeight = _viewMaxHeight;

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _viewMaxWidth = [UPDeviceInfo screenSize].width;
    _viewMaxHeight = [UPDeviceInfo screenSize].height - 64;
    self.contentScrollView = [self createScrollView];
    [self.view addSubview:self.contentScrollView];
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

#pragma mark - Member Funtions

- (UIScrollView *)createScrollView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = self.viewMaxHeight;
    NSLog(@"%@", NSStringFromCGRect(frame));
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    
    return scrollView;
}

@end
