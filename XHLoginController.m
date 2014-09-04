//
//  XHLoginController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHLoginController.h"

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
    label.text = @"注册";
    [label sizeToFit];
        
    [self setTextFieldStyle:_emailTextField];
    [self setTextFieldStyle:_passwordTextField];
    
    _loginButton.layer.cornerRadius = 4;
    _loginButton.backgroundColor = PRIMARY_BUTTON_COLOR;
    
    _registerButton.layer.cornerRadius = 4;
    _registerButton.layer.borderColor = SECONDADY_BUTTON_COLOR.CGColor;
    _registerButton.layer.borderWidth = 1.f;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
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

@end
