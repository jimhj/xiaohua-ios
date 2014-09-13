//
//  XHRegisterController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-5.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHRegisterController.h"
#import "XHLoginController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "XHPreferences.h"
#import "NSString+IsEmpty.h"

@interface XHRegisterController ()

@end

@implementation XHRegisterController

- (void) setTextFieldStyle:(UITextField *)textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.borderColor = SECONDADY_BUTTON_COLOR.CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.layer.cornerRadius = 4.f;
}

- (void)dissmissRegisterFormModal:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.navigationItem.titleView = label;
    label.text = @"注册";
    [label sizeToFit];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] init];
    leftBar.title = @"取消";
    leftBar.tintColor = PRIMARY_GRAY_COLOR;
    [leftBar setTarget:self];
    [leftBar setAction:@selector(dissmissRegisterFormModal:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    _registerButton.layer.cornerRadius = 4;
    
    [self setTextFieldStyle:_emailTextField];
    [self setTextFieldStyle:_nameTextField];
    [self setTextFieldStyle:_pwdTextField];
    
    _scrollView.delegate = self;
    _scrollView.contentSize = self.view.frame.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButtonPressed:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在登录...";
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
    NSDictionary *parameters = @{@"email": _emailTextField.text,
                                 @"name": _nameTextField.text,
                                 @"password":_pwdTextField.text};
    
    [hud show:YES];
    
    [manager POST:@"users/sign_up.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *error = [responseObject objectForKey:@"error"];
        if ([error isEmpty] || (error.length == 0)) {
            [XHPreferences setPrivateToken:[responseObject objectForKey:@"private_token"]];
            [XHPreferences setEmail:[responseObject objectForKey:@"email"]];
            [XHPreferences setName:[responseObject objectForKey:@"name"]];
            [XHPreferences setAvatarUrl:[responseObject objectForKey:@"avatar_url"]];
            hud.labelText = @"注册成功啦 >_<";
            [hud hide:YES afterDelay:4];
            [self dismissViewControllerAnimated:YES completion:^{}];
        } else {
            [hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (IBAction)loginViewButtonPressed:(id)sender
{
//    __weak XHRegisterController *WeakSelf = self;
    
    XHLoginController *loginForm =[[XHLoginController alloc] initWithNibName:@"XHLoginController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginForm];
    
    [self presentViewController:navController animated:YES completion:nil];
}
@end
