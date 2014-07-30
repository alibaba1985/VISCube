//
//  VISDeviceDetailViewController.h
//  VISCube
//
//  Created by liwang on 14-7-26.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"

@protocol VISDetailDeviceDelegate <NSObject>

- (void)didChangeDeviceDetail:(NSDictionary *)details;

@end

@interface VISDeviceDetailViewController : VISBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)id<VISDetailDeviceDelegate> detailDelegate;

- (id)initWithDeviceDetails:(NSDictionary *)details;


@end
