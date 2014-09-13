//
//  XHRegisterController.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-5.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHRegisterController : UIViewController <UIScrollViewDelegate>
{
    __weak IBOutlet UITextField *_emailTextField;
    __weak IBOutlet UITextField *_nameTextField;
    __weak IBOutlet UITextField *_pwdTextField;
    __weak IBOutlet UIButton *_registerButton;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIButton *_loginViewButton;
}
- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)loginViewButtonPressed:(id)sender;

@end
