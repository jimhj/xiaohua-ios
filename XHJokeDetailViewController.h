//
//  XHJokeDetailViewController.h
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/12/14.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHJoke.h"

@interface XHJokeDetailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) XHJoke *joke;
@property (nonatomic, retain) NSMutableArray *comments;

@end
