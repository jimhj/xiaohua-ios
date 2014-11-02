//
//  XHLeftSideDrawerViewController.m
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/11/2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHLeftSideDrawerViewController.h"
#import "XHPreferences.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface XHLeftSideDrawerViewController ()

@end

@implementation XHLeftSideDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_navTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
//    _navTableView.backgroundColor = [UIColor colorWithRed:0.17 green:0.33 blue:0.22 alpha:0.5];
    
    _navTableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"drawer_bg.jpg"]];
    
    _navTableView.dataSource = self;
    _navTableView.delegate = self;
    
    [self.mm_drawerController setMaximumLeftDrawerWidth:240.f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70.f;
    } else {
        return 44.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:18.0f]];
    cell.textLabel.textColor = [UIColor colorWithRed:0.02 green:0.04 blue:0.15 alpha:1];
    
    UIView *cellBg = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = cellBg;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:0.3];
    
    if (indexPath.row == 0) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [XHPreferences avatarImage];
        imageView.frame = CGRectMake(10, 15, 40, 40);
        imageView.layer.cornerRadius = 20;
        imageView.clipsToBounds = YES;
        
        [cell addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 160, 30)];
        label.text = [XHPreferences name];
        label.font = [UIFont systemFontOfSize:18.0f];
        label.textColor = cell.textLabel.textColor;
        [cell addSubview:label];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"美女美图";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"邪恶漫画";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"糗事幽默";
    } else {
        cell.textLabel.text = @"内涵段子";
    }

    return cell;
}

@end
