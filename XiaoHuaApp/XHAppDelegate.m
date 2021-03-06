//
//  XHAppDelegate.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-27.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHAppDelegate.h"
#import "XHJokesController.h"
#import "XHMessagesController.h"
#import "XHUserController.h"
#import "XHSettingController.h"
#import "MMDrawerController.h"
#import "XHLeftSideDrawerViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@interface XHAppDelegate ()
@property (nonatomic,strong) MMDrawerController *drawerController;

@end

@implementation XHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    XHLeftSideDrawerViewController *leftSideDrawerViewController = [[XHLeftSideDrawerViewController alloc] init];
        
    XHJokesController *jokesController = [[XHJokesController alloc] initWithNibName:nil bundle:nil];
    jokesController.channel = @"";
    
    UINavigationController *jokesNav = [[UINavigationController alloc] initWithRootViewController:jokesController];

    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:jokesNav leftDrawerViewController:leftSideDrawerViewController];
    [self.drawerController setShowsShadow:YES];
    self.window.rootViewController = self.drawerController;
    
    [ShareSDK registerApp:SHARE_SDK_KEY];
    [ShareSDK connectSinaWeiboWithAppKey:SINA_KEY
                               appSecret:SINA_SECRET
                             redirectUri:@"http://www.xiaohuabolan.com/auth/weibo/callback"];
    
    [ShareSDK connectQQWithQZoneAppKey:QQ_KEY
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];

    [ShareSDK connectWeChatWithAppId:WX_KEY   //微信APPID
                           appSecret:WX_SECRET  //微信APPSecret
                           wechatCls:[WXApi class]];
    [ShareSDK connectSMS];
    //连接邮件
    [ShareSDK connectMail];
    //连接拷贝
    [ShareSDK connectCopy];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
