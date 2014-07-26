//
//  VISButlerViewController.h
//  VISCube
//
//  Created by liwang on 14-7-24.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"
#import "VISDevice.h"


@interface VISButlerViewController : VISBaseViewController<UIScrollViewDelegate,VISDeviceDelegate>

@property (nonatomic, strong) NSArray *devices;

@end
