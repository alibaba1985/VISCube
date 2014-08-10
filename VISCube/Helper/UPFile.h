//
//  UPFile.h
//  VISCube
//
//  Created by liwang on 14-7-24.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPFile : NSObject


// string file // plist

+ (NSString *)pathForFile:(NSString *)file writable:(BOOL)writable;

+ (id)readFile:(NSString *)filePath forKey:(NSString *)key;

+ (void)writeFile:(NSString *)filePath withValue:(id)value forKey:(NSString *)key;

+ (void)deleteFile:(NSString *)filePath;

+ (void)deleteFile:(NSString *)filePath forKey:(NSString *)key atIndex:(NSInteger)index;


@end
