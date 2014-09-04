//
//  XHUser.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-3.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XHJoke;

@interface XHUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *avatarUrl;

+ (BOOL) authorize: (NSString *) email password:(NSString *)password;
+ (XHUser *) currentUser;
+ (void) checkLogin;

@end
