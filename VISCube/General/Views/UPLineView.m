//
//  UPLineView.m
//  UPPayPluginEx
//
//  Created by liwang on 13-3-19.
//
//

#import "UPLineView.h"

@interface UPLineView ()
{
    BOOL _dotted;
}

- (void)resetLayer;

@end

@implementation UPLineView

@synthesize lineColor;

#define dataEngine [CUPPLusEngine sharedInstance].noCardData



-(id)initWithFrame:(CGRect)frame color:(UIColor *) color{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = color;
	}
    return self;
}

-(id)initWithFrame:(CGRect)frame color:(UIColor *) color dotted:(BOOL)dotted
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.lineColor = color;
        _dotted = dotted;
        [self resetLayer];
	}
    return self;
}

- (void)resetLayer
{
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    if (_dotted) {
        CGFloat lengths[] = {6,6};
        CGContextSetLineDash(context, 0, lengths, 2);
    }

    CGContextSetStrokeColorWithColor(context, [self.lineColor CGColor]);
    CGContextSetLineWidth(context, CGRectGetWidth(rect));
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
}


@end
