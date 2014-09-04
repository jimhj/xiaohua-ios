//
//  XHJoke.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHJoke : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *picture_url;
@property (nonatomic,copy) NSString *picture_width;
@property (nonatomic,copy) NSString *picture_height;
@property (nonatomic,copy) NSString *up_votes_count;
@property (nonatomic,copy) NSString *down_votes_count;
@property (nonatomic,copy) NSString *comments_count;

@property (nonatomic,copy) NSString *contentText; // content 为空时取 title 为内容

+ (XHJoke *) initWithDictionary:(NSDictionary *)dict;
- (CGSize)calcContentTextSize;
- (CGFloat)calcCellHeight;
- (CGRect)textFrame;
- (CGRect)pictureFrame;
- (CGRect)bottomFrame;
- (NSMutableAttributedString *)setContentTextLineHeight:(CGFloat)lineHeight;
- (BOOL) didHavePicture;


@end
