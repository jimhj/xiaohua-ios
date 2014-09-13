//
//  XHLoginController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHLoginController.h"
#import "XHUser.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "NSString+IsEmpty.h"
#import "XHPreferences.h"
#import "XHSettingController.h"
#import "XHRegisterController.h"

@interface XHLoginController ()

@end

@implementation XHLoginController

- (void) setTextFieldStyle:(UITextField *)textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.borderColor = SECONDADY_BUTTON_COLOR.CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.layer.cornerRadius = 4.f;
}

- (void)dissmissLoginFormModal:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    label.text = @"登录";
    [label sizeToFit];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] init];
    leftBar.title = @"取消";
    leftBar.tintColor = PRIMARY_GRAY_COLOR;
    [leftBar setTarget:self];
    [leftBar setAction:@selector(dissmissLoginFormModal:)];
    self.navigationItem.leftBarButtonItem = leftBar;
        
    [self setTextFieldStyle:_emailTextField];
    [self setTextFieldStyle:_passwordTextField];
    
    _registerButton.layer.cornerRadius = 4;
    _registerButton.backgroundColor = PRIMARY_BUTTON_COLOR;
    
    _loginButton.layer.cornerRadius = 4;
    _loginButton.layer.borderColor = SECONDADY_BUTTON_COLOR.CGColor;
    _loginButton.layer.borderWidth = 1.f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    _scrollView.delegate = self;
    _scrollView.contentSize = self.view.frame.size;
}

-(void)dismissKeyboard {
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在登录...";
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
    NSDictionary *parameters = @{@"email": _emailTextField.text, @"password": _passwordTextField.text};
    
    [hud show:YES];
    
    [manager POST:@"users/sign_in.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        NSString *error = [responseObject objectForKey:@"error"];
        if ([error isEmpty] || (error.length == 0)) {
            [XHPreferences setPrivateToken:[responseObject objectForKey:@"private_token"]];
            [XHPreferences setEmail:[responseObject objectForKey:@"email"]];
            [XHPreferences setName:[responseObject objectForKey:@"name"]];
            [XHPreferences setAvatarUrl:[responseObject objectForKey:@"avatar_url"]];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            NSLog(@"%@", [XHPreferences name]);
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];    
}

- (IBAction)registViewButtonPressed:(id)sender
{
    XHRegisterController *registForm =[[XHRegisterController alloc] initWithNibName:@"XHRegisterController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:registForm];
    
    [self presentViewController:navController animated:YES completion:nil];
}
@end
