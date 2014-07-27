//
//  WLDevice.m
//  VISCube
//
//  Created by liwang on 14-7-21.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISDevice.h"
#import "VISConsts.h"
#import "VISViewCreator.h"
#import "UPDeviceInfo.h"

#define kMargin 6

@interface VISDevice ()
{
    NSDictionary *_deviceInfo;
    UIButton *_actionButton;
}

- (void)makeShadowLayer;

- (void)makeNormalLayer;

- (void)parseLocalInfo:(NSDictionary *)info;

- (void)addSubviews;

- (void)touchDownAction;

- (void)touchUpInsideAction;

- (void)touchDragOutAction;

- (void)touchDragInAction;

@end

@implementation VISDevice

- (id)initWithFrame:(CGRect)frame info:(NSDictionary *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        //self.clipsToBounds = YES;
        [self makeShadowLayer];
        [self parseLocalInfo:info];
        [self addSubviews];
    }
    return self;
}

- (void)makeShadowLayer
{
    self.layer.cornerRadius = 5;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:1].CGColor;
    self.layer.borderWidth = 1;
}


- (void)makeNormalLayer
{
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowColor = [UIColor clearColor].CGColor;
}


- (void)parseLocalInfo:(NSDictionary *)info
{
    _deviceInfo = [NSDictionary dictionaryWithDictionary:info];
    NSString *imageName = [_deviceInfo objectForKey:kDeviceImage];
    self.deviceImage = [UIImage imageNamed:imageName];
    self.deviceName = [_deviceInfo objectForKey:kDeviceName];
    self.deviceLocation = [_deviceInfo objectForKey:kDeviceLocation];
    self.deviceStatus = [_deviceInfo objectForKey:kDeviceStatus];
}

- (void)addSubviews
{
    // add action button
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _actionButton.frame = self.bounds;
    _actionButton.exclusiveTouch = YES;
    _actionButton.userInteractionEnabled = YES;
    _actionButton.clipsToBounds = YES;
    [_actionButton addTarget:self action:@selector(touchUpInsideAction) forControlEvents:UIControlEventTouchUpInside];
    [_actionButton addTarget:self action:@selector(touchDownAction) forControlEvents:UIControlEventTouchDown];
    [_actionButton addTarget:self action:@selector(touchDragInAction) forControlEvents:UIControlEventTouchDragEnter];
    [_actionButton addTarget:self action:@selector(touchDragOutAction) forControlEvents:UIControlEventTouchDragExit];
    
    [self addSubview:_actionButton];
    
    // add image
    CGFloat y = kMargin;
    CGFloat imageSize = CGRectGetHeight(self.frame)/2-2*kMargin;
    CGFloat imageX = (CGRectGetWidth(self.frame) - imageSize) / 2;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.deviceImage];
    imageView.frame = CGRectMake(imageX, y, imageSize, imageSize);
    [_actionButton addSubview:imageView];
    y = CGRectGetHeight(self.frame)/2 + kMargin;
    y = [UPDeviceInfo isPad] ? y+kMargin : y;
    CGFloat labelHeight = [UPDeviceInfo isPad] ? 24 : 20;
    // add name
    CGRect nameFrame = CGRectMake(kMargin, y, CGRectGetWidth(self.frame) - kMargin*2, labelHeight);
    VISLabel *nameLabel = [VISViewCreator middleTruncatingLabelWithFrame:nameFrame
                            text:self.deviceName
                            font:[UIFont systemFontOfSize:labelHeight-6]
                       textColor:[UIColor blackColor]];
    [_actionButton addSubview:nameLabel];
    y += kMargin*2 + labelHeight;
    y = [UPDeviceInfo isPad] ? y : y-kMargin;
    // add location
    CGRect locationFrame = CGRectMake(kMargin, y, CGRectGetWidth(self.frame) - kMargin*2, labelHeight);
    VISLabel *locationLabel = [VISViewCreator middleTruncatingLabelWithFrame:locationFrame
                                text:self.deviceLocation
                                font:[UIFont systemFontOfSize:labelHeight-10]
                           textColor:[UIColor blackColor]];
    [_actionButton addSubview:locationLabel];
    
    
    // add status indicator
    NSString *imageName = nil;
    if ([self.deviceStatus isEqualToString:kValue0]) {
        imageName = @"open_on.png";
    }else if ([self.deviceStatus isEqualToString:kValue1]){
        imageName = @"close_off.png";
    }else if ([self.deviceStatus isEqualToString:kValue2]){
        imageName = @"light_yellow.jpg";
    }
    
    if (imageName != nil) {
        UIImage *statusImage = [UIImage imageNamed:imageName];
        UIImageView *statusImageView = [[UIImageView alloc] initWithImage:statusImage];
        statusImageView.frame = CGRectMake(CGRectGetWidth(self.frame)-kMargin-20, kMargin, 20, 10);
        [_actionButton addSubview:statusImageView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchDownAction
{
    [self makeNormalLayer];
}

- (void)touchUpInsideAction
{
    [self makeShadowLayer];
    if ([_deviceDelegate respondsToSelector:@selector(didSelectedDevice:info:)]) {
        [_deviceDelegate didSelectedDevice:self info:_deviceInfo];
    }
}

- (void)touchDragOutAction
{
    [self makeShadowLayer];
}

- (void)touchDragInAction
{
    [self makeNormalLayer];
}


- (void)resume
{
    [self makeShadowLayer];
}

@end
