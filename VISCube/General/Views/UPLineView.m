//
//  UPLineView.m
//  UPPayPluginEx
//
//  Created by liwang on 13-3-19.
//
//

#import "UPLineView.h"

@implementation UPLineView

@synthesize lineColor;

#define dataEngine [CUPPLusEngine sharedInstance].noCardData

-(id)initWithFrame:(CGRect)frame color:(UIColor *) color{
    if ((self = [super initWithFrame:frame])) {
		
        self.lineColor = color;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
	}
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //CGContextSetRGBStrokeColor(context, 0.1, 0.1, 0.1, 1.0);
    CGContextSetStrokeColorWithColor(context, [self.lineColor CGColor]);
    CGContextSetLineWidth(context, rect.size.width);
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGContextStrokePath(context);
}


@end
