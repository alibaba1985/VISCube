//
//  VISAccountViewController.h
//  VISCube
//
//  Created by liwang on 14-7-30.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"

@interface VISAccountViewController : VISBaseViewController<UITableViewDataSource,UITableViewDelegate>

- (id)initWithUserAccountInfo:(NSDictionary *)userAccountInfo;

@end
