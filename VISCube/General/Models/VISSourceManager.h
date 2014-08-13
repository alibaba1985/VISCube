//
//  VISSourceManager.h
//  VISCube
//
//  Created by liwang on 14-7-9.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *
 *
 * 单例
 *
 * 该类仅被允许在主线程中使用
 *
 *
 *
 *
 */
@class RESideMenu;
@interface VISSourceManager : NSObject
/** 侧边栏content viewControllers **/
@property (nonatomic, strong) NSArray *menuViewControllers;
@property (nonatomic, strong) RESideMenu *sideMenuViewController;
@property(nonatomic, strong)NSMutableArray *allDevices;
@property(nonatomic)NSString *deviceAlertStatus;//00-ok 01-error

+ (instancetype)currentSource;

- (void)checkDeviceStatus;


@end
