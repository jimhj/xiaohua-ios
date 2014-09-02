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

@implementation XHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    XHJokesController *jokesController = [[XHJokesController alloc] initWithNibName:nil bundle:nil];
    jokesController.tabBarItem.image = [UIImage imageNamed:@"refresh.png"];
    jokesController.tabBarItem.title = @"笑话";
    UINavigationController *jokesNav = [[UINavigationController alloc] initWithRootViewController:jokesController];
    
    XHMessagesController *msgController = [[XHMessagesController alloc] initWithNibName:@"XHMessagesController" bundle:nil];
    msgController.tabBarItem.image = [UIImage imageNamed:@"message.png"];
    msgController.tabBarItem.title = @"消息";
    UINavigationController *msgNav = [[UINavigationController alloc] initWithRootViewController:msgController];
    
//    XHUserController *userController = [[XHUserController alloc] initWithNibName:nil bundle:nil];
//    userController.tabBarItem.image = [UIImage imageNamed:@"user.png"];
//    userController.tabBarItem.title = @"我";
//    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:userController];

    XHSettingController *settingController = [[XHSettingController alloc] initWithNibName:@"XHSettingController" bundle:nil];
    settingController.tabBarItem.image = [UIImage imageNamed:@"user.png"];
    settingController.tabBarItem.title = @"我";
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:settingController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[jokesNav, msgNav, settingNav];
    self.window.rootViewController = self.tabBarController;
    
    return YES;
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
