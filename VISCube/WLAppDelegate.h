//
//  WLAppDelegate.h
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@class VISRootViewController;
@interface WLAppDelegate : UIResponder <UIApplicationDelegate,RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) VISRootViewController *rootViewControler;

- (void)createMenuViewControllers;

- (void)createMenu;


@end
