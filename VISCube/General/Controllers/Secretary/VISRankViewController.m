//
//  VISRankViewController.m
//  VISCube
//
//  Created by liwang on 14-8-10.
//  Copyright (c) 2014年 liwang. All rights reserved.
//

#import "VISRankViewController.h"

@interface VISRankViewController ()
{
    CGFloat _rowHeight;
}

@end

@implementation VISRankViewController

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
    self.title = @"能耗排名";
    self.tableView = [self tableViewWithStyle:UITableViewStylePlain];
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
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _rowHeight = [UPDeviceInfo isPad] ? 80 : 60;
    return _rowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"rankCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    NSString *rank = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    CGFloat rankTag = 100;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        
        // add Rank
        CGFloat width = 50;
        CGFloat x = self.viewMaxWidth - width;
        VISLabel *rankLabel = [VISViewCreator middleTruncatingLabelWithFrame:CGRectMake(x, 0, width, _rowHeight) text:rank font:[VISViewCreator defaultFontWithSize:20] textColor:[UIColor blackColor]];
        rankLabel.tag = rankTag;
        [cell.contentView addSubview:rankLabel];
        
        // add Image
        UIImage *image = [UIImage imageNamed:@"user"];
        cell.imageView.image = image;
        CGRect imageFrame = cell.imageView.frame;
        imageFrame.origin.y = (_rowHeight-image.size.height/2)/2;
        imageFrame.size.width = image.size.width/2;
        imageFrame.size.height = image.size.height/2;
        cell.imageView.frame = imageFrame;
    }
    
    CGFloat leftKWH = 219.90 - (20 -indexPath.row) * 9.12;
    NSString *kwh = [NSString stringWithFormat:@"总耗电:%.2f KWH", leftKWH];
    cell.textLabel.text = kwh;
    cell.detailTextLabel.text = @"测试用户";
    VISLabel *rankLabel = (VISLabel *)[cell.contentView viewWithTag:rankTag];
    rankLabel.text = rank;
    
    return cell;
}

@end
