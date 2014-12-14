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

+ (XHUser *)initWithDictionary:(NSDictionary *)dict
{
    XHUser *user = [[XHUser alloc] init];
    
    user.name = [dict objectForKey:@"name"];
    user.email = [dict objectForKey:@"email"];
    user.avatarUrl = [dict objectForKey:@"avatar_url"];
    
    return user;
}


@end
