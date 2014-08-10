//
//  VISPreShowViewController.m
//  VISCube
//
//  Created by liwang on 14-8-5.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISPreShowViewController.h"
#import "VISViewCreator.h"
#import "VISLoginViewController.h"
#import "UPFile.h"

@interface VISPreShowViewController ()
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

- (void)addScrollViewBG;

- (void)addScrollView;


- (UIView *)welcomeViewWithText1:(NSString *)text1
                           text2:(NSString *)text2
                           text3:(NSString *)text3;

- (void)startAction;

@end

@implementation VISPreShowViewController

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
    [self addScrollViewBG];
    [self addScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
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

#pragma mark - subviews

- (void)addScrollViewBG
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.contentScrollView.frame = frame;
    UIImage *image = [UIImage imageNamed:@"PreBG_01.jpg"];
    UIImageView *bg = [[UIImageView alloc] initWithImage:image];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bg.frame = CGRectMake(0, 0, self.viewMaxWidth*3, [UPDeviceInfo screenSize].height);
    [self.contentScrollView addSubview:bg];
    self.contentScrollView.contentSize = CGSizeMake(self.viewMaxWidth*3, [UPDeviceInfo screenSize].height);
    self.contentScrollView.userInteractionEnabled = NO;
}

- (void)addScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.delegate = self;
    _scrollView.contentSize = self.contentScrollView.contentSize = CGSizeMake(self.viewMaxWidth*3, [UPDeviceInfo screenSize].height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    // page 1
    UIView *view = [self welcomeViewWithText1:@"最专业的用电专家"
                                        text2:@"全方位的用电优化"
                                        text3:@"最安全的设备管理"];
    
    [_scrollView addSubview:view];
    
    CGRect pageFrame = view.frame;
    
    // page 2
    view = [self welcomeViewWithText1:@"电器安全实时报警"
                                text2:@"用电数据动态分析"
                                text3:@"社区用电数据排名"];
    pageFrame.origin.x += self.viewMaxWidth;
    view.frame = pageFrame;
    [_scrollView addSubview:view];
    
    // page 3
    view = [self welcomeViewWithText1:@"给您推荐最适合您的"
                                text2:@"开始体验吧~"
                                text3:nil];
    pageFrame.origin.x += self.viewMaxWidth;
    view.frame = pageFrame;
    [_scrollView addSubview:view];
    
    CGFloat width = [UPDeviceInfo isPad] ? 180 : 160;
    CGFloat height = [UPDeviceInfo isPad] ? 60 : 50;
    CGFloat margin = [UPDeviceInfo isPad] ? 150 : 120;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.viewMaxWidth-width)/2, _scrollView.frame.size.height - margin, width, height);
    button.layer.cornerRadius = 4;
    [button setTitle:@"出发" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    // pagecontrol
    CGRect frame = _scrollView.frame;
    margin = [UPDeviceInfo isPad] ? 60 : 40;
    frame.origin.y = frame.size.height - margin;
    frame.size.height = 20;
    _pageControl = [[UIPageControl alloc] initWithFrame:frame];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    [self.view addSubview:_pageControl];
}

- (void)startAction
{
    //[self.view removeFromSuperview];
    __block VISPreShowViewController *weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.view.alpha = 0.5;
        weakSelf.view.transform = CGAffineTransformMakeScale(2.0, 2.0);
    }completion:^(BOOL finished){
        [weakSelf.navigationController setNavigationBarHidden:NO];
        [weakSelf.navigationController popViewControllerAnimated:NO];
        NSString *path = [UPFile pathForFile:kLocalFileName writable:YES];
        [UPFile writeFile:path withValue:kValueNO forKey:kFirstSetup];
    }];
}



