//
//  VISViewCreator.h
//  VISCube
//
//  Created by liwang on 14-7-22.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VISLabel.h"

@interface VISViewCreator : NSObject

+ (VISLabel *)wrapLabelWithFrame:(CGRect)frame
                           text:(NSString *)text
                           font:(UIFont *)font
                      textColor:(UIColor *)color;


+ (VISLabel *)middleTruncatingLabelWithFrame:(CGRect)frame
                                        text:(NSString *)text
                                        font:(UIFont *)font
                                   textColor:(UIColor *)color;

+ (UIFont *)defaultFontWithSize:(CGFloat)size;

@end
