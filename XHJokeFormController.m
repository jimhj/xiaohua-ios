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
#define kOFFSET_FOR_KEYBOARD 80.0

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
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 200, 220, 10)];
    _imageView.userInteractionEnabled = YES;
    _imageView.hidden = YES;
    [self.view addSubview:_imageView];
    
    _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(248, 188, 24, 24)];
    [_closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(removePictureView) forControlEvents:UIControlEventTouchUpInside];
    _closeButton.hidden = YES;
    
    [self.view addSubview:_closeButton];
    
    _contentTextView.text = FORM_PLACEHOLDER;
    _contentTextView.textColor = [UIColor lightGrayColor];
    _contentTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _contentTextView.delegate = self;
    
    
    float width = self.view.bounds.size.width;
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, width, 44)];
    UIBarButtonItem *pictureButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"picture.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(pictureButtonPressed:)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                            target:nil
                                                                            action:nil];
    spacer.width = 50;
    
    UIBarButtonItem *spacer_2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                              target:nil
                                                                              action:nil];
    spacer_2.width = 120;
    
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"camera.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(cameraButtonPressed:)];
    
    
    self.toolBar.items = [NSArray arrayWithObjects:spacer, pictureButton, spacer_2, cameraButton, nil];
    
    [self.view addSubview:self.toolBar];
    
    _contentTextView.inputAccessoryView = self.toolBar;
}

- (void) removePictureView
{
    _imageView.hidden = YES;
    _closeButton.hidden = YES;
    _imageView.image = nil;
}

- (void) pictureButtonPressed:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{}];
}

- (void) cameraButtonPressed:(id)sender
{
    NSLog(@"11111111");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    float frameHeight = 220 * _imageView.image.size.height / _imageView.image.size.width;
    [_imageView setFrame:CGRectMake(40, 200, 220, frameHeight)];
    
    _imageView.hidden = NO;
    _closeButton.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (float) calcScreenTopBarHeight
{
    float totalHeight = 0.f;
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    totalHeight = statusBarHeight + navBarHeight;
    return totalHeight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
