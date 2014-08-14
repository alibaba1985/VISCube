//
//  WLAppDelegate.m
//  VISCube
//
//  Created by liwang on 14-7-7.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "WLAppDelegate.h"
#import "VISRootViewController.h"
#import "VISNavigationController.h"
#import "VISHomeViewController.h"
#import "VISLeftMenuViewController.h"
#import "VISButlerViewController.h"
#import "VISSecretaryViewController.h"
#import "VISAccountCenterViewController.h"
#import "VISLoginViewController.h"
#import "VISPreShowViewController.h"
#import "VISWebViewController.h"
#import "VISNavigationBar.h"
#import "VISSourceManager.h"
#import "UPFile.h"


@implementation WLAppDelegate
@synthesize rootViewControler;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    //
    [self createMenuViewControllers];
    //
    [self createMenu];
    [self createPrePage];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self.rootViewControler strokeAnimation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Functions

- (void)createMenuViewControllers
{
    // add home
    NSMutableArray *array = [NSMutableArray array];
    VISNavigationController *home = [[VISNavigationController alloc] initWithNavigationBarClass:[VISNavigationBar class] toolbarClass:nil];
    self.rootViewControler = [[VISHomeViewController alloc] init];
    home.viewControllers = [[NSArray alloc] initWithObjects:self.rootViewControler, nil];
    [array addObject:home];
    
    // add butler.
    VISButlerViewController *root = [[VISButlerViewController alloc] init];
    VISNavigationController *butler = [[VISNavigationController alloc] initWithNavigationBarClass:[VISNavigationBar class] toolbarClass:nil];
    butler.viewControllers = [[NSArray alloc] initWithObjects:root, nil];
    [array addObject:butler];
    
    // add Secretary
    VISSecretaryViewController *secretary = [[VISSecretaryViewController alloc] init];
    VISNavigationController *secretaryNC = [[VISNavigationController alloc] initWithRootViewController:secretary];
    [array addObject:secretaryNC];
    
    // add Merchant
    VISWebViewController *mechant = [[VISWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.jd.com"] barTitle:@"卫仕电商"];
    mechant.shouldShowMenu = YES;
    VISNavigationController *merchantNC = [[VISNavigationController alloc] initWithRootViewController:mechant];
    [array addObject:merchantNC];
    
    // add BBS
    VISWebViewController *bbs = [[VISWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.autohome.com.cn/"] barTitle:@"卫仕魔方"];
    bbs.shouldShowMenu = YES;
    VISNavigationController *bbsNC = [[VISNavigationController alloc] initWithRootViewController:bbs];
    [array addObject:bbsNC];
    
    // add Account Center
    VISAccountCenterViewController *account = [[VISAccountCenterViewController alloc] init];
    VISNavigationController *accountNC = [[VISNavigationController alloc] initWithRootViewController:account];
    [array addObject:accountNC];
    
    
    [VISSourceManager currentSource].menuViewControllers = [NSArray arrayWithArray:array];
}

- (void)createMenu
{
    UIViewController *home = [[VISSourceManager currentSource].menuViewControllers objectAtIndex:0];
    VISLeftMenuViewController *left = [[VISLeftMenuViewController alloc] init];
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:home leftMenuViewController:left rightMenuViewController:nil];
    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.9;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.panGestureEnabled = NO;
    
    [VISSourceManager currentSource].sideMenuViewController = sideMenuViewController;
}

- (void)createPrePage
{
    [[VISSourceManager currentSource] initAllDevices];
    NSString *loginned = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginned];
    if ([loginned isEqualToString:kValueYES]) {
        self.window.rootViewController = [VISSourceManager currentSource].sideMenuViewController;
    }
    else
    {
        VISLoginViewController *login = [[VISLoginViewController alloc] init];
        VISNavigationController *n = [[VISNavigationController alloc] initWithRootViewController:login];
        NSString *firstSetup = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstSetup];
        if (firstSetup == nil || [firstSetup isEqualToString:kValueYES]) {
            VISPreShowViewController *prePage = [[VISPreShowViewController alloc] init];
            [n pushViewController:prePage animated:NO];
        }
        self.window.rootViewController = n;
    }
    
}


#pragma mark - RESideMenuDelegate

- (void)sideMenu:(RESideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
}
- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    
}
- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    
}
- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    
}
- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    
}

@end
