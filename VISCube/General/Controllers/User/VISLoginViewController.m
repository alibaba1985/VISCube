//
//  VISLoginViewController.m
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISLoginViewController.h"
#import "VISPreShowViewController.h"
#import "VISRegisterViewController.h"
#import "VISResetPwdViewController.h"
#import "UPLineView.h"
#import "UPUnderLineButton.h"
#import "UPFile.h"




@interface VISLoginViewController ()
{
    UITextField *_activeTextField;
    
    LoginBarBlock _barBlock;
    NSMutableArray *_textFields;
    BOOL _noPresentation;
}



- (void)barAction;


@end

@implementation VISLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    _namePlaceHolder = @"登录邮箱";
    _pwdPlaceHolder = @"密码";
    _buttonTitle = @"登    录";
    _loadingMessage = @"正在玩儿命登录...";
    _textFields = [[NSMutableArray alloc] init];
    
    [self addTapGesture];
    [self addInputArea];
    [self addLoginButton];
    [self addHelpInfos];

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

- (void)showBarButtonWithTitle:(NSString *)title block:(LoginBarBlock)block
{
    if (title) {
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
    
    _barBlock = block;
}


- (void)barAction
{
    if (_barBlock) {
        _barBlock();
    }
}

- (void)gotoNextPage
{
    NSString *path = [UPFile pathForFile:kLocalFileName writable:YES];
    [UPFile writeFile:path withValue:kValueYES forKey:kLoginned];
    
    for (UITextField *textField in _textFields) {
        if ([textField.placeholder isEqualToString:_namePlaceHolder]) {
            [UPFile writeFile:path withValue:textField.text forKey:kUserName];
            break;
        }
    }
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [VISSourceManager currentSource].sideMenuViewController;
    
    [self dismissLoading];
}

- (void)mainAction:(id)sender
{
    [_activeTextField resignFirstResponder];
    [self showLoadingWithMessage:_loadingMessage];
    
    NSString *errMessage = nil;
    for (UITextField *textField in _textFields) {
        NSString *text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (text.length == 0) {
            errMessage = [NSString stringWithFormat:@"请输入%@", textField.placeholder];
            break;
        }
    }
    
    if (errMessage) {
        [self showToastMessage:errMessage];
        return;
    }
    
    
    [self performSelector:@selector(gotoNextPage) withObject:nil afterDelay:2];
}

- (void)addTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                                 action:@selector(handleTap:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)addInputArea
{
    CGFloat margin = [UPDeviceInfo isPad] ? kPadMargin*3 : kPhoneMargin;
    CGFloat x = (self.viewMaxWidth - kAreaWidth) / 2;
    CGFloat y = margin;
    CGFloat borderWidth = [UPDeviceInfo isPad] ? kPadBorderWidth : kPhoneBorderWidth;
    
    CGRect areaFrame = CGRectMake(x, y, kAreaWidth, kCommonHeight*2+kSperatorLineHeight);
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
    CGRect lineFrame = CGRectMake(0, y, kAreaWidth, borderWidth);
    UPLineView *line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.8f alpha:1]];
    [_inputAreas addSubview:line];
    y += kSperatorLineHeight;
    //
    UIView *pwdArea = [self createAreaWithFrame:CGRectMake(0, y, kAreaWidth, kCommonHeight) imageName:@"pwd" placeHolder:_pwdPlaceHolder];
    [_inputAreas addSubview:pwdArea];
}

- (UIView *)createAreaWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                    placeHolder:(NSString *)placeHolder
{
    UIView *area = [[UIView alloc] initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat size = kCommonHeight-20;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPhoneMargin, 10, size, size)];
    imageView.image = image;
    [area addSubview:imageView];
    
    //
    UITextField *textField = [self textFieldWithFrame:CGRectMake(kPhoneMargin*2+size, 10, kAreaWidth-kPhoneMargin*3-size, kCommonHeight-20) placeHolder:placeHolder];
    [area addSubview:textField];
    [_textFields addObject:textField];
    return area;
}

- (void)addLoginButton
{
    CGFloat margin = [UPDeviceInfo isPad] ? kPadMargin : kPhoneMargin;
    CGFloat x = (self.viewMaxWidth - kAreaWidth) /2;
    _yOffset += margin;
    
    _mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mainButton.frame = CGRectMake(x, _yOffset, kAreaWidth, kCommonHeight);
    _mainButton.layer.cornerRadius = 4;
    _mainButton.clipsToBounds = YES;
    [_mainButton setTitle:_buttonTitle forState:UIControlStateNormal];
    [_mainButton setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [_mainButton addTarget:self action:@selector(mainAction:) forControlEvents:UIControlEventTouchUpInside];
    _mainButton.titleLabel.font = [VISViewCreator defaultFontWithSize:20];
    [self.contentScrollView addSubview:_mainButton];
    _yOffset += kCommonHeight;
}

- (void)addHelpInfos
{
    CGFloat margin = [UPDeviceInfo isPad] ? kPadMargin : kPhoneMargin;
    CGFloat x = (self.viewMaxWidth - kAreaWidth) /2;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 20 : 18;
    _yOffset += (margin-10);
    // register
    CGRect registerFrame = CGRectMake(x, _yOffset, kAreaWidth/2, 35);
    UPUnderLineButton *registerButton = [[UPUnderLineButton alloc]
                                         initWithFrame:registerFrame
                                         title:@"快速注册"
                                         font:[VISViewCreator defaultFontWithSize:fontSize]
                                         textAlignment:NSTextAlignmentLeft ];
    registerButton.actionBlock = ^{
        VISRegisterViewController *registerViewController = [[VISRegisterViewController alloc] init];
        [self.navigationController pushViewController:registerViewController animated:YES];
    };
    [self.contentScrollView addSubview:registerButton];
    
    // find pwd
    CGRect findFrame = CGRectMake(x + kAreaWidth/2, _yOffset, kAreaWidth/2, 35);
    UPUnderLineButton *findButton = [[UPUnderLineButton alloc]
                                     initWithFrame:findFrame
                                     title:@"忘记密码"
                                      font:[VISViewCreator defaultFontWithSize:fontSize]
                             textAlignment:NSTextAlignmentRight];
    findButton.actionBlock = ^{
        VISResetPwdViewController *resetViewController = [[VISResetPwdViewController alloc] initWithType:VISResetPwdTypeForget];
        [self.navigationController pushViewController:resetViewController animated:YES];
    };

    [self.contentScrollView addSubview:findButton];
}


- (void)handleTap:(UITapGestureRecognizer *)tap
{
    [_activeTextField resignFirstResponder];
    _activeTextField = nil;

}

- (UITextField *)textFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.placeholder = placeHolder;
    textField.backgroundColor = [UIColor clearColor];
    return textField;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeTextField = textField;
}



@end
