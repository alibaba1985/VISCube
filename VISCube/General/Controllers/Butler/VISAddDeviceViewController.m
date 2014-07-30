//
//  VISAddDeviceViewController.m
//  VISCube
//
//  Created by liwang on 14-7-28.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISAddDeviceViewController.h"


@interface VISAddDeviceViewController ()

@end

@implementation VISAddDeviceViewController

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
    self.title = @"设备";
    NSString *imageName = [UPDeviceInfo isPad] ? @"find_large" : @"find";
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageWidth = image.size.width/2;
    CGFloat imageHeight = image.size.height/2;
    NSString *title = @"正在搜寻设备...";
    CGFloat fontSize = [UPDeviceInfo isPad] ? 24 : 18;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat imageMargin = 10;
    //
    
    
    CGFloat margin = (self.viewMaxWidth - imageWidth - imageMargin - titleSize.width)/2;
    CGFloat x = margin;
    CGFloat y = [UPDeviceInfo isPad] ? 50 : 20;
    CGFloat bgHeight = 50;
    // add bg view
    CGRect bgFrame = CGRectMake(0, y, self.viewMaxWidth, bgHeight);
    UIView *bgView = [[UIView alloc] initWithFrame:bgFrame];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];

    
    // add head image
    
    y = (bgHeight - imageHeight)/2;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(x, y, imageWidth, imageHeight);
    [bgView addSubview:imageView];
    
    // add title
    x += (imageWidth + imageMargin);
    
    CGRect titleFrame = CGRectMake(x, y, 300, imageHeight);
    VISLabel *titleLabel = [VISViewCreator wrapLabelWithFrame:titleFrame
                                                         text:@"正在搜寻设备..."
                                                         font:font
                            
                                                    textColor:[UIColor blackColor]];
    
    titleLabel.verticalAlignment = VISVerticalAlignmentMiddle;
    [bgView addSubview:titleLabel];
    
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

@end
