//
//  WLBaseViewController.h
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPMacros.h"
#import "UPDeviceInfo.h"
#import "RESideMenu.h"
#import "WLColors.h"

@interface WLBaseViewController : UIViewController

@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (nonatomic, readonly) CGFloat viewMaxWidth;
@property (nonatomic, readonly) CGFloat viewMaxHeight;

@end
