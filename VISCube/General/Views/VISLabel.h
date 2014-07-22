//
//  VISLabel.h
//  VISCube
//
//  Created by liwang on 14-7-22.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VISVerticalAlignmentTop = 0, // default
    VISVerticalAlignmentMiddle,
    VISVerticalAlignmentBottom,
} VISVerticalAlignment;

@interface VISLabel : UILabel

@property (nonatomic) VISVerticalAlignment verticalAlignment;

@end
