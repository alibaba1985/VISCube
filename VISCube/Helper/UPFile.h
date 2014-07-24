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

+ (NSString *)pathForFile:(NSString *)file;

+ (NSString *)readFile:(NSString *)file byKey:(NSString *)key;

+ (NSString *)writeFile:(NSString *)file byKey:(NSString *)key;

+ (void)deleteFile:(NSString *)file;

+ (void)deleteFile:(NSString *)file byKey:(NSString *)key atIndex:(NSInteger)index;


@end
