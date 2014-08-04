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

#define kAnimationDelayDuration 0.15
#define kStraightAnimationDuration 0.25
#define kSpringAnimationDuration 0.75

@interface PNBar ()
{
    CGRect _straightAnimateViewFrame;
    CGRect _springAnimateViewFrame;
    
    CGFloat _animationDalay;
    CGFloat _barHeight;
    CGFloat _gradeHeight;
    
    NSDictionary *_content;
    PNChartLabel *_bottomLabel;
    PNChartLabel *_valueLabel;
    
    //
    UIView *_straightAnimateView;
    UIView *_springAnimateView;
    
    
}

- (void)addValue;

- (void)addLabel;

- (void)startAnimation;

- (void)addAnimateViews;

- (void)startStraightAnimation;

- (void)startSpringAnimation;


- (void)moveAnimateViewsToOriginalPosition;

- (void)doThingsAfterAnimation;

@end




@implementation PNBar



- (id)initWithFrame:(CGRect)frame content:(NSDictionary *)content index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = YES;
        _content = [NSDictionary dictionaryWithDictionary:content];
        _animationDalay = index*kAnimationDelayDuration;
        NSLog(@"delay:%f \n", _animationDalay);
        _barHeight = CGRectGetHeight(frame) - 2*kLabelHeight;
        [self addAnimateViews];
        [self moveAnimateViewsToOriginalPosition];
        
    }
    return self;
}

- (void)startAnimation
{
    [self performSelector:@selector(startStraightAnimation) withObject:nil afterDelay:_animationDalay];
}

- (void)startStraightAnimation
{
    [self addLabel];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startSpringAnimation)];
    [UIView setAnimationDuration:kStraightAnimationDuration];
    
    CGRect frame = _straightAnimateViewFrame;
    frame.origin.y -= _gradeHeight/2;
    frame.size.height += _gradeHeight/2;
    _straightAnimateView.frame = frame;
    
    [UIView commitAnimations];
}

- (void)startSpringAnimation
{
    __block PNBar *aSelf = self;
    [UIView animateWithDuration:kSpringAnimationDuration delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = _springAnimateViewFrame;
        frame.origin.y -= _gradeHeight/2;
        frame.size.height += _gradeHeight/2;
        _springAnimateView.frame = frame;
    }completion:^(BOOL finished){
        if (finished) {
            [aSelf doThingsAfterAnimation];
        }
    }];
}


- (void)doThingsAfterAnimation
{
    [self addValue];
}

- (void)addAnimateViews
{
    _straightAnimateView = [[UIView alloc] initWithFrame:CGRectZero];
    _straightAnimateView.backgroundColor = PNGreen;
    [self addSubview:_straightAnimateView];
    
    _springAnimateView = [[UIView alloc] initWithFrame:CGRectZero];
    _springAnimateView.backgroundColor = PNGreen;
    [self addSubview:_springAnimateView];
}





- (void)addValue
{
    if (_valueLabel != nil) {
        _valueLabel.alpha = 1;
    } else {
        CGFloat y = self.frame.size.height - _gradeHeight - kLabelHeight*2;
        CGFloat width = CGRectGetWidth(self.frame);
        NSString *valueText = [_content objectForKey:kValue];
        
        _valueLabel = [[PNChartLabel alloc] initWithFrame:CGRectMake(0, y, width, kLabelHeight)];
        [_valueLabel setTextAlignment:NSTextAlignmentCenter];
        _valueLabel.text = valueText;
        [self addSubview:_valueLabel];
    }
    
}

- (void)addLabel
{
    if (_bottomLabel != nil) {
        _bottomLabel.alpha = 1;
    } else {
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat y = CGRectGetHeight(self.frame) -kLabelHeight;
        NSString *labelText = [_content objectForKey:kLabel];
        _bottomLabel = [[PNChartLabel alloc] initWithFrame:CGRectMake(0, y, width, kLabelHeight)];
        [_bottomLabel setTextAlignment:NSTextAlignmentCenter];
        _bottomLabel.text = labelText;
        [self addSubview:_bottomLabel];
    }
}



- (void)hideBar
{
    _bottomLabel.alpha = 0;
    _valueLabel.alpha = 0;
    
    [self moveAnimateViewsToOriginalPosition];
}

- (void)showBar
{
    [self setGrade:self.absoluteGrade];
}

- (void)moveAnimateViewsToOriginalPosition
{
    CGFloat animateViewHeight = _gradeHeight/2;
    CGFloat x = self.frame.size.width / 4;
    CGFloat straightY = self.frame.size.height - kLabelHeight;
    CGFloat springY = self.frame.size.height - kLabelHeight - animateViewHeight;
    CGFloat width = self.frame.size.width/2;
    _straightAnimateViewFrame = CGRectMake(x, straightY, width, 0);
    _springAnimateViewFrame = CGRectMake(x, springY, width, 0);
    
    _straightAnimateView.frame = _straightAnimateViewFrame;
    _springAnimateView.frame = _springAnimateViewFrame;
}

-(void)setGrade:(CGFloat)grade
{
    _absoluteGrade = grade;
	_grade = grade;
    _gradeHeight = _barHeight*grade;
    [self moveAnimateViewsToOriginalPosition];
    [self startAnimation];
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



@end
