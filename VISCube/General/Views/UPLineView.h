//
//  UPLineView.h
//  UPPayPluginEx
//
//  Created by liwang on 13-3-19.
//
//

#import <UIKit/UIKit.h>

@interface UPLineView : UIView
{
    NSInteger lineWidth;
    UIColor * lineColor;
}

@property (nonatomic, retain) UIColor * lineColor;

-(id)initWithFrame:(CGRect)frame color:(UIColor *) color;


@end
