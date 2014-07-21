//
//  PNBarChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBarChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"
#import "PNBar.h"

@interface PNBarChart ()
{
    UIScrollView *_scrollView;
    NSArray *_bars;
    CGFloat _chartMarginAndWidth;
}
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
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
        _chartMarginAndWidth = CGRectGetWidth(frame) / (2*_bars.count + 1);
        
    }
    
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    for (NSString * valueString in yLabels) {
        NSInteger value = [valueString integerValue];
        if (value > max) {
            max = value;
        }
        
    }
    
    _yValueMax = (int)max;
}

-(void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    _xLabelWidth = _chartMarginAndWidth * 2;
    
    for (NSInteger index = 0; index < _xLabels.count; index++) {
        NSString *labelText = [_xLabels objectAtIndex:index];
        PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(_chartMarginAndWidth/2 + _xLabelWidth*index, self.frame.size.height - kLabelHeight, _xLabelWidth, kLabelHeight)];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.text = labelText;
        [self addSubview:label];
    }
    
}

-(void)setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
}

-(void)strokeChart
{
    
    CGFloat chartCavanHeight = self.frame.size.height - kLabelHeight*2;
    
    PNBar *bar = nil;
	for (NSInteger index = 0; index < _yValues.count; index++)
    {
        NSString *valueString = [_yValues objectAtIndex:index];
        CGFloat value = [valueString floatValue];
        CGFloat grade = value / _yValueMax;
        
        bar = [[PNBar alloc] initWithFrame:CGRectMake(_chartMarginAndWidth*(index+1)+_chartMarginAndWidth*index, kLabelHeight, _chartMarginAndWidth, chartCavanHeight)];
		bar.barColor = _strokeColor;
		bar.grade = grade;
		[self addSubview:bar];
    }
    
}

@end
