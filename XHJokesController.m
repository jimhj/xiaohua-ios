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
#import "MBProgressHUD.h"

@interface XHJokesController ()

@end

@implementation XHJokesController

- (void) performAdd:(id)sender
{
    NSLog(@"Add button pressed!");
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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.jokes = [[NSMutableArray alloc] init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.navigationItem.titleView = label;
    label.text = @"笑话博览";
    [label sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAdd:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHue:0.4 saturation:0.83 brightness:0.6 alpha:1];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.xiaohuabolan.com/api/jokes.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dict in responseObject) {
//            NSLog(@"dic: %@", dict);
            XHJoke *joke = [XHJoke initWithDictionary:dict];
            [self.jokes addObject:joke];
        }
        [self.tableView reloadData];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"笑话博览" message:@"网络不给力" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Load: %lu jokes.", (unsigned long)[self.jokes count]);
    return [self.jokes count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
