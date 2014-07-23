//
//  PNBar.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBar.h"
#import "PNColor.h"
#import "PNChartLabel.h"

#define kLabelHeight 18

@interface PNBar ()
{
    UIBezierPath *_progressline;
    NSDictionary *_content;
    PNChartLabel *_valueLabel;
    UIView *_barView;
    CGRect _barOriginalFrame;
}

- (void)addValue;

- (void)addLabel;

@end




@implementation PNBar



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapSquare;
		_chartLine.fillColor   = [[UIColor whiteColor] CGColor];
		_chartLine.lineWidth   = self.frame.size.width;
		_chartLine.strokeEnd   = 0.0;
		self.clipsToBounds = YES;
		[self.layer addSublayer:_chartLine];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame content:(NSDictionary *)content
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = YES;
        _content = [NSDictionary dictionaryWithDictionary:content];
		[self addChartLine];
        [self addLabel];
    }
    return self;
}

- (void)addChartLine
{
    _barOriginalFrame = CGRectMake(self.frame.size.width / 4, kLabelHeight, self.frame.size.width/2, self.frame.size.height - 2*kLabelHeight);
    _barView = [[UIView alloc] initWithFrame:_barOriginalFrame];
    _barView.backgroundColor = [UIColor clearColor];
    _barView.clipsToBounds = YES;
    [self addSubview:_barView];
    
    _chartLine = [CAShapeLayer layer];
    _chartLine.lineCap = kCALineCapSquare;
    _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
    _chartLine.lineWidth   = _barView.frame.size.width;
    
    _chartLine.strokeEnd   = 0.0;
    [_barView.layer addSublayer:_chartLine];
}


- (void)addValue
{
    CGFloat y = CGRectGetMinY(_barView.frame) - kLabelHeight;
    CGFloat width = CGRectGetWidth(self.frame);
    NSString *valueText = [_content objectForKey:kValue];
    
    _valueLabel = [[PNChartLabel alloc] initWithFrame:CGRectMake(0, y, width, kLabelHeight)];
    [_valueLabel setTextAlignment:NSTextAlignmentCenter];
    _valueLabel.text = valueText;
    [self addSubview:_valueLabel];
}

- (void)addLabel
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat y = CGRectGetHeight(self.frame) -kLabelHeight;
    NSString *labelText = [_content objectForKey:kLabel];
    PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(0, y, width, kLabelHeight)];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text = labelText;
    [self addSubview:label];
}

- (void)removeChartLine
{
    [_chartLine removeFromSuperlayer];
}



- (void)hideBar
{
    [_chartLine removeFromSuperlayer];
    [_valueLabel removeFromSuperview];
}

- (void)showBar
{
    self.grade = self.absoluteGrade;
    
}

-(void)setGrade:(float)grade
{
    _absoluteGrade = grade;
	_grade = grade;
    
    // 每次重新构造line，否则首次显示会动画两次
    [self addChartLine];

    CGRect frame = _barOriginalFrame;
    frame.origin.y = frame.origin.y + frame.size.height*(1-grade);
    frame.size.height = frame.size.height * grade;
    frame.origin.y = kLabelHeight + (self.frame.size.height - 2*kLabelHeight)*(1-grade);
    _barView.frame = frame;
    
	_progressline = [UIBezierPath bezierPath];
    CGFloat barWidth =  CGRectGetWidth(_barView.frame);
    CGFloat barHeight = CGRectGetHeight(_barView.frame);
    [_progressline moveToPoint:CGPointMake(barWidth/2.0, barHeight)];
	[_progressline addLineToPoint:CGPointMake(barWidth/2.0, 0)];
	
    [_progressline setLineWidth:1.0];
    [_progressline setLineCapStyle:kCGLineCapSquare];
	_chartLine.path = _progressline.CGPath;
    
	if (_barColor) {
		_chartLine.strokeColor = [_barColor CGColor];
	}else{
		_chartLine.strokeColor = [PNGreen CGColor];
	}
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.delegate = self;

    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _chartLine.strokeEnd = 1.0;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//	//Draw BG
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//	CGContextFillRect(context, rect);
//    
//}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"stop");
    [self addValue];
}


@end
