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
    [self setTextFieldStyle:_nameTextField];
    [self setTextFieldStyle:_passwordTextField];
    
    _registerButton.layer.cornerRadius = 4;
    _registerButton.backgroundColor = PRIMARY_BUTTON_COLOR;
    
    _loginButton.layer.cornerRadius = 4;
    _loginButton.layer.borderColor = SECONDADY_BUTTON_COLOR.CGColor;
    _loginButton.layer.borderWidth = 1.f;
    
    
//    CGRect textFieldFrame = _emailTextField.frame;
//    textFieldFrame.size.height = 100;
//    _emailTextField.frame = textFieldFrame;
//    
//    CGRect nameFieldFrame = _nameTextField.frame;
//    nameFieldFrame.size.height = 100;
//    _nameTextField.frame = nameFieldFrame;
//    
//    CGRect pwdFieldFrame = _passwordTextField.frame;
//    pwdFieldFrame.size.height = 100;
//    _passwordTextField.frame = pwdFieldFrame;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
