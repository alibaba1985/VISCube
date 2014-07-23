//
//  PNBar.h
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "VISConsts.h"



@class PNChartLabel;
@interface PNBar : UIView

@property (nonatomic) CGFloat absoluteGrade;

@property (nonatomic) float grade;

@property (nonatomic,strong) CAShapeLayer * chartLine;

@property (nonatomic, strong) UIColor * barColor;

@property (nonatomic, strong) PNChartLabel *topLabel;

@property (nonatomic, strong) PNChartLabel *bottomLabel;

- (id)initWithFrame:(CGRect)frame content:(NSDictionary *)content;

- (void)hideBar;

- (void)showBar;

@end
