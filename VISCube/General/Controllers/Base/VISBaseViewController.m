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
    
    CPToast *_toast;
    UIAlertView *_alert;
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
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    
    return scrollView;
}


- (void)addNavigationMenuItem
{
    UIImage *image = [UIImage imageNamed:@"Menu.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    [button addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];;
    
    /*
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
     
     */
}

#pragma mark - Dialog

- (void)showToastMessage:(NSString *)message
{
    [self dismissLoading];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CPToast *toast = [[CPToast alloc] initWithMessage:message onView:window];
    [toast show];
}

- (void)showAlertMessage:(NSString *)message
{
    [self dismissLoading];
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [_alert show];
}

- (void)showLoadingWithMessage:(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _toast = [[CPToast alloc] initWithLoadingMessage:message onView:window];
    [_toast show];
}


- (void)dismissLoading
{
    if (_toast != nil) {
        [_toast dismiss];
        _toast = nil;
    }
}

@end
