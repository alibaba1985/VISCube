//
//  PNBarChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBarChart.h"
#import "PNColor.h"

#import "PNBar.h"

@interface PNBarChart ()
{
    NSArray *_bars;
    NSMutableArray *_barCharts;
    CGFloat _chartMarginAndWidth;
}

- (void)findMaxValue;

@end

@implementation PNBarChart

- (id)initWithFrame:(CGRect)frame bars:(NSArray *)bars
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        _bars = [NSArray arrayWithArray:bars];
        _chartMarginAndWidth = CGRectGetWidth(frame) / (2*_bars.count + 1);
        [self findMaxValue];
    }
    
    return self;
}


- (void)stokeChartAnimation
{
    for (PNBar *bar in _barCharts) {
        [bar showBar];
    }
}

- (void)hideAllBars
{
    for (PNBar *bar in _barCharts) {
        [bar hideBar];
    }
}

- (void)findMaxValue
{
    CGFloat max = 0;
    
    for (NSDictionary *bar in _bars) {
        CGFloat value = [[bar objectForKey:kValue] floatValue];
        if (value > max) {
            max = value;
        }
    }
    
    _yValueMax = max;
}


-(void)setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
}

-(void)strokeChart
{
    _barCharts = [[NSMutableArray alloc] init];
    
    PNBar *bar = nil;
	for (NSInteger index = 0; index < _bars.count; index++)
    {
        NSDictionary *content = [_bars objectAtIndex:index];
        CGFloat value = [[content objectForKey:kValue] floatValue];
        CGFloat grade = value / _yValueMax;
        
        CGRect barFrame = CGRectMake(_chartMarginAndWidth/2+_chartMarginAndWidth*2*index, 0, _chartMarginAndWidth*2, CGRectGetHeight(self.frame));
        bar = [[PNBar alloc] initWithFrame:barFrame content:content];
		bar.barColor = _strokeColor;
		bar.absoluteGrade = grade;
		[self addSubview:bar];
        [_barCharts addObject:bar];
    }
    
}

@end
