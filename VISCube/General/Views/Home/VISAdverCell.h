//
//  VISAdverCell.h
//  VISCube
//
//  Created by liwang on 14-7-24.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VISAdverCell : UIView

@property(nonatomic, strong)UIImage *adverImage;

@property(nonatomic, strong)NSURL *adverURL;

- (id)initWithFrame:(CGRect)frame content:(NSDictionary *)content;

@end
