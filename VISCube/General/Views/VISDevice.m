//
//  WLDevice.m
//  VISCube
//
//  Created by liwang on 14-7-21.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISDevice.h"

@interface VISDevice ()
{
    
}

- (void)resetLayer;

@end

@implementation VISDevice

- (id)initWithFrame:(CGRect)frame info:(NSDictionary *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self resetLayer];

        
        
        
        
    }
    return self;
}

- (void)resetLayer
{
    self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1];
    self.layer.cornerRadius = 5;
    self.layer.shadowOffset = CGSizeMake(3, 3 );
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
