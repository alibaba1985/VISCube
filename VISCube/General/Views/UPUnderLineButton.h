//
//  UPUnderLineButton.h
//  UPPayPluginEx
//
//  Created by liwang on 13-5-23.
//
//

#import <UIKit/UIKit.h>

typedef void(^UnderLineBlock)(void);

@interface UPUnderLineButton : UIView

@property(nonatomic, strong)UnderLineBlock actionBlock;

- (UPUnderLineButton *)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;






@end
