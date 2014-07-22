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
#import "CPKenburnsView.h"
#import "UPLineView.h"


#define kAutoScrollAnchor 160

@interface VISHomeViewController ()
{
    UIImageView *_fixedBackground;
    UIImageView *_changeableBackground;
    UIView *_changeableContentView;
    CGRect _changeableContentFrame;
    CGRect _changeableBackgroundFrame;
    
    CGFloat _changeableOriginalY;
    CGFloat _yOffset;
    
    PNBarChart *_barChart;
    CPKenburnsView *_kenburnsView;
}

- (void)addFixedBackground;

- (void)addChangeableBackground;

- (void)addManagerImage;

- (void)addMainInfo;

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
    _yOffset = _changeableOriginalY;
    [self addFixedBackground];
    [self addChangeableBackground];
    [self addMainInfo];
    [self addWeekKWH];
    
    
    CGSize size = self.contentScrollView.bounds.size;
    size.height = _yOffset;
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

- (void)strokeAnimation
{
    [self addFixedBackground];
}

- (void)addManagerImage
{
    UIImage *manager = [UIImage imageNamed:@"Manager.jpg"];
    UIImageView *managerView = [[UIImageView alloc] initWithImage:manager];
    managerView.frame = CGRectMake(100, 160, 160, 160);
    managerView.contentMode = UIViewContentModeScaleAspectFill;
    managerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentScrollView addSubview:managerView];
    
    
}

- (void)addText1:(NSString *)text1
           text2:(NSString *)text2
           text3:(NSString *)text3
          onView:(UIView *)view
          offset:(CGFloat)offset
{
    CGFloat lMargin = 5;
    CGFloat y = offset;
    CGFloat x = lMargin;
    
    CGSize size = [text1 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    CGRect frame = CGRectMake(x, y, size.width, 50);
    
    VISLabel *tag1 = [VISViewCreator
                      wrapLabelWithFrame:frame
                      text:text1
                      font:[UIFont systemFontOfSize:14]
                      textColor:[UIColor whiteColor]];
    [view addSubview:tag1];
    
    x += size.width;
    
    size = [text2 sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30]}];
    
    frame = CGRectMake(x, y, size.width, 50);
    VISLabel *monthPower = [VISViewCreator
                            wrapLabelWithFrame:frame
                            text:text2
                            font:[UIFont systemFontOfSize:30]
                            textColor:[UIColor whiteColor]];
    [view addSubview:monthPower];
    
    x += size.width + lMargin;
    frame = CGRectMake(x, y, 50, 50);
    
    VISLabel *unit = [VISViewCreator
                      wrapLabelWithFrame:frame
                      text:text3
                      font:[UIFont systemFontOfSize:14]
                      textColor:[UIColor whiteColor]];
    [view addSubview:unit];
    
    
}

- (void)addMainInfo
{
    CGRect frame = CGRectMake(0, _changeableOriginalY, self.viewMaxWidth, self.viewMaxHeight - _changeableOriginalY);
    UIView *mainInfoView = [[UIView alloc] initWithFrame:frame];
    mainInfoView.backgroundColor = [UIColor clearColor];
    [self.contentScrollView addSubview:mainInfoView];
    
    [self addText1:@"本月用电" text2:@"158.68" text3:@"KWH" onView:mainInfoView offset:0];
    [self addText1:@"本月电费" text2:@"79.34" text3:@"元" onView:mainInfoView offset:60];
    CGRect lineFrame = CGRectMake(0, 120, self.viewMaxWidth, 1);
    UPLineView *line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.6 alpha:1]];
    [mainInfoView addSubview:line];
    
    [self addText1:@"卫仕魔方本月为您节省了" text2:@"11.22" text3:@"元" onView:mainInfoView offset:120];
    
    _yOffset += self.viewMaxHeight - self.viewMaxWidth;
    
}

#pragma mark - add Week Chart

- (void)addWeekKWH
{
    CGFloat labelHeight = 30;
    CGRect labelFrame = CGRectMake(0, _yOffset, self.viewMaxWidth, labelHeight);
    VISLabel *label = [VISViewCreator wrapLabelWithFrame:labelFrame text:@"年度用电统计  " font:[UIFont systemFontOfSize:16] textColor:[UIColor whiteColor]];
    label.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    label.verticalAlignment = VISVerticalAlignmentMiddle;
    label.textAlignment = NSTextAlignmentRight;
    [self.contentScrollView addSubview:label];
    
    CGRect lineFrame = CGRectMake(0, _yOffset, self.viewMaxWidth, 0.5);
    UPLineView *line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.3 alpha:0.8]];
    [self.contentScrollView addSubview:line];
    
    _yOffset += labelHeight;
   
    NSArray *yValues = @[@"50",@"100",@"20",@"60",@"30",@"70"];
    NSArray *xValues = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月"];
    
    CGRect barFrame = CGRectMake(0, _yOffset, self.viewMaxWidth, 200);
    _barChart = [[PNBarChart alloc] initWithFrame:barFrame bars:yValues];
    _barChart.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    [self.contentScrollView addSubview:_barChart];
    [_barChart setYValues:yValues];
    [_barChart setXLabels:xValues];
    [_barChart strokeChart];
    
    _yOffset += 200;
    
    lineFrame = CGRectMake(0, _yOffset-0.5, self.viewMaxWidth, 0.5);
    line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.3 alpha:0.8]];
    [self.contentScrollView addSubview:line];
    
}

#pragma mark- Background ImageView

- (void)addFixedBackground
{
    if (_kenburnsView != nil) {
        [_kenburnsView removeFromSuperview];
        _kenburnsView = nil;
    }
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= 64;
    _kenburnsView = [[CPKenburnsView alloc] initWithFrame:frame];
    _kenburnsView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view insertSubview:_kenburnsView atIndex:0];
}

- (void)addChangeableBackground
{
    CGFloat contentHeight = self.viewMaxHeight - _changeableOriginalY;
    _changeableContentFrame = CGRectMake(0, _changeableOriginalY, self.viewMaxWidth, contentHeight);
    _changeableBackgroundFrame = CGRectMake(0, -_changeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);

    UIImage *bgImage = [UIImage imageNamed:@"AlphaBG.jpg"];//
    UIImage *newImage = [bgImage applyDarkEffect];
    _changeableBackground = [self imageViewWithImage:newImage frame:_changeableBackgroundFrame];
    
    _changeableContentView = [[UIView alloc] initWithFrame:_changeableContentFrame];
    _changeableContentView.clipsToBounds = YES;
    
    [_changeableContentView addSubview:_changeableBackground];
    [self.view insertSubview:_changeableContentView aboveSubview:_kenburnsView];
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
