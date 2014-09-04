//
//  XHUser.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-3.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHUser.h"
#import "XHPreferences.h"
#import "AFNetworking.h"

@implementation XHUser

static XHUser *_currentUser;


+ (XHUser *)currentUser
{
    return _currentUser;
}


@end
