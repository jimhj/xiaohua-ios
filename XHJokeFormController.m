//
//  XHJokeFormController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHJokeFormController.h"

#define FORM_PLACEHOLDER @"分享我知道的笑料, 内容务必要纯洁啊 ! >_<"

@interface XHJokeFormController ()

@end

@implementation XHJokeFormController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.navigationItem.titleView = label;
    label.text = @"发表笑料";
    [label sizeToFit];
    
    _contentTextView.text = FORM_PLACEHOLDER;
    _contentTextView.textColor = [UIColor lightGrayColor];
    _contentTextView.delegate = self;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _contentTextView.text = @"";
    _contentTextView.textColor = [UIColor blackColor];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_contentTextView.text.length == 0) {
        _contentTextView.text = FORM_PLACEHOLDER;
        _contentTextView.textColor = [UIColor lightGrayColor];
        [_contentTextView resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
