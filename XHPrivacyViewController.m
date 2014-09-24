//
//  XHPrivacyViewController.m
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14-9-24.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHPrivacyViewController.h"

@interface XHPrivacyViewController ()

@end

@implementation XHPrivacyViewController

- (void)dissmissprivacyModal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.navigationItem.titleView = label;
    label.text = @"笑话博览用户协议";
    [label sizeToFit];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] init];
    rightBar.title = @"确认";
    rightBar.tintColor = PRIMARY_GRAY_COLOR;
    [rightBar setTarget:self];
    [rightBar setAction:@selector(dissmissprivacyModal:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"privacy" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
