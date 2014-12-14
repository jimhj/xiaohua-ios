//
//  XHComment.m
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/12/14.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHComment.h"

@implementation XHComment

+ (XHComment *) initWithDictionary:(NSDictionary *)dict
{
    XHComment *comment = [[XHComment alloc] init];
    
    comment._id = [dict objectForKey:@"id"];
    comment.body = [dict objectForKey:@"body"];
    comment.user = [XHUser initWithDictionary:[dict objectForKey:@"user"]];
    
    return comment;
}
@end
