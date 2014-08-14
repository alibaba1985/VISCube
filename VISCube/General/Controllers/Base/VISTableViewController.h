//
//  VISTableViewController.h
//  VISCube
//
//  Created by liwang on 14-8-10.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"

@interface VISTableViewController : VISBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _rowHeight;
}
@property(nonatomic, strong)UITableView *tableView;

- (UITableView *)tableViewWithStyle:(UITableViewStyle)style;

@end
