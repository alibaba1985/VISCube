//
//  VISAddDeviceViewController.h
//  VISCube
//
//  Created by liwang on 14-7-28.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"

@protocol VISAddDeviceDelegate;
@interface VISAddDeviceViewController : VISBaseViewController

@property(nonatomic)id<VISAddDeviceDelegate> deviceDelegate;

@end

@protocol VISAddDeviceDelegate <NSObject>

- (void)didAddDeviceWithDeviceInfo:(NSDictionary *)deviceInfo;

@end