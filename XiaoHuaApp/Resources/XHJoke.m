//
//  XHJoke.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHJoke.h"
#import "NSString+IsEmpty.h"

#define CELL_WIDTH 320.0f
#define CELL_MARGIN 10.0f
#define FONT_SIZE 14.0f
#define DEFAULT_HEIGHT 44.0f

@implementation XHJoke

+ (XHJoke *) initWithDictionary:(NSDictionary *)dict
{
    XHJoke *joke = [[XHJoke alloc] init];
    NSString *contentText = [[NSString alloc] init];
    
    joke.title = [dict objectForKey:@"title"];
    joke.content = [dict objectForKey:@"content"];
    
    if ([joke.content isEmpty]) {
        contentText = joke.title;
    } else {
        contentText = joke.content;
    }
//    NSLog(@"%@", contentText);
    
    [contentText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [contentText stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    joke.contentText = contentText;
    
    joke.picture_url = [dict objectForKey:@"picture_url"];
    joke.picture_width = [[dict objectForKey:@"dimensions"]objectForKey:@"width"];
    joke.picture_height = [[dict objectForKey:@"dimensions"]objectForKey:@"height"];
    joke.up_votes_count = [NSString stringWithFormat:@"%@", [dict objectForKey:@"up_votes_count"]];
    joke.down_votes_count = [NSString stringWithFormat:@"%@", [dict objectForKey:@"down_votes_count"]];
    
    return joke;
}

- (CGSize)calcContentTextSize
{
    CGSize constraint = CGSizeMake(CELL_WIDTH - (CELL_MARGIN * 2), 20000.0f);
    
    
    NSAttributedString *attrText =[[NSAttributedString alloc]initWithString:self.contentText
                                                                 attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE] }];
    
    CGRect rect = [attrText boundingRectWithSize:constraint
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                         context:nil];
    CGSize size = rect.size;
    
    return size;
}

- (CGFloat)calcCellHeight
{
    CGSize size = [self calcContentTextSize];
    
    CGFloat height = 0.0f;
    height = MAX(size.height, DEFAULT_HEIGHT);
    height = height + CELL_MARGIN;
    
    if (![self.picture_url isEmpty]) {
        float picWidth = CELL_WIDTH - (CELL_MARGIN * 2);
        float picHeight = picWidth * [self.picture_height floatValue] / [self.picture_width floatValue];
        height = height + picHeight;
        height = height + CELL_MARGIN;
    }
    
//    NSLog(@"%f", height);
    return height;
}

@end
