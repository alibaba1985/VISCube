//
//  VISResetPwdViewController.m
//  VISCube
//
//  Created by liwang on 14-8-8.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISResetPwdViewController.h"
#import "UPLineView.h"

@interface VISResetPwdViewController ()

@end

@implementation VISResetPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(VISResetPwdType)type
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.resetType = type;
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _namePlaceHolder = @"注册邮箱";
    _pwdPlaceHolder = @"原密码";
    _buttonTitle = (self.resetType == VISResetPwdTypeForget) ? @"找回密码" : @"重置密码";
    self.title = (self.resetType == VISResetPwdTypeForget) ? @"找回密码" : @"重置密码";
    
    _loadingMessage = (self.resetType == VISResetPwdTypeForget) ? @"正在找回密码..." : @"正在重置密码...";
    [_mainButton setTitle:_buttonTitle forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Override

- (void)addHelpInfos
{
    
}

- (void)gotoNextPage
{
    [self showToastMessage:@"设置成功！\n请登录。"];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)addInputArea
{
    CGFloat margin = [UPDeviceInfo isPad] ? kPadMargin*3 : kPhoneMargin;
    CGFloat x = (self.viewMaxWidth - kAreaWidth) / 2;
    CGFloat y = margin;
    CGFloat borderWidth = [UPDeviceInfo isPad] ? kPadBorderWidth : kPhoneBorderWidth;
    CGFloat height = (self.resetType == VISResetPwdTypeForget) ? kCommonHeight : (kCommonHeight*3 + kSperatorLineHeight*2);
    
    CGRect areaFrame = CGRectMake(x, y, kAreaWidth, height);
    _inputAreas = [[UIView alloc] initWithFrame:areaFrame];
    _inputAreas.backgroundColor = [UIColor whiteColor];
    _inputAreas.clipsToBounds = YES;
    _inputAreas.layer.cornerRadius = 4;
    _inputAreas.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1].CGColor;
    _inputAreas.layer.borderWidth = borderWidth;
    
    [self.contentScrollView addSubview:_inputAreas];
    _yOffset = CGRectGetMaxY(areaFrame);
    //
    y = 0;
    UIView *nameArea = [self createAreaWithFrame:CGRectMake(0., y, kAreaWidth, kCommonHeight) imageName:@"user" placeHolder:_namePlaceHolder];
    [_inputAreas addSubview:nameArea];
    y += kCommonHeight;
    //
    if (self.resetType == VISResetPwdTypeNew) {
        CGRect lineFrame = CGRectMake(0, y, kAreaWidth, borderWidth);
        UPLineView *line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.8f alpha:1]];
        [_inputAreas addSubview:line];
        y += kSperatorLineHeight;
        //
        UIView *pwdArea = [self createAreaWithFrame:CGRectMake(0, y, kAreaWidth, kCommonHeight) imageName:@"pwd" placeHolder:@"原密码"];
        [_inputAreas addSubview:pwdArea];
        
        y += kCommonHeight;
        
        lineFrame = CGRectMake(0, y, kAreaWidth, borderWidth);
        line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.8f alpha:1]];
        [_inputAreas addSubview:line];
        y += kSperatorLineHeight;
        //
        pwdArea = [self createAreaWithFrame:CGRectMake(0, y, kAreaWidth, kCommonHeight) imageName:@"pwd" placeHolder:@"新密码"];
        [_inputAreas addSubview:pwdArea];
    }
    
}


@end
