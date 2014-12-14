//
//  XHJokeDetailViewController.m
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/12/14.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHJokeDetailViewController.h"
#import "XHJoke.h"
#import "XHComment.h"
#import "XHJokeCell.h"
#import "XHCommentCell.h"
#import "NSString+IsEmpty.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"

#define CELL_BUTTON_WIDTH 60.f

@interface XHJokeDetailViewController ()

@end


@implementation XHJokeDetailViewController

- (void) initDetailCell
{
    
}

- (void)loadComments
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
    
    NSString *url;
    
    url = [[NSString alloc] initWithFormat:@"jokes/%@/comments.json", self.joke._id];
    
    NSLog(@"request url: %@", url);
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.comments removeAllObjects];
        
        for (NSDictionary *dict in responseObject) {
            XHComment *comment = [XHComment initWithDictionary:dict];
            [self.comments addObject:comment];
        }
        
        
        [self.tableView reloadData];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"笑话博览" message:@"网络不给力" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.comments = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = PRIMARY_BG_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor clearColor];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"笑话%@", self.joke._id];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [self.navigationItem setBackBarButtonItem:back];
    self.navigationController.navigationBar.topItem.backBarButtonItem = back;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return self.comments.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self.joke calcCellHeight];
    } else {
        return 44.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    
        XHJokeCell *jokeCell = [tableView dequeueReusableCellWithIdentifier:@"XHJokeCell"];
        if (jokeCell == nil) {
            jokeCell = [[XHJokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHJokeCell"];
        }
    
        return jokeCell;
    } else {
        XHCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"XHCommentCell"];
        if (commentCell == nil) {
            commentCell = [[XHCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHCommentCell"];
        }
        return commentCell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [(XHJokeCell *)cell setUpCell:self.joke];
    } else {
        XHComment *comment = [self.comments objectAtIndex:indexPath.row];
        [(XHCommentCell *)cell setUpCell:comment];

    }
}
@end
