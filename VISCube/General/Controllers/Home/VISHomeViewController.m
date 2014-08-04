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
#import "VISWebViewController.h"
#import "UPFile.h"


#define kAutoScrollAnchor 160
#define kLabelHeight 30

#define kRankSize 60
#define kRankMaring 20

@interface VISHomeViewController ()
{
    UIImageView *_fixedBackground;
    UIImageView *_changeableBackground;
    UIView *_changeableContentView;
    CGRect _changeableContentFrame;
    CGRect _changeableBackgroundFrame;
    
    CGFloat _changeableOriginalY;
    CGFloat _yOffset;
    CGFloat _commonHeight;
    
    BOOL _barChartHasShown;
    
    PNBarChart *_barChart;
    CPKenburnsView *_kenburnsView;
    UIScrollView *_adverScrollView;
    UIView *_barChartView;
}

- (void)addFixedBackground;

- (void)addChangeableBackground;

- (void)addManagerImage;

- (void)addMainInfo;

- (void)addRanks;

- (void)addWeekKWH;

- (void)handleBarChartAnimationWithOffset:(CGFloat)offset;

- (void)addAdvertismentView;

- (void)addPartnerView;

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
    _changeableOriginalY = self.viewMaxWidth;
    _yOffset = _changeableOriginalY;
    _commonHeight = [UPDeviceInfo isPad] ? 400 : 200;
    [self addFixedBackground];
    [self addChangeableBackground];
    
    [self addRanks];
    [self addMainInfo];
    [self addWeekKWH];
    [self addAdvertismentView];
    
    CGSize size = self.contentScrollView.bounds.size;
    size.height = _yOffset;
    self.contentScrollView.contentSize = size;
    self.contentScrollView.delegate = self;
    self.title = @"首页";
    [self addNavigationMenuItem];
    
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

- (void)addRanks
{
    CGFloat x = self.viewMaxWidth - kRankMaring - kRankSize;
    CGFloat y = _changeableOriginalY - kRankMaring - kRankSize;
    CGRect frame = CGRectMake(x, y, kRankSize, kRankSize);
    
    UIView *rank = [[UIView alloc] initWithFrame:frame];
    rank.backgroundColor = [UIColor clearColor];
    rank.layer.cornerRadius = 2;
    [self.contentScrollView addSubview:rank];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:rank.bounds];
    view.backgroundColor = [UIColor clearColor];
    view.image = [UIImage imageNamed:@"01bg_image"];
    [rank addSubview:view];
    
    CGRect titleFrame = CGRectMake(0, 0, 60, 20);
    VISLabel *title = [VISViewCreator middleTruncatingLabelWithFrame:titleFrame text:@"用电排名" font:[VISViewCreator defaultFontWithSize:12] textColor:[UIColor whiteColor]];
    [rank addSubview:title];
    
    CGRect rankFrame = CGRectMake(0, 20, 60, 40);
    VISLabel *rankNumber = [VISViewCreator middleTruncatingLabelWithFrame:rankFrame text:@"128" font:[VISViewCreator defaultFontWithSize:20] textColor:[UIColor whiteColor]];
    [rank addSubview:rankNumber];
    
    
}

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

- (NSArray *)createBars
{
    NSArray *bars = [NSArray arrayWithArray:[UPFile readFile:kFileName byKey:@"MonthMoney"]];;
    return bars;
}

- (UIView *)commonBGViewWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    
    // add top line
    CGRect lineFrame = CGRectMake(0, 0, frame.size.width, 0.5);
    UPLineView *line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.3 alpha:0.8]];
    [view addSubview:line];
    
    
    // add bottom line
    lineFrame = CGRectMake(0, CGRectGetHeight(frame) - 0.5, frame.size.width, 0.5);
    line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.3 alpha:0.8]];
    [view addSubview:line];
    
    return view;
}


- (void)addWeekKWH
{
    // add bar view
    CGRect barFrame = CGRectMake(0, _yOffset, self.viewMaxWidth, _commonHeight + kLabelHeight);
    _barChartView = [self commonBGViewWithFrame:barFrame];
    [self.contentScrollView addSubview:_barChartView];
    _yOffset += _commonHeight + kLabelHeight;
    
    // add title
    CGRect labelFrame = CGRectMake(0, 0, self.viewMaxWidth - 20, kLabelHeight);
    VISLabel *label = [VISViewCreator wrapLabelWithFrame:labelFrame text:@"月度用电统计(单位：元)  " font:[UIFont systemFontOfSize:16] textColor:[UIColor whiteColor]];
    label.backgroundColor = [UIColor clearColor];
    label.verticalAlignment = VISVerticalAlignmentMiddle;
    label.textAlignment = NSTextAlignmentRight;
    [_barChartView addSubview:label];
    
    // add charts
    NSArray *bars = [self createBars];
    CGRect chartFrame = CGRectMake(0, kLabelHeight, self.viewMaxWidth, _commonHeight);
    _barChart = [[PNBarChart alloc] initWithFrame:chartFrame bars:bars];
    _barChart.backgroundColor = [UIColor clearColor];
    [_barChartView addSubview:_barChart];
    [_barChart strokeChart];
}

