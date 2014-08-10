//
//  UPFile.m
//  VISCube
//
//  Created by liwang on 14-7-24.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "UPFile.h"

@implementation UPFile

+ (NSString *)pathForFile:(NSString *)file writable:(BOOL)writable
{
    NSString *path = nil;
    if (writable) {
        NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        path = [docPath stringByAppendingPathComponent:file];
    }
    else
    {
        path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:file];
    }
    
    return path;
}

+ (id)readFile:(NSString *)filePath forKey:(NSString *)key
{
    id value = nil;

    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSMutableDictionary* file = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        value = ([file objectForKey:key] != nil) ? [file objectForKey:key] : nil;
    }
    
    return value;
}

+ (void)writeFile:(NSString *)filePath withValue:(id)value forKey:(NSString *)key
{
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSMutableDictionary *fileDictionary = fileExist ?
        [NSMutableDictionary dictionaryWithContentsOfFile:filePath] :
        [NSMutableDictionary dictionary];
    [fileDictionary setObject:value forKey:key];
    [fileDictionary writeToFile:filePath atomically:YES];
}

+ (void)deleteFile:(NSString *)file
{
    
}

+ (void)deleteFile:(NSString *)file forKey:(NSString *)key atIndex:(NSInteger)index
{
    
}

@end
