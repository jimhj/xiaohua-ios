//
//  XHJoke.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHJoke.h"
#import "NSString+IsEmpty.h"

@implementation XHJoke

+ (XHJoke *) initWithDictionary:(NSDictionary *)dict
{
    XHJoke *joke = [[XHJoke alloc] init];
    NSMutableString *contentText = [[NSMutableString alloc] init];
    
    joke.title = [dict objectForKey:@"title"];
    joke.content = [dict objectForKey:@"content"];
    
    if ([joke.content isEmpty]) {
        [contentText setString:joke.title];
    } else {
        [contentText setString:joke.content];
    }
    
    [contentText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [contentText stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSLog(@"%@", contentText);
    
    joke.contentText = contentText;
    
    joke.picture_url = [dict objectForKey:@"picture_url"];
    joke.picture_width = [[dict objectForKey:@"dimensions"]objectForKey:@"width"];
    joke.picture_height = [[dict objectForKey:@"dimensions"]objectForKey:@"height"];
    joke.up_votes_count = [NSString stringWithFormat:@"%@", [dict objectForKey:@"up_votes_count"]];
    joke.down_votes_count = [NSString stringWithFormat:@"%@", [dict objectForKey:@"down_votes_count"]];
    joke.comments_count = [NSString stringWithFormat:@"%@", [dict objectForKey:@"comments_count"]];
    if ([joke.comments_count isEmpty]) {
        joke.comments_count = @"0";
    }
    
    return joke;
}

- (CGSize)calcContentTextSize
{
    CGSize constraint = CGSizeMake(CELL_WIDTH - (CELL_MARGIN * 2), 20000.0f);
    
    
    NSAttributedString *attrText =[[NSAttributedString alloc]initWithString:self.contentText
                                                                 attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:CELL_FONT_SIZE] }];
    
    CGRect rect = [attrText boundingRectWithSize:constraint
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                         context:nil];
    CGSize size = rect.size;
    size.height = size.height;
    
    return size;
}

- (CGFloat)calcCellHeight
{
    float height = 0;
    float textFrameHeight = [self textFrame].size.height;
    height = height + textFrameHeight;
    
    if (![self.picture_url isEmpty]) {
        float pictureFrameHeight = [self pictureFrame].size.height;
        height = height + pictureFrameHeight;
    }
    
    height = height + CELL_BOTTOM_VIEW_HEIGHT;
    height = height + CELL_MARGIN * 3;
    
    return height;
}

- (CGRect)textFrame
{
    CGSize size = [self calcContentTextSize];
    float frameHeight = size.height + CELL_MARGIN;
    
    CGRect frame = CGRectMake(CELL_MARGIN, CELL_MARGIN, CELL_WIDTH - (CELL_MARGIN * 2), frameHeight);
    return frame;
}

- (CGRect)pictureFrame
{
    CGRect frame;
    CGSize textFrameSize = [self textFrame].size;
    
    float offsetY = CELL_MARGIN + textFrameSize.height;
    float picHeight = textFrameSize.width * [self.picture_height floatValue] / [self.picture_width floatValue];
    float frameHeight = picHeight;
        
    frame = CGRectMake(CELL_MARGIN, offsetY, textFrameSize.width, frameHeight);
    
    return frame;
}

- (CGRect)bottomFrame
{
    CGRect frame;
    CGSize textFrameSize = [self textFrame].size;
    CGSize pictureFrameSize = [self pictureFrame].size;
    
    float offsetY = CELL_MARGIN + textFrameSize.height;
    
    if (![self.picture_url isEmpty]) {
        offsetY = offsetY + pictureFrameSize.height;
    }
    
    offsetY = offsetY + CELL_MARGIN;
    
    frame = CGRectMake(CELL_MARGIN, offsetY, textFrameSize.width, CELL_BOTTOM_VIEW_HEIGHT);
    return frame;
}

@end
