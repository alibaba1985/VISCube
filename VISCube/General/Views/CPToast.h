//
//  CPToast.h
//  Cashier
//
//  Created by liwang on 14-1-23.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPToast : UIView


- (void)dismiss;

- (id)initWithMessage:(NSString *)message onView:(UIView *)view;

- (id)initWithLoadingMessage:(NSString *)message onView:(UIView *)view;

- (void)show;



@end
