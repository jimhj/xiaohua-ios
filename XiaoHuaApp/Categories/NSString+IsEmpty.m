//
//  NSString+IsEmpty.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

//
//  NSString+IsEmpty.m
//  RubyChina
//
//  Created by dave on 3/28/13.
//  Copyright (c) 2013 dave. All rights reserved.
//

#import "NSString+IsEmpty.h"

@implementation NSString (IsEmpty)


- (BOOL)isEmpty {
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [self stringByTrimmingCharactersInSet:charSet];
    BOOL _bool = [trimmed isEqualToString:@""] || [trimmed isEqualToString:@"<null>"];
    
    return _bool;
}

@end
