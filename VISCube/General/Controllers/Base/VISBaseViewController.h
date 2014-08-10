//
//  VISBaseViewController.h
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPMacros.h"
#import "UPDeviceInfo.h"
#import "RESideMenu.h"
#import "VISColors.h"
#import "VISViewCreator.h"
#import "VISConsts.h"
#import "CPToast.h"
#import "VISSourceManager.h"


@interface VISBaseViewController : UIViewController

@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (nonatomic, readonly) CGFloat viewMaxWidth;
@property (nonatomic, readonly) CGFloat viewMaxHeight;


- (void)addNavigationMenuItem;


- (void)showToastMessage:(NSString *)message;

- (void)showAlertMessage:(NSString *)message;

- (void)showLoadingWithMessage:(NSString *)message;

- (void)dismissLoading;

@end
