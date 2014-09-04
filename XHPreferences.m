//
//  XHPreferences.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-3.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHPreferences.h"

@implementation XHPreferences

+ (NSString *) privateToken
{
    return [[self userDefatuls] stringForKey:@"private_token"];
}

+ (void)setPrivateToken:(NSString *)value
{
    [self setValue:value forKey:@"private_token"];
}

+ (NSString *)email
{
    return [[self userDefatuls] stringForKey:@"email"];
}

+ (void)setEmail:(NSString *)value
{
    [self setValue:value forKey:@"email"];
}

+ (NSString *)name
{
    return [[self userDefatuls] stringForKey:@"name"];
}

+ (void)setName:(NSString *)value
{
    [self setValue:value forKey:@"name"];
}


+ (NSString *)password
{
    return [[self userDefatuls] stringForKey:@"password"];
}

+ (void)setPassword:(NSString *)value
{
    [self setValue:value forKey:@"password"];
}

#pragma mark - Private
+ (NSUserDefaults *) userDefatuls {
    return [NSUserDefaults standardUserDefaults];
}

+ (void) setValue:(id) value forKey:(NSString *) key {
    [[self userDefatuls] setValue:value forKey:key];
    [[self userDefatuls] synchronize];
}
@end
