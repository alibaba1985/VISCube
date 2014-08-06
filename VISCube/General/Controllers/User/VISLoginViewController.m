//
//  VISLoginViewController.m
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISLoginViewController.h"
#import "UPLineView.h"

#define kAreaWidth 280
#define kCommonHeight 44
#define kPhoneMargin 20
#define kPadMargin 40
#define kSperatorLineHeight 0.5

@interface VISLoginViewController ()
{
    UITextField *_activeTextField;
    CGFloat _yOffset;
}

- (void)loginAction:(id)sender;

- (void)addTapGesture;

- (void)addInputArea;

- (UIView *)createAreaWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                    placeHolder:(NSString *)placeHolder;

- (void)addLoginButton;

- (void)addHelpInfos;

- (UITextField *)textFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

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

- (void)gotoHomePage
{
    [self dismissLoading];
}

- (void)loginAction:(id)sender
{
    [self showLoadingWithMessage:@"正在玩儿命登录..."];
    [self performSelector:@selector(gotoHomePage) withObject:nil afterDelay:2];
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
    CGFloat margin = [UPDeviceInfo isPad] ? kPadMargin : kPhoneMargin;
    CGFloat x = (self.viewMaxWidth - kAreaWidth) /2;
    CGFloat y = margin;
    
    CGRect areaFrame = CGRectMake(x, y, kAreaWidth, kCommonHeight*2+kSperatorLineHeight);
    UIView *areas = [[UIView alloc] initWithFrame:areaFrame];
    areas.backgroundColor = [UIColor whiteColor];
    areas.clipsToBounds = YES;
    areas.layer.cornerRadius = 4;
    areas.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    areas.layer.borderWidth = 0.5;
    
    [self.view addSubview:areas];
    _yOffset = CGRectGetMaxY(areaFrame);
    //
    y = 0;
    UIView *nameArea = [self createAreaWithFrame:CGRectMake(0, y, kAreaWidth, kCommonHeight) imageName:@"user" placeHolder:@"登录邮箱"];
    [areas addSubview:nameArea];
    y += kCommonHeight;
    //
    CGRect lineFrame = CGRectMake(0, y, kAreaWidth, kSperatorLineHeight);
    UPLineView *line = [[UPLineView alloc] initWithFrame:lineFrame color:[UIColor colorWithWhite:0.8 alpha:1]];
    [areas addSubview:line];
    y += kSperatorLineHeight;
    //
    UIView *pwdArea = [self createAreaWithFrame:CGRectMake(0, y, kAreaWidth, kCommonHeight) imageName:@"pwd" placeHolder:@"密码"];
    [areas addSubview:pwdArea];
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
    
    return area;
}

- (void)addLoginButton
{
    CGFloat margin = [UPDeviceInfo isPad] ? kPadMargin : kPhoneMargin;
    CGFloat x = (self.viewMaxWidth - kAreaWidth) /2;
    _yOffset += margin;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, _yOffset, kAreaWidth, kCommonHeight);
    button.layer.cornerRadius = 4;
    button.clipsToBounds = YES;
    [button setTitle:@"登    录" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [VISViewCreator defaultFontWithSize:20];
    [self.view addSubview:button];
    
}

- (void)addHelpInfos
{
    
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
    //textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //textField.textAlignment = NSTextAlignmentCenter;
    textField.placeholder = placeHolder;
    //textField.font = [UIFont systemFontOfSize:30];
    textField.backgroundColor = [UIColor clearColor];
    return textField;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeTextField = textField;
}


@end