- (void)addAdvertismentView
{
    // add title
    CGRect labelFrame = CGRectMake(10, _yOffset, self.viewMaxWidth, kLabelHeight);
    VISLabel *label = [VISViewCreator wrapLabelWithFrame:labelFrame text:@"为您推荐" font:[UIFont systemFontOfSize:16] textColor:[UIColor whiteColor]];
    label.backgroundColor = [UIColor clearColor];
    label.verticalAlignment = VISVerticalAlignmentMiddle;
    [self.contentScrollView addSubview:label];
    
    _yOffset += kLabelHeight;
    
    CGRect adFrame = CGRectMake(0, _yOffset, self.viewMaxWidth, _commonHeight);
    UIView *adView = [self commonBGViewWithFrame:adFrame];
    [self.contentScrollView addSubview:adView];
    _yOffset += _commonHeight;
    
    CGRect adContentFrame = CGRectMake(0, 0.5, self.viewMaxWidth, _commonHeight -1);
    XLCycleScrollView *csView = [[XLCycleScrollView alloc] initWithFrame:adContentFrame];
    csView.backgroundColor = [UIColor clearColor];
    csView.delegate = self;
    csView.datasource = self;
    [adView addSubview:csView];

}

- (void)addPartnerView
{
    
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

    UIImage *bgImage = [UIImage imageNamed:@"01bg_image"];//
    UIImage *newImage = [bgImage applyDarkEffect];
    _changeableBackground = [self imageViewWithImage:newImage frame:_changeableBackgroundFrame];
    _changeableBackground.alpha = 0.99;
    _changeableContentView = [[UIView alloc] initWithFrame:_changeableContentFrame];
    _changeableContentView.clipsToBounds = YES;
    
    [_changeableContentView addSubview:_changeableBackground];
    [self.view insertSubview:_changeableContentView aboveSubview:_kenburnsView];
}



#pragma mark- ScrollViewDelegate

- (void)handleBarChartAnimationWithOffset:(CGFloat)offset
{
    // control barChart Animation when showing
    CGFloat bottomOffset = CGRectGetMaxY(_barChartView.frame) - CGRectGetHeight(self.contentScrollView.frame);
    CGFloat topOffset = bottomOffset + CGRectGetHeight(self.contentScrollView.frame) - CGRectGetHeight(_barChartView.frame);
    
    if (offset >= bottomOffset && offset <= topOffset && !_barChartHasShown) {
        _barChartHasShown = YES;
        [_barChart stokeChartAnimation];
    }
    
    // control barChart Animation when hidding
    bottomOffset = bottomOffset - CGRectGetHeight(_barChartView.frame);
    topOffset += CGRectGetHeight(_barChartView.frame);
    
    if (offset <= bottomOffset || offset >= topOffset) {
        _barChartHasShown = NO;
        [_barChart hideAllBars];
    }

}

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
    CGFloat scrollAnchor = self.viewMaxWidth / 2;
    if (offset >0 && offset <= scrollAnchor) {
        CGRect rect = CGRectMake(0, 0, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
    }
    else if (offset > scrollAnchor && offset <= _changeableOriginalY) {
        CGRect rect = CGRectMake(0, _changeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // control glassBG visible
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat scrollAnchor = self.viewMaxWidth / 2;
    if (offset >0 && offset <= scrollAnchor) {
        CGRect rect = CGRectMake(0, 0, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
    }
    else if (offset > scrollAnchor && offset <= _changeableOriginalY) {
        CGRect rect = CGRectMake(0, _changeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
        
    }
    
    [self handleBarChartAnimationWithOffset:offset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    [self handleBarChartAnimationWithOffset:offset];
}

#pragma mark- XLCycleScrollViewDelegate

- (NSInteger)numberOfPages
{
    return 5;
}

- (UIView *)scrollView:(XLCycleScrollView *)scrollView pageAtIndex:(NSInteger)index
{
    NSString *imageName = nil;
    
    switch (index) {
        case 0:
            imageName = @"ad01.jpg";
            break;
        case 1:
            imageName = @"ad02.jpg";
            break;
        case 2:
            imageName = @"ad03.jpg";
            break;
        case 3:
            imageName = @"ad04.jpg";
            break;
        case 4:
            imageName = @"ad05.jpg";
            break;
        case 5:
            imageName = @"ad06.jpg";
            break;
            
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = scrollView.bounds;
    imageView.backgroundColor = [UIColor clearColor];
    
    return imageView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    NSString *urlString = @"http://www.163.com";
    VISWebViewController *web = [[VISWebViewController alloc] initWithUrl:[NSURL URLWithString:urlString] barTitle:nil];
    [self.navigationController pushViewController:web animated:YES];

}



@end
