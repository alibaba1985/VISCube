//
//  WLSourceManager.h
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
@interface WLSourceManager : NSObject
/** 侧边栏content viewControllers **/
@property (nonatomic, strong) NSArray *menuViewControllers;

+ (instancetype)currentSource;


@end
