//
//  VISSourceManager.m
//  VISCube
//
//  Created by liwang on 14-7-9.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISSourceManager.h"
#import "VISConsts.h"
#import "UPFile.h"


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

- (void)initAllDevices
{
    BOOL isUserB = [[[NSUserDefaults standardUserDefaults] objectForKey:kUserB] isEqualToString:kValueYES];
    // prepare data
    NSString *devicesKey = isUserB ? @"BDevices" : @"Devices";
    NSString *apath = [UPFile pathForFile:kLocalFileName writable:NO];
    NSArray *devices = [UPFile readFile:apath forKey:devicesKey];
    [VISSourceManager currentSource].allDevices = [NSMutableArray arrayWithArray:devices];
    [[VISSourceManager currentSource] checkDeviceStatus];
}

- (void)checkDeviceStatus
{
    self.deviceAlertStatus = @"00";
    for (NSDictionary *item in self.allDevices) {
        if ([[item objectForKey:kDeviceStatus] isEqual:kValue2]) {
            self.deviceAlertStatus = @"01";
            break;
        }
    }
}



@end
