//
//  VISSourceManager.m
//  VISCube
//
//  Created by liwang on 14-7-9.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISSourceManager.h"


@implementation VISSourceManager

+ (instancetype)currentSource
{
    static VISSourceManager *_source = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _source = [[VISSourceManager alloc] init];
    });
    
    return _source;
}


@end
