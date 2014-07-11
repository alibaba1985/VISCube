//
//  WLSourceManager.m
//  VISCube
//
//  Created by liwang on 14-7-9.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "WLSourceManager.h"


@implementation WLSourceManager

@synthesize menuViewControllers;

+ (instancetype)currentSource
{
    static WLSourceManager *_source = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _source = [[WLSourceManager alloc] init];
    });
    
    return _source;
}


@end
