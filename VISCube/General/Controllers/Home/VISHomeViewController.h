//
//  VISHomeViewController.h
//  VISCube
//
//  Created by liwang on 14-7-8.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"
#import "XLCycleScrollView.h"

@interface VISHomeViewController : VISBaseViewController<UIScrollViewDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>

- (void)strokeAnimation;

@end
