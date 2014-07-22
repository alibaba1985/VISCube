//
//  VISHomeViewController.m
//  VISCube
//
//  Created by liwang on 14-7-8.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISHomeViewController.h"
#import "UIImage+ImageEffects.h"
#import "UPDeviceInfo.h"
#import "PNBarChart.h"


#define kAutoScrollAnchor 160

@interface VISHomeViewController ()
{
    UIImageView *_fixedBackground;
    UIImageView *_changeableBackground;
    UIView *_changeableContentView;
    CGRect _changeableContentFrame;
    CGRect _changeableBackgroundFrame;
    
    CGFloat _changeableOriginalY;
    
    PNBarChart *_barChart;

}

- (void)addFixedBackground;

- (void)addChangeableBackground;

- (void)addWeekKWH;

@end

@implementation VISHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIImageView *)imageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bg = [[UIImageView alloc] initWithImage:image];
    //bg.contentMode = UIViewContentModeScaleAspectFill;
    //bg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bg.frame = frame;
    
    return bg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _changeableOriginalY = [UPDeviceInfo screenSize].width;
    [self addFixedBackground];
    [self addChangeableBackground];
    
    [self addWeekKWH];
    
    CGFloat y = _changeableOriginalY;
    
    for (NSInteger i = 0; i <15; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 200, 30)];
        label.text = @"test";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [self.contentScrollView addSubview:label];
        y += 70 ;
    }
    
    
    CGSize size = self.contentScrollView.bounds.size;
    size.height = y;
    self.contentScrollView.contentSize = size;
    self.contentScrollView.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
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

#pragma mark - add Week Chart

- (void)addWeekKWH
{
    CGRect frame = CGRectMake(20, 320, 280, 200);
    
    NSArray *yValues = @[@"50",@"100",@"20",@"60",@"30",@"70"];
    NSArray *xValues = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月"];
    
    _barChart = [[PNBarChart alloc] initWithFrame:frame bars:yValues];
    _barChart.backgroundColor = [UIColor clearColor];
    [self.contentScrollView addSubview:_barChart];
    [_barChart setYValues:yValues];
    [_barChart setXLabels:xValues];
    [_barChart strokeChart];
}

#pragma mark- Background ImageView

- (void)addFixedBackground
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= 64;
    UIImage *bgImage = [UIImage imageNamed:@"HomeBG.jpg"];//
    _fixedBackground = [self imageViewWithImage:bgImage frame:frame];
    [self.view insertSubview:_fixedBackground atIndex:0];
}

- (void)addChangeableBackground
{
    CGFloat contentHeight = self.viewMaxHeight - _changeableOriginalY;
    _changeableContentFrame = CGRectMake(0, _changeableOriginalY, self.viewMaxWidth, contentHeight);
    _changeableBackgroundFrame = CGRectMake(0, -_changeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);

    UIImage *bgImage = [UIImage imageNamed:@"HomeBG.jpg"];//
    _changeableBackground = [self imageViewWithImage:[bgImage applyDarkEffect] frame:_changeableBackgroundFrame];
    
    _changeableContentView = [[UIView alloc] initWithFrame:_changeableContentFrame];
    _changeableContentView.clipsToBounds = YES;
    
    [_changeableContentView addSubview:_changeableBackground];
    [self.view insertSubview:_changeableContentView aboveSubview:_fixedBackground];
}



#pragma mark- ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = scrollView.contentOffset.y;
    CGRect frame = _changeableContentFrame;
    frame.origin.y -= offset;
    frame.size.height += offset;
    
    // 最多到顶，但是scrollView的contentOffset是跳跃的不是连续的。
    if (offset >= (_changeableOriginalY - self.viewMaxHeight)) {
        _changeableContentView.frame = frame;
        frame = _changeableBackgroundFrame;
        frame.origin.y += offset;
        _changeableBackground.frame = frame;
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        return;
    }
    
    CGFloat offset = scrollView.contentOffset.y;
    if (offset >0 && offset <= kAutoScrollAnchor) {
        CGRect rect = CGRectMake(0, 0, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
    }
    else if (offset > kAutoScrollAnchor && offset <= _changeableOriginalY) {
        CGRect rect = CGRectMake(0, _changeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset >0 && offset <= kAutoScrollAnchor) {
        CGRect rect = CGRectMake(0, 0, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
    }
    else if (offset > kAutoScrollAnchor && offset <= _changeableOriginalY) {
        CGRect rect = CGRectMake(0, _changeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
        
    }
}

@end
