//
//  VISLoginViewController.h
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISBaseViewController.h"

#define kCommonHeight 44
#define kSperatorLineHeight 1

#define kAreaWidth ([UPDeviceInfo isPad] ? 350 : (self.viewMaxWidth-2*kPhoneSideMargin))

#define kPhoneMargin 20
#define kPhoneSideMargin 12
#define kPadMargin 40
#define kSperatorLineHeight 1

#define kPadBorderWidth 1
#define kPhoneBorderWidth 1


@interface VISLoginViewController : VISBaseViewController<UITextFieldDelegate>
{
    NSString *_namePlaceHolder;
    NSString *_pwdPlaceHolder;
    NSString *_buttonTitle;
    NSString *_loadingMessage;
    
    UIView *_inputAreas;
    CGFloat _yOffset;
    UIButton *_mainButton;
}

@property(nonatomic)BOOL reLogin;

- (void)showModalBarButtonWithTitle:(NSString *)title;


#pragma mark - Optional

- (UITextField *)textFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

- (void)addTapGesture;

- (void)addInputArea;

- (UIView *)createAreaWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                    placeHolder:(NSString *)placeHolder;

- (void)addLoginButton;

- (void)addHelpInfos;

- (void)mainAction:(id)sender;

- (void)gotoNextPage;

@end
