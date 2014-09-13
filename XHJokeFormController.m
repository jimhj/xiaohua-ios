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

#define kFORM_PLACEHOLDER @"分享我知道的笑料, 内容务必要纯洁啊 ! >_<"
#define kOFFSET_FOR_KEYBOARD 80.0
#define kMainScreeHeight [[UIScreen mainScreen] bounds].size.height
#define kImageViewWidth 220

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
        
        if (jokeContent.length == 0 || [jokeContent isEqualToString:kFORM_PLACEHOLDER]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你还啥都没有写呢 - -" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        } else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"正在发布...";
            [hud show:YES];
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary: @{@"content": _contentTextView.text, @"token": [XHPreferences privateToken]}];
            
            
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];

            [manager POST:@"jokes.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                if (_imageView.image != nil) {
                    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.9);
                    [formData appendPartWithFileData:imageData name:@"picture" fileName:@"sample.jpeg" mimeType:@"image/jpeg"];
                }
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
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

- (UIToolbar *)setToolBarPosition
{
    CGRect frame = CGRectMake(0, kMainScreeHeight - 44, self.view.bounds.size.width, 44);
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:frame];
    
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
    
    toolBar.items = [NSArray arrayWithObjects:spacer, pictureButton, spacer_2, cameraButton, nil];
    
    return toolBar;
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
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _imageView.userInteractionEnabled = YES;
    _imageView.hidden = YES;
    [self.view addSubview:_imageView];
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(removePictureView) forControlEvents:UIControlEventTouchUpInside];
    _closeButton.hidden = YES;
    
    [self.view addSubview:_closeButton];
    
    _contentTextView.text = kFORM_PLACEHOLDER;
    _contentTextView.textColor = [UIColor lightGrayColor];
    _contentTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _contentTextView.delegate = self;
    
    self.toolBar = [self setToolBarPosition];
    
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
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc ] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    float frameHeight = kImageViewWidth * _imageView.image.size.height / _imageView.image.size.width;
    float imageOffsetY = (kMainScreeHeight - frameHeight) / 2 + 20;
    
    [_imageView setFrame:CGRectMake(50, imageOffsetY, kImageViewWidth, frameHeight)];

    _closeButton.frame = CGRectMake(kImageViewWidth + 50 - 12, imageOffsetY - 12, 24, 24);
    
    _imageView.hidden = NO;
    _closeButton.hidden = NO;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        _contentTextView.inputAccessoryView = self.toolBar;
    
    }];
}

- (void)dismissKeyboard {
    [_contentTextView resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_contentTextView.text isEqual: kFORM_PLACEHOLDER]) {
        _contentTextView.text = @"";
        _contentTextView.textColor = [UIColor blackColor];
    }

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_contentTextView.text.length == 0) {
        _contentTextView.text = kFORM_PLACEHOLDER;
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
