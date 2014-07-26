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

+ (id)readFile:(NSString *)file byKey:(NSString *)key
{
    id value = nil;
    NSString *path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:file];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSMutableDictionary* file = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        value = ([file objectForKey:key] != nil) ? [file objectForKey:key] : nil;
    }
    
    return value;
}

+ (void)writeFile:(NSString *)file withValue:(id)value withKey:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:file];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    NSMutableDictionary *fileDictionary = fileExist ?
        [NSMutableDictionary dictionaryWithContentsOfFile:path] :
        [NSMutableDictionary dictionary];
    [fileDictionary setObject:value forKey:key];
    [fileDictionary writeToFile:path atomically:YES];
}

+ (void)deleteFile:(NSString *)file
{
    
}

+ (void)deleteFile:(NSString *)file byKey:(NSString *)key atIndex:(NSInteger)index
{
    
}

@end
