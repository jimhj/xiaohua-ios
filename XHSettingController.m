//
//  XHSettingController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHSettingController.h"

@interface XHSettingController ()

@end

@implementation XHSettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
        _loginButton.layer.cornerRadius = 10;

        _registerButton.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1].CGColor;
        _registerButton.layer.borderWidth = 1.0f;
        _registerButton.layer.cornerRadius = 10;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = @"我";
    [label sizeToFit];
    
    _userSettingTable.dataSource = self;
    _userSettingTable.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.imageView.image = [UIImage imageNamed:@"setting.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"清除缓存";
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
//    cell.textLabel.text.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor = PRIMARY_GRAY_COLOR;
    return cell;
}

@end
