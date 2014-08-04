//
//  VISViewCreator.m
//  VISCube
//
//  Created by liwang on 14-7-22.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISViewCreator.h"


@implementation VISViewCreator


+ (VISLabel *)wrapLabelWithFrame:(CGRect)frame
                           text:(NSString *)text
                           font:(UIFont *)font
                      textColor:(UIColor *)color
{
    VISLabel *label = [[VISLabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    label.verticalAlignment = VISVerticalAlignmentBottom;
    label.numberOfLines = 0;
    label.font = font;
    label.textColor = color;
    label.text = text;
    
    return label;
}

+ (VISLabel *)middleTruncatingLabelWithFrame:(CGRect)frame
                                        text:(NSString *)text
                                        font:(UIFont *)font
                                   textColor:(UIColor *)color
{
    VISLabel *label = [[VISLabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByTruncatingMiddle;
    label.textAlignment = NSTextAlignmentCenter;
    label.verticalAlignment = VISVerticalAlignmentMiddle;
    label.numberOfLines = 0;
    label.font = font;
    label.textColor = color;
    label.text = text;
  
    return label;
}

+ (UIFont *)defaultFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

@end
