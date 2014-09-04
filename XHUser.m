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

+ (BOOL)authorize:(NSString *)email password:(NSString *)password
{
    __block BOOL result = NO;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
    NSDictionary *parameters = @{@"email": email, @"password": password};
    [manager POST:@"users/sign_in.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        result = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    return result;
}

+ (XHUser *)currentUser
{
    return _currentUser;
}

+ (void)checkLogin
{
    [self authorize:[XHPreferences email] password:[XHPreferences password]];
}

@end
