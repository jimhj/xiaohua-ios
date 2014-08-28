//
//  XHJokeCell.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHJoke.h"

@interface XHJokeCell : UITableViewCell

@property (nonatomic, strong) XHJoke *joke;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSString *jokeContent;
@property (nonatomic, strong) UIImageView *jokePicture;
@property (nonatomic, strong) UIImageView *authorAvatar;
@property (nonatomic, strong) UILabel *authorName;

- (void)setUpCell:(XHJoke *)joke;

@end
