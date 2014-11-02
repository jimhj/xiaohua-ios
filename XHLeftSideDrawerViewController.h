//
//  XHLeftSideDrawerViewController.h
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/11/2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"

@interface XHLeftSideDrawerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *_navTableView;
}

//@property (nonatomic, strong) NSArray *drawerWidths;
@end
