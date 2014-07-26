//
//  VISDevice.h
//  VISCube
//
//  Created by liwang on 14-7-21.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VISDeviceDelegate;
@interface VISDevice : UIView

- (id)initWithFrame:(CGRect)frame info:(NSDictionary *)info;

@property(nonatomic, strong)UIImage *deviceImage;

@property(nonatomic, strong)NSString *deviceName;

@property(nonatomic, strong)NSString *deviceLocation;

@property(nonatomic, strong)NSString *deviceStatus;

@property(nonatomic)id<VISDeviceDelegate> deviceDelegate;

- (void)resume;

@end



@protocol VISDeviceDelegate <NSObject>

- (void)didSelectedDevice:(VISDevice *)device info:(NSDictionary *)info;

@end
