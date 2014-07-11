//
//  WLHomeViewController.m
//  VISCube
//
//  Created by liwang on 14-7-8.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "WLHomeViewController.h"
#import "UIImage+ImageEffects.h"


#define kChangeableOriginalY 320
#define kAutoScrollAnchor 160

@interface WLHomeViewController ()
{
    UIImageView *_fixedBackground;
    UIImageView *_changeableBackground;
    UIView *_changeableContentView;
    CGRect _changeableContentFrame;
    CGRect _changeableBackgroundFrame;
    

}

- (void)addFixedBackground;

- (void)addChangeableBackground;

@end

@implementation WLHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIImageView *)imageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bg = [[UIImageView alloc] initWithImage:image];
    //bg.contentMode = UIViewContentModeScaleAspectFill;
    //bg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bg.frame = frame;
    
    return bg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addFixedBackground];
    [self addChangeableBackground];
    
    CGFloat y = 30;
    
    for (NSInteger i = 0; i <15; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 200, 30)];
        label.text = @"test";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [self.contentScrollView addSubview:label];
        y += 70 ;
    }
    
    
    CGSize size = self.contentScrollView.bounds.size;
    size.height = y;
    self.contentScrollView.contentSize = size;
    self.contentScrollView.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
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
#pragma mark- Background ImageView

- (void)addFixedBackground
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= 64;
    UIImage *bgImage = [UIImage imageNamed:@"HomeBG.jpg"];//
    _fixedBackground = [self imageViewWithImage:bgImage frame:frame];
    [self.view insertSubview:_fixedBackground atIndex:0];
}

- (void)addChangeableBackground
{
    CGFloat contentHeight = self.viewMaxHeight - kChangeableOriginalY;
    _changeableContentFrame = CGRectMake(0, kChangeableOriginalY, self.viewMaxWidth, contentHeight);
    _changeableBackgroundFrame = CGRectMake(0, -kChangeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);

    UIImage *bgImage = [UIImage imageNamed:@"HomeBG.jpg"];//
    _changeableBackground = [self imageViewWithImage:[bgImage applyDarkEffect] frame:_changeableBackgroundFrame];
    
    _changeableContentView = [[UIView alloc] initWithFrame:_changeableContentFrame];
    _changeableContentView.clipsToBounds = YES;
    
    [_changeableContentView addSubview:_changeableBackground];
    [self.view insertSubview:_changeableContentView aboveSubview:_fixedBackground];
}



#pragma mark- ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = scrollView.contentOffset.y;
    CGRect frame = _changeableContentFrame;
    frame.origin.y -= offset;
    frame.size.height += offset;
    
    // 最多到顶，但是scrollView的contentOffset是跳跃的不是连续的。
    if (offset >= (kChangeableOriginalY - self.viewMaxHeight)) {
        _changeableContentView.frame = frame;
        frame = _changeableBackgroundFrame;
        frame.origin.y += offset;
        _changeableBackground.frame = frame;
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        return;
    }
    
    CGFloat offset = scrollView.contentOffset.y;
    if (offset >0 && offset <= kAutoScrollAnchor) {
        CGRect rect = CGRectMake(0, 0, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
    }
    else if (offset > kAutoScrollAnchor && offset <= kChangeableOriginalY) {
        CGRect rect = CGRectMake(0, kChangeableOriginalY, self.viewMaxWidth, self.viewMaxHeight);
        [scrollView scrollRectToVisible:rect animated:YES];
        
    }
    
}



@end
