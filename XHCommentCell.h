//
//  XHCommentCell.h
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/12/14.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHComment.h"

@interface XHCommentCell : UITableViewCell

@property (nonatomic, strong) UIView *cellMainView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *avatar;

- (void)setUpCell:(XHComment *)comment;

@end
