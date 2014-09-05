//
//  XHSettingController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHSettingController.h"
#import "XHLoginController.h"
#import "XHPreferences.h"
#import "MBProgressHUD.h"
#import "XHJokeFormController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface XHSettingController ()

@end

@implementation XHSettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = PRIMARY_BG_COLOR;
        _loginButton.backgroundColor = PRIMARY_BUTTON_COLOR;
        _loginButton.layer.cornerRadius = 4;

        _registerButton.layer.borderColor = SECONDADY_BUTTON_COLOR.CGColor;
        _registerButton.layer.borderWidth = 1.0f;
        _registerButton.layer.cornerRadius = 4;
        
        _postButton.layer.cornerRadius = 4;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = @"我";
    [label sizeToFit];
    
    _userSettingTable.dataSource = self;
    _userSettingTable.delegate = self;
}
- (IBAction)displayLoginForm:(id)sender {
    XHLoginController *loginForm =[[XHLoginController alloc] initWithNibName:@"XHLoginController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginForm];
    [self presentViewController:navController animated:YES completion:^{}];    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [self resetLoginState];
    [_userSettingTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([XHPreferences userDidLogin]) {
        return 3;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([XHPreferences userDidLogin] && indexPath.section == 0) {
        return 70.f;
    } else {
        return 44.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
    cell.textLabel.textColor = PRIMARY_GRAY_COLOR;
    
    if ([XHPreferences userDidLogin]) {
        if (indexPath.section == 0) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[XHPreferences avatarUrl]] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
            imageView.frame = CGRectMake(10, 15, 40, 40);
            imageView.layer.cornerRadius = 20;
            imageView.clipsToBounds = YES;
            [cell addSubview:imageView];

            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 160, 30)];
            label.text = [XHPreferences name];
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textColor = PRIMARY_BUTTON_COLOR;
            [cell addSubview:label];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tag = 0;
            
        } else if (indexPath.section == 1) {
            cell.imageView.image = [UIImage imageNamed:@"setting.png"];
            cell.textLabel.text = @"清除缓存";
            cell.tag = 1;
        } else {
            cell.imageView.image = [UIImage imageNamed:@"power.png"];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = @"退出";
            cell.tag = 9;
        }
    } else {
        cell.imageView.image = [UIImage imageNamed:@"setting.png"];
        cell.textLabel.text = @"清除缓存";
        cell.tag = 1;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%i", cell.tag);
    
    if (cell.tag == 9) {
        [XHPreferences setPrivateToken:NULL];
        [XHPreferences setName:NULL];
        [XHPreferences setAvatarUrl:NULL];
        [XHPreferences setEmail:NULL];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [tableView reloadData];
        [self resetLoginState];
        [alert show];        
    } else if (cell.tag == 1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在清理";
        [hud show:YES];
        [self performSelector:@selector(hideHud:) withObject:hud afterDelay:2];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void) resetLoginState
{
    if ([XHPreferences userDidLogin]) {
        _loginButton.hidden = YES;
        _registerButton.hidden = YES;
        _postButton.hidden = NO;
    } else {
        _loginButton.hidden = NO;
        _registerButton.hidden = NO;
        _postButton.hidden = YES;
    }
}

- (void) hideHud:(MBProgressHUD *)hud
{
    hud.labelText = @"清理完成";
    [hud hide:YES];
}

- (IBAction)postButtonPressed:(id)sender {
    XHJokeFormController *jokeForm =[[XHJokeFormController alloc] initWithNibName:@"XHJokeFormController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:jokeForm];
    
    [self presentViewController:navController animated:YES completion:^{}];
}
@end
