//
//  XHJokesController.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHJokesController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate>
{
    NSInteger _loadTimes;
}

@property (nonatomic, retain) NSMutableArray *jokes;
@property (nonatomic, copy) NSNumber *currentPage;
@property (nonatomic, copy) NSString *channel;

@end
