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

+ (XHUser *) currentUser;
+ (XHUser *) initWithDictionary:(NSDictionary *)dict;

@end
