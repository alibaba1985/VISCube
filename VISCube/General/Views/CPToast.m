//
//  CPToast.m
//  Cashier
//
//  Created by liwang on 14-1-23.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "CPToast.h"
#import "UPDeviceInfo.h"

#define kTopMargin 20
#define kMaxHeught 300
#define kWidth     260
#define kLoadingHeight 160
#define kFontSize  20
#define kDelay     3
#define kBGAlpha   0.3
#define kBGCornerRadius 3;
#define kGoldenPoint 0.42
#define kIndicatorSize 30

#define kSystemAnimationDuration 0.25
#define kMainAlpha 0.8

@interface CPToast ()
{
    UIView *_contentView;
    UIView *_bacgroundView;
    UIView *_toastView;
    UILabel *_titleLabel;
    CGPoint _center;
    BOOL _loading;
}
@property(nonatomic, assign)CGPoint realCenter;
@property(nonatomic, assign)UIView *realSuperView;

- (void)didShowToastOnTop;

- (void)didShowToastOnCenter;

- (void)didDidmissToast;

- (void)hide;

- (CGSize)calcuateMessageSize:(NSString *)message;

@end

@implementation CPToast
@synthesize realCenter;
@synthesize realSuperView;

- (void)dealloc
{
    self.realCenter = CGPointZero;
    self.realSuperView = nil;
    
    [super dealloc];
}


- (CGSize)calcuateMessageSize:(NSString *)message
{
    UIFont *font = [UIFont systemFontOfSize:kFontSize];
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [message boundingRectWithSize:CGSizeMake((kWidth-2*kTopMargin), 500)
                                        options:option
                                     attributes:@{NSFontAttributeName : font}
                                        context:nil];
    return rect.size;
}

- (id)initWithLoadingMessage:(NSString *)message onView:(UIView *)view
{
    
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        self.realSuperView = view;
        _loading = YES;
        // add bg
        
        
        _bacgroundView = [[UIView alloc] initWithFrame:self.realSuperView.bounds];
        _bacgroundView.backgroundColor = [UIColor blackColor];
        _bacgroundView.alpha = kBGAlpha;
        [self addSubview:_bacgroundView];
        [_bacgroundView release];
        // add content
        CGRect contentFrame = CGRectZero;
        CGSize size = [self calcuateMessageSize:message];
        contentFrame.size = CGSizeMake(kTopMargin*2 + size.width, kTopMargin*3 + size.height + kIndicatorSize);
        _contentView = [[UIView alloc] initWithFrame:contentFrame];
        _contentView.backgroundColor = [UIColor blackColor];
        _contentView.layer.cornerRadius = kBGCornerRadius;
        _contentView.alpha = kMainAlpha;
        _contentView.center = CGPointMake(CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)*kGoldenPoint);
        [self addSubview:_contentView];
        [_contentView release];
        
        CGRect titleFrame = CGRectMake(kTopMargin, kTopMargin, size.width, size.height);
        _titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
        _titleLabel.text = message;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.font = [UIFont systemFontOfSize:kFontSize];
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [indicator setFrame:CGRectMake(0, 0, kIndicatorSize, kIndicatorSize)];
        indicator.center = CGPointMake(_contentView.frame.size.width/2, _contentView.frame.size.height-kIndicatorSize*2/3 - kTopMargin);
        [indicator startAnimating];
        [_contentView addSubview:indicator];
        [indicator release];
        
    }
    
    return self;
}



- (id)initWithMessage:(NSString *)message onView:(UIView *)view
{
  
    self = [super initWithFrame:view.bounds];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.realSuperView = view;
        
        // add content
        CGRect contentFrame = CGRectZero;
        CGSize size = [self calcuateMessageSize:message];
        contentFrame.size = CGSizeMake(kTopMargin*2 + size.width, kTopMargin*2 + size.height);
        _contentView = [[UIView alloc] initWithFrame:contentFrame];
        _contentView.backgroundColor = [UIColor blackColor];
        _contentView.layer.cornerRadius = kBGCornerRadius;
        _contentView.center = CGPointMake(CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)*kGoldenPoint);
        _contentView.alpha = kMainAlpha;
        [self addSubview:_contentView];
        [_contentView release];
        
        CGRect titleFrame = CGRectMake(kTopMargin, kTopMargin, size.width, size.height);
        _titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
        _titleLabel.text = message;
        _titleLabel.font = [UIFont systemFontOfSize:kFontSize];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        
        // position
        
        _bacgroundView = [[UIView alloc] initWithFrame:self.realSuperView.bounds];
        _bacgroundView.backgroundColor = [UIColor blackColor];
        _bacgroundView.alpha = kBGAlpha;
        [self insertSubview:_bacgroundView belowSubview:_contentView];
        [_bacgroundView release];
        
        self.alpha = 0;
    }
    return self;
}



- (void)didShowToastOnCenter
{
    [self performSelector:@selector(hide) withObject:nil afterDelay:kDelay];
}

- (void)didShowToastOnTop
{
    [self performSelector:@selector(hide) withObject:nil afterDelay:kDelay];
}

- (void)didDidmissToast
{
    [self removeFromSuperview];
}

- (void)animationWithDuration:(CGFloat)duration
                    endAction:(SEL)action
                       target:(id)target
                        block:(void (^)(void))block
{
    [UIView beginAnimations:@"block" context:nil];
    [UIView setAnimationDelegate:target];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:action];
    block();
    [UIView commitAnimations];
}


- (void)show
{
    [self.realSuperView addSubview:self];
    [self.realSuperView bringSubviewToFront:self];
    __block CPToast *weakSelf = self;
    
    if (_loading)
    {
        [self animationWithDuration:kSystemAnimationDuration endAction:nil target:nil block:^{
            weakSelf.alpha = 1;
        }];

    }
    else
    {
        [self animationWithDuration:kSystemAnimationDuration endAction:@selector(didShowToastOnCenter) target:self block:^{
            weakSelf.alpha = 1;
        }];
    }
    
}

- (void)dismiss
{
    [self hide];
}


- (void)hide
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
