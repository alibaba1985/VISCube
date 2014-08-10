//
//  VISDeviceDetailViewController.m
//  VISCube
//
//  Created by liwang on 14-7-26.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISAccountCenterViewController.h"
#import "UPDeviceInfo.h"
#import "UPFile.h"

@interface VISAccountCenterViewController ()
{
    NSDictionary *_deviceDetails;
    CGFloat _tableCellRowHeight;
    NSInteger _cellNumber;
    NSArray *_titles;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation VISAccountCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithDeviceDetails:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        // Custom initialization
        _deviceDetails = [NSDictionary dictionaryWithDictionary:details];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"卫仕中心";
    [self addNavigationMenuItem];
    
    /**
     账户管理
     智慧中心
     数据同步
     关于我们
     帮助
     
     */
    
    // Do any additional setup after loading the view.
    _cellNumber = 5;
    _tableCellRowHeight = [UPDeviceInfo isPad] ? 80 : 60;
    CGFloat tableHeight = _tableCellRowHeight * _cellNumber;
    CGFloat y = (self.viewMaxHeight - tableHeight) / 2;
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.viewMaxWidth, tableHeight) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
     
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

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableCellRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return _cellNumber;
}

- (UITableViewCell *)cellWithImage:(UIImage *)image title:(NSString *)title
{
    CGFloat margin = [UPDeviceInfo isPad] ? 20 : 10;
    CGFloat x = margin;
    CGFloat height = 27;
    CGFloat y = (_tableCellRowHeight - height) / 2;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    // add head image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(x, y, height, height);
    [cell.contentView addSubview:imageView];
    
    // add title
    x = margin*2 + height;
    CGFloat fontSize = [UPDeviceInfo isPad] ? 24 : 18;
    CGRect titleFrame = CGRectMake(x, y, self.viewMaxWidth-x, height);
    VISLabel *titleLabel = [VISViewCreator wrapLabelWithFrame:titleFrame
                                                         text:title
                                                         font:
                            [UIFont fontWithName:@"HelveticaNeue" size:fontSize]
                                                    textColor:[UIColor blackColor]];
    
    titleLabel.verticalAlignment = VISVerticalAlignmentMiddle;
    [cell.contentView addSubview:titleLabel];
    
    // add next
    UIImage *next = [UIImage imageNamed:@"next"];
    CGFloat nextHeight = next.size.height/3;
    CGFloat nextWidth = next.size.width/3;
    y = (_tableCellRowHeight-nextHeight)/2;
    imageView = [[UIImageView alloc] initWithImage:next];
    imageView.frame = CGRectMake(self.viewMaxWidth - margin - nextWidth, y, nextWidth, nextHeight);
    [cell.contentView addSubview:imageView];
    
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = nil;
    NSString *title = nil;
    switch (indexPath.row) {
        case 0:
        {
            NSString *path = [UPFile pathForFile:kLocalFileName writable:YES];
            NSString *name = [UPFile readFile:path forKey:kUserName];
            image = [UIImage imageNamed:@"user"];
            title = name;
        }
            
            break;
        case 1:
            image = [UIImage imageNamed:@"edit_delfromhome"];
            title = @"设备中心";
            break;
        case 2:
            image = [UIImage imageNamed:@"cloud"];
            title = @"同步数据";
            break;
        case 3:
            image = [UIImage imageNamed:@"about"];
            title = @"关于我们";
            break;
        case 4:
            image = [UIImage imageNamed:@"help"];
            title = @"使用帮助";
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [self cellWithImage:image title:title];
    
    return cell;
}



@end
