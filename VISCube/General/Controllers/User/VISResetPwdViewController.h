//
//  VISResetPwdViewController.h
//  VISCube
//
//  Created by liwang on 14-8-8.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISLoginViewController.h"

typedef NS_ENUM(NSInteger, VISResetPwdType) {
    VISResetPwdTypeNew,
    VISResetPwdTypeForget,
};


@interface VISResetPwdViewController : VISLoginViewController
@property(nonatomic)VISResetPwdType resetType;

- (id)initWithType:(VISResetPwdType)type;

@end
