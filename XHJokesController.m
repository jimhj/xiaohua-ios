//
//  XHJokesController.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHJokesController.h"
#import "XHJokeCell.h"
#import "XHJoke.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "XHJokeFormController.h"
#import "XHLoginController.h"
#import "XHPreferences.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "NSString+IsEmpty.h"
#import "XHJokeDetailViewController.h"

@interface XHJokesController ()

@end

@implementation XHJokesController

- (void)performAdd:(id)sender
{
    UINavigationController *navController;
    
    if ([XHPreferences userDidLogin]) {
        XHJokeFormController *jokeForm =[[XHJokeFormController alloc] initWithNibName:@"XHJokeFormController" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:jokeForm];
        
    } else {
        XHLoginController *loginForm = [[XHLoginController alloc] initWithNibName:@"XHLoginController" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:loginForm];
    }

    [self presentViewController:navController animated:YES completion:^{}];
}

- (UIStatusBarStyle)preferredStatusBarStyle NS_AVAILABLE_IOS(7_0){
    return UIStatusBarStyleLightContent;
}

- (void)fetchJokesWithPage:(NSNumber *)page
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
    
    NSLog(@"%@", kApiURL);
    NSDictionary *parameters = @{@"page": page};
    NSString *url;
    
    if ([self.channel isEmpty]) {
        url = @"jokes.json";
    } else {
        url = [[NSString alloc] initWithFormat:@"jokes/%@.json", self.channel];
    }
    
    NSLog(@"request url: %@", url);
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
        if ([page intValue] == 1) {
            [self.jokes removeAllObjects];
        }
        
        for (NSDictionary *dict in responseObject) {
            XHJoke *joke = [XHJoke initWithDictionary:dict];
            [self.jokes addObject:joke];
        }
        
        [self.tableView reloadData];

        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"笑话博览" message:@"网络不给力" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    NSLog(@"%@", self.channel);
    
    self.tableView.backgroundColor = PRIMARY_BG_COLOR;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.currentPage = [NSNumber numberWithInt:1];
    self.jokes = [[NSMutableArray alloc] init];
    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([self.channel isEmpty]) {
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 69, 24)];
        logo.contentMode = UIViewContentModeScaleAspectFit;
        logo.image = [UIImage imageNamed:@"logo.png"];
        self.navigationItem.titleView = logo;
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = label;
        
        NSDictionary *titles = @{@"meinvmeitu":@"美女美图", @"xieemanhua":@"邪恶漫画", @"youmoqiushi":@"幽默糗事", @"neihanduanzi":@"内涵段子"};

        label.text = [titles objectForKey:self.channel];
        [label sizeToFit];
        self.navigationItem.titleView = label;
    }

    
    [self setupLeftMenuButton];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0.51 blue:0.27 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    

    self.navigationController.navigationBar.translucent = YES;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAdd:)];
    
    self.tabBarController.delegate = self;
    
    _loadTimes = 0;
}


- (void)viewWillAppear:(BOOL)animated {
    __weak XHJokesController *WeakSelf = self;
    
    [self.tableView addHeaderWithCallback:^{
        [WeakSelf fetchJokesWithPage:WeakSelf.currentPage];
    }];
    
    [self.tableView addFooterWithCallback:^{
        WeakSelf.currentPage = [NSNumber numberWithInt:[WeakSelf.currentPage intValue] + 1];
        [WeakSelf fetchJokesWithPage:WeakSelf.currentPage];
    }];
    
    if (_loadTimes == 0) {
         _loadTimes += 1;
        [self.tableView headerBeginRefreshing];
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.tabBarController.selectedIndex == 0 && _loadTimes > 1) {
        _loadTimes = 2;
        [self.tableView headerBeginRefreshing];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    _loadTimes += 1;
}

- (void) viewDidDisappear:(BOOL)animated
{
    _loadTimes -= 1;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Load: %lu jokes.", (unsigned long)[self.jokes count]);
    return [self.jokes count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHJoke * joke = [self.jokes objectAtIndex:indexPath.row];
    return [joke calcCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHJokeCell *jokeCell = [tableView dequeueReusableCellWithIdentifier:@"XHJokeCell"];
    if (jokeCell == nil) {
        jokeCell = [[XHJokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHJokeCell"];
    }
    
    return jokeCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHJoke *joke = [self.jokes objectAtIndex:indexPath.row];
    
//    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [tableView setLayoutMargins:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }

    [(XHJokeCell *)cell setUpCell:joke];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHJoke *joke = [self.jokes objectAtIndex:indexPath.row];
    XHJokeDetailViewController *detail = [[XHJokeDetailViewController alloc] init];
    detail.joke = joke;
    
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
