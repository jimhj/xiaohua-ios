//
//  XHComment.h
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/12/14.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHUser.h"

@interface XHComment : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) XHUser *user;

+ (XHComment *) initWithDictionary:(NSDictionary *)dict;
@end
