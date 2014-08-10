//
//  UPUnderLineButton.m
//  UPPayPluginEx
//
//  Created by liwang on 13-5-23.
//
//

#import "UPUnderLineButton.h"
#import "VISLabel.h"
#import "VISViewCreator.h"


#define kFontSmall            14
#define kCheckBoxHeight       35
#define kInfoBoxHeight        20
#define kMargin               20



@interface UPUnderLineButton()
{
@private
    VISLabel     *_label;
    NSString    *_title;
    UIFont      *_font;
    NSTextAlignment _textAlignment;
}


- (void)addSubViews;

- (void)colorChange:(UIButton *)btn;

- (void)colorBack:(UIButton *)btn;

- (void)touchUpInside:(UIButton *)btn;


@end





@implementation UPUnderLineButton

- (UIColor *)underLineNormalColor
{
    CGFloat red = ((CGFloat)0x30)/0xFF;
    CGFloat green = ((CGFloat)0x74)/0xFF;
    CGFloat blue = ((CGFloat)0xAB)/0xFF;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (UIColor *)underLineDownColor
{
    CGFloat red = ((CGFloat)0x0D)/0xFF;
    CGFloat green = ((CGFloat)0x3D)/0xFF;
    CGFloat blue = ((CGFloat)0x71)/0xFF;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (UPUnderLineButton *)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _title = (title == nil) ? nil : [NSString stringWithString:title];
        _font = font;
        _textAlignment = textAlignment;
        
        [self addSubViews];
        
    }
    return self;
}


#pragma mark- Member Functions



- (void)addSubViews
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGSize labelSize = [_title sizeWithAttributes:@{NSFontAttributeName : _font}];

    CGRect frame = CGRectMake(x, y, labelSize.width, CGRectGetHeight(self.frame));
    _label = [VISViewCreator wrapLabelWithFrame:frame text:_title font:_font textColor:[self underLineNormalColor]];
    _label.verticalAlignment = VISVerticalAlignmentMiddle;
    [self addSubview:_label];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(x, y, labelSize.width, CGRectGetHeight(self.frame));
    [btn addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(colorChange:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(colorBack:) forControlEvents:UIControlEventTouchDragOutside];
    [self addSubview:btn];
    
    CGRect newFrame = self.frame;
    if (_textAlignment == NSTextAlignmentRight) {
        newFrame.origin.x += (newFrame.size.width-labelSize.width);
        newFrame.size.width = labelSize.width;
        _label.textAlignment = _textAlignment;
    }
    else
    {
        newFrame.size.width = labelSize.width;
    }
    self.frame = newFrame;
    
}

- (void)colorChange:(UIButton *)btn
{
    [_label setTextColor:[self underLineDownColor]];
}
- (void)colorBack:(UIButton *)btn
{
    [_label setTextColor:[self underLineNormalColor]];
}
- (void)touchUpInside:(UIButton *)btn
{
    [self colorBack:btn];
    if (_actionBlock) {
        _actionBlock();
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

@end
