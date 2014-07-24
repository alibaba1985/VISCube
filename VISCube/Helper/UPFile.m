//
//  UPFile.m
//  VISCube
//
//  Created by liwang on 14-7-24.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "UPFile.h"

@implementation UPFile

+ (NSString *)pathForFile:(NSString *)file
{
    NSString *path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:file];
    
    return path;
}

+ (NSString *)readFile:(NSString *)file byKey:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:file];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
    }
}

+ (NSString *)writeFile:(NSString *)file byKey:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:file];
}

+ (void)deleteFile:(NSString *)file
{
    
}

+ (void)deleteFile:(NSString *)file byKey:(NSString *)key atIndex:(NSInteger)index
{
    
}

@end
