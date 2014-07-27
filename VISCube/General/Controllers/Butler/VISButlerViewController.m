//
//  VISButlerViewController.m
//  VISCube
//
//  Created by liwang on 14-7-24.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISButlerViewController.h"
#import "VISDeviceDetailViewController.h"
#import "UPDeviceInfo.h"
#import "UPFile.h"

#define kPadMargin 64
#define kPhoneMaring 30

@interface VISButlerViewController ()
{
    NSMutableArray *_deviceCollection;
}

- (void)addDevices;

@end

@implementation VISButlerViewController

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
    self.title = @"卫仕管家";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    self.contentScrollView.delegate = self;
    [self addDevices];
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

- (void)addDevices
{
    _devices = [NSArray arrayWithArray:[UPFile readFile:kFileName byKey:@"Devices"]];
    _deviceCollection = [NSMutableArray array];
    NSInteger index = 0;
    
    CGFloat margin = [UPDeviceInfo isPad] ? kPadMargin : kPhoneMaring;
    NSInteger numberAtRow = [UPDeviceInfo isPad] ? 3 : 2;
    NSInteger marginNumber = [UPDeviceInfo isPad] ? 4 : 3;
    CGFloat deviceSize = (self.viewMaxWidth-margin*marginNumber)/numberAtRow;
    CGFloat x = 0;
    CGFloat y = 0;
    CGRect deviceFrame = CGRectZero;
    VISDevice *device = nil;
    
    while (index < _devices.count) {
        x = margin * (index % numberAtRow + 1) + deviceSize * (index % numberAtRow);
        y = margin * (index / numberAtRow + 1) + deviceSize * (index / numberAtRow);
        
        deviceFrame = CGRectMake(x, y, deviceSize, deviceSize);
        device = [[VISDevice alloc] initWithFrame:deviceFrame info:[_devices objectAtIndex:index]];
        device.deviceDelegate = self;
        [self.contentScrollView addSubview:device];
        [_deviceCollection addObject:device];
        
        index ++;
    }
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width, y + margin + deviceSize);
}

#pragma mark - UIScrollViewDelegate



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_deviceCollection makeObjectsPerformSelector:@selector(resume)];
}


#pragma mark - VISDeviceDelegate

- (void)didSelectedDevice:(VISDevice *)device info:(NSDictionary *)info
{
    VISDeviceDetailViewController *d = [[VISDeviceDetailViewController alloc] initWithDeviceDetails:info];
    [self.navigationController pushViewController:d animated:YES];
}


@end
