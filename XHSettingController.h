//
//  XHSettingController.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHSettingController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_userSettingTable;
    __weak IBOutlet UIButton *_loginButton;
    
    __weak IBOutlet UIButton *_registerButton;
}
@end
