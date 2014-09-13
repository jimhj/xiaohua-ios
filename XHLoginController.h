//
//  XHLoginController.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHLoginController : UIViewController <UIScrollViewDelegate>
{
    __weak IBOutlet UITextField *_emailTextField;
    __weak IBOutlet UITextField *_passwordTextField;
    __weak IBOutlet UIButton *_loginButton;
    __weak IBOutlet UIButton *_registerButton;
    __weak IBOutlet UIScrollView *_scrollView;
}

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)registViewButtonPressed:(id)sender;

@end
