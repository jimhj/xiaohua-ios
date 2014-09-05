//
//  XHJokeFormController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHJokeFormController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "XHPreferences.h"
#import "NSString+IsEmpty.h"

#define FORM_PLACEHOLDER @"分享我知道的笑料, 内容务必要纯洁啊 ! >_<"

@interface XHJokeFormController ()

@end

@implementation XHJokeFormController

- (void)dissmissJokeFormModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) postJoke:(id)sender
{
    if ([XHPreferences userDidLogin]) {
        NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *jokeContent = [_contentTextView.text stringByTrimmingCharactersInSet:charSet];
        if (jokeContent.length == 0 || [jokeContent isEqualToString:FORM_PLACEHOLDER]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你还啥都没有写呢 - -" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"正在发布...";
            [hud show:YES];
            
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
            NSDictionary *parameters = @{@"content": _contentTextView.text, @"token": [XHPreferences privateToken]};
            
            [manager POST:@"jokes.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                hud.mode = MBProgressHUDModeText;
                
                NSString *error = [responseObject objectForKey:@"error"];
                if ([error isEmpty] || (error.length == 0)) {
                    hud.labelText = @"发布成功，等待审稿 ：）";
                    [hud hide:YES afterDelay:3];
                    [self dismissViewControllerAnimated:YES completion:^{}];
                } else {
                    [hud hide:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [hud hide:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }];
        }
    }
}

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
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] init];
    leftBar.title = @"取消";
    leftBar.tintColor = PRIMARY_GRAY_COLOR;
    [leftBar setTarget:self];
    [leftBar setAction:@selector(dissmissJokeFormModal:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] init];
    rightBar.title = @"投稿";
    [rightBar setTarget:self];
    [rightBar setAction:@selector(postJoke:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    _contentTextView.text = FORM_PLACEHOLDER;
    _contentTextView.textColor = [UIColor lightGrayColor];
    _contentTextView.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [_contentTextView resignFirstResponder];
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

- (void) handleKeyboardDidShow:(NSNotification *) notification
{
    NSValue *keyboardRectAsObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = CGRectZero;
    
    [keyboardRectAsObject getValue:&keyboardRect];
    
    _contentTextView.contentInset = UIEdgeInsetsMake(60.f, 0.f, keyboardRect.size.height - 60.f, 0.f);
}

- (void) handleKeyboardWillHide:(NSNotification *) notification
{
    _contentTextView.contentInset = UIEdgeInsetsMake(60.f, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _contentTextView.frame = self.view.bounds;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
