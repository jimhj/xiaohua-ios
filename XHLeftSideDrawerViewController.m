//
//  XHLeftSideDrawerViewController.m
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/11/2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHLeftSideDrawerViewController.h"
#import "XHJokesController.h"
#import "XHPreferences.h"
#import "XHLoginController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface XHLeftSideDrawerViewController ()

@end

@implementation XHLeftSideDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_navTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    
    _navTableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"drawer.png"]];
    
    if ([XHPreferences userDidLogin]) {
        _logoutButton.hidden = NO;
    }
    
    _navTableView.dataSource = self;
    _navTableView.delegate = self;
    
    _versionLabel.text = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    
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
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70.f;
    } else {
        return 50.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:18.0f]];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.56 green:0.59 blue:0.56 alpha:1];
    
    UIView *cellBg = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = cellBg;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:0.6];
    
    if (indexPath.row == 0) {
        UIImageView *imageView = [[UIImageView alloc] init];
        if ([XHPreferences userDidLogin]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[XHPreferences avatarUrl]] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
        } else {
            imageView.image = [UIImage imageNamed:@"avatar.png"];
        }

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
        cell.textLabel.text = @"新鲜出炉";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"美女美图";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"邪恶漫画";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"糗事幽默";
    } else {
        cell.textLabel.text = @"内涵段子";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        if ([XHPreferences userDidLogin]) {
            NSLog(@"Need to display user info here.");
        } else {
        
            XHLoginController *loginForm = [[XHLoginController alloc] initWithNibName:@"XHLoginController" bundle:nil];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginForm];
    
            [self presentViewController:navController animated:YES completion:^{}];
        }

    } else {
        XHJokesController *center = [[XHJokesController alloc] init];
        
        switch (indexPath.row) {
            case 1:
                center.channel = @"";
                break;
            case 2:
                center.channel = @"meinvmeitu";
                break;
            case 3:
                center.channel = @"xieemanhua";
                break;
            case 4:
                center.channel = @"youmoqiushi";
                break;
            case 5:
                center.channel = @"neihanduanzi";
                break;
            default:
                break;
        }

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:center];
        [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];


    }
    
}

- (IBAction)logoutButtonPressed:(id)sender {
    [XHPreferences setPrivateToken:NULL];
    [XHPreferences setName:NULL];
    [XHPreferences setAvatarUrl:NULL];
    [XHPreferences setEmail:NULL];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [_navTableView reloadData];
    [self resetLoginState];
    [alert show];
}

- (void) resetLoginState
{
    _logoutButton.hidden = ![XHPreferences userDidLogin];
}
@end
