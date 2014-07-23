//
//  PNBarChart.h
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>





@interface PNBarChart : UIView

/**
 * This method will call and troke the line in animation
 */

-(void)strokeChart;

@property (nonatomic) CGFloat yValueMax;

@property (nonatomic, strong) UIColor * strokeColor;


- (id)initWithFrame:(CGRect)frame bars:(NSArray *)bars;

- (void)stokeChartAnimation;

- (void)hideAllBars;

@end
