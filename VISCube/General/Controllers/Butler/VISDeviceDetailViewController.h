//
//  VISDeviceDetailViewController.h
//  VISCube
//
//  Created by liwang on 14-7-26.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"

@interface VISDeviceDetailViewController : VISBaseViewController<UITableViewDataSource,UITableViewDelegate>

- (id)initWithDeviceDetails:(NSDictionary *)details;


@end
