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

@interface XHJokesController ()

@end

@implementation XHJokesController

- (void)performAdd:(id)sender
{
    XHJokeFormController *jokeForm =[[XHJokeFormController alloc] initWithNibName:@"XHJokeFormController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:jokeForm];
    
    [self presentViewController:navController animated:YES completion:^{}];
}


- (void)fetchJokesWithPage:(NSNumber *)page
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
    
    NSLog(@"%@", kApiURL);
    NSDictionary *parameters = @{@"page": page};
    
    [manager GET:@"jokes.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.currentPage = [NSNumber numberWithInt:1];
    self.jokes = [[NSMutableArray alloc] init];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.navigationItem.titleView = label;
    label.text = @"笑话博览";
    [label sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAdd:)];
    self.navigationItem.rightBarButtonItem.tintColor = PRIMARY_GRAY_COLOR;
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
