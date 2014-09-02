//
//  XHLoginController.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHLoginController : UIViewController
{
    __weak IBOutlet UITextField *_emailTextField;
    __weak IBOutlet UITextField *_nameTextField;
    __weak IBOutlet UITextField *_passwordTextField;
    __weak IBOutlet UIButton *_registerButton;
    __weak IBOutlet UIButton *_loginButton;
}

@end
