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

+ (UIColor *)defaultColor
{
    return [UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f];
}


+ (UIColor *)underLineNormalColor
{
    CGFloat red = ((CGFloat)0x30)/0xFF;
    CGFloat green = ((CGFloat)0x74)/0xFF;
    CGFloat blue = ((CGFloat)0xAB)/0xFF;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)underLineDownColor
{
    CGFloat red = ((CGFloat)0x0D)/0xFF;
    CGFloat green = ((CGFloat)0x3D)/0xFF;
    CGFloat blue = ((CGFloat)0x71)/0xFF;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (void)makeShadowLayerForView:(UIView *)view
{
    view.layer.cornerRadius = 5;
    view.layer.shadowOffset = CGSizeMake(3, 3);
    view.layer.shadowRadius = 5;
    view.layer.shadowOpacity = 0.7;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:1].CGColor;
    view.layer.borderWidth = 1;
}


+ (void)makeNormalLayerForView:(UIView *)view
{
    view.layer.shadowOffset = CGSizeMake(3, 3);
    view.layer.shadowRadius = 5;
    view.layer.shadowOpacity = 0.7;
    view.layer.shadowColor = [UIColor clearColor].CGColor;
}


@end