- (UIView *)welcomeViewWithText1:(NSString *)text1
                           text2:(NSString *)text2
                           text3:(NSString *)text3
{
    CGFloat x = 0;
    CGFloat y = [UPDeviceInfo isPad] ? 150 : 100;;
    CGFloat margin = [UPDeviceInfo isPad] ? 30 : 20;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 35 : 25;
    CGRect frame = CGRectMake(0, 0, self.viewMaxWidth, CGRectGetHeight(_scrollView.frame));
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    CGRect textFrame = CGRectMake(x, y, self.viewMaxWidth, fontSize);
    
    VISLabel *textLbel = [VISViewCreator
                       middleTruncatingLabelWithFrame:textFrame
                       text:text1
                       font:[VISViewCreator defaultFontWithSize:fontSize]
                       textColor:[UIColor whiteColor]];
    [view addSubview:textLbel];
    textFrame.origin.y += (fontSize + margin);
    
    textLbel = [VISViewCreator
                       middleTruncatingLabelWithFrame:textFrame
                       text:text2
                       font:[VISViewCreator defaultFontWithSize:fontSize]
                       textColor:[UIColor whiteColor]];
    [view addSubview:textLbel];
    textFrame.origin.y += (fontSize + margin);
    
    if (text3) {
        textLbel = [VISViewCreator
                    middleTruncatingLabelWithFrame:textFrame
                    text:text3
                    font:[VISViewCreator defaultFontWithSize:fontSize]
                    textColor:[UIColor whiteColor]];
        [view addSubview:textLbel];
    }
    
    
    return view;

}

- (UIView *)secondView
{
    CGFloat x = 0;
    CGFloat y = 100;
    CGFloat margin = [UPDeviceInfo isPad] ? 30 : 20;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 35 : 25;
    CGRect frame = CGRectMake(0, 0, self.viewMaxWidth, CGRectGetHeight(_scrollView.frame));
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    CGRect textFrame = CGRectMake(x, y, self.viewMaxWidth, fontSize);
    VISLabel *text1 = [VISViewCreator
                       middleTruncatingLabelWithFrame:textFrame
                       text:@"电器安全实时报警"
                       font:[VISViewCreator defaultFontWithSize:fontSize]
                       textColor:[UIColor whiteColor]];
    [view addSubview:text1];
    textFrame.origin.y += (fontSize + margin);
    
    VISLabel *text2 = [VISViewCreator
                       middleTruncatingLabelWithFrame:textFrame
                       text:@"用电数据动态分析"
                       font:[VISViewCreator defaultFontWithSize:fontSize]
                       textColor:[UIColor whiteColor]];
    [view addSubview:text2];
    textFrame.origin.y += (fontSize + margin);
    
    VISLabel *text3 = [VISViewCreator
                       middleTruncatingLabelWithFrame:textFrame
                       text:@"社区用电数据排名"
                       font:[VISViewCreator defaultFontWithSize:fontSize]
                       textColor:[UIColor whiteColor]];
    [view addSubview:text3];
    
    return view;
}

- (UIView *)thirdView
{
    CGFloat x = 0;
    CGFloat y = 100;
    CGFloat margin = [UPDeviceInfo isPad] ? 30 : 20;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 35 : 25;
    CGRect frame = CGRectMake(0, 0, self.viewMaxWidth, CGRectGetHeight(_scrollView.frame));
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    CGRect textFrame = CGRectMake(x, y, self.viewMaxWidth, fontSize);
    VISLabel *text1 = [VISViewCreator
                       middleTruncatingLabelWithFrame:textFrame
                       text:@"给您推荐最适合您的"
                       font:[VISViewCreator defaultFontWithSize:fontSize]
                       textColor:[UIColor whiteColor]];
    [view addSubview:text1];
    textFrame.origin.y += (fontSize + margin);
    
    VISLabel *text2 = [VISViewCreator
                       middleTruncatingLabelWithFrame:textFrame
                       text:@"开始体验吧~"
                       font:[VISViewCreator defaultFontWithSize:fontSize]
                       textColor:[UIColor whiteColor]];
    [view addSubview:text2];
    textFrame.origin.y += (fontSize + margin);
    

    
    return view;
}


#pragma mark - UISrollViewDelegate



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger offset = scrollView.contentOffset.x;
    _pageControl.currentPage = offset / self.viewMaxWidth;
    
    CGFloat aoffset = scrollView.contentOffset.x;
    CGRect rect = CGRectMake(aoffset, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
    [self.contentScrollView scrollRectToVisible:rect animated:YES];
}

@end
