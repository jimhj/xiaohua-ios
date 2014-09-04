//
//  XHPreferences.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-3.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHPreferences.h"
#import <SDWebImage/UIImageView+WebCache.h>


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

+ (BOOL)userDidLogin
{
    return [self privateToken].length > 0;
}

+ (NSString *) avatarUrl
{
    return [[self userDefatuls] stringForKey:@"avatar_url"];
}

+ (void)setAvatarUrl:(NSString *)value
{
    [self setValue:value forKey:@"avatar_url"];
}

+(UIImage *)avatarImage
{
    __block UIImage *avatar;
    
    if ([self avatarUrl].length == 0) {
        avatar = [UIImage imageNamed:@"avatar.png"];
    } else {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:[self avatarUrl]]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 
                             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                 avatar = image;
                             }];
    }
    
    return avatar;
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
