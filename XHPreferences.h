//
//  XHPreferences.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-3.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHPreferences : NSObject

+ (NSString *) privateToken;
+ (void)setPrivateToken:(NSString *)value;

+ (NSString *) email;
+ (void) setEmail: (NSString *)value;

+ (NSString *) name;
+ (void) setName: (NSString *)value;

+ (NSString *) avatarUrl;
+ (void)setAvatarUrl:(NSString *)value;
+ (UIImage *)avatarImage;

+ (BOOL)userDidLogin;

@end
