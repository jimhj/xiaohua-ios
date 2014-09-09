//
//  XHJokeFormController.h
//  XiaoHuaApp
//
//  Created by HuangJin on 14-9-2.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHJokeFormController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    
    IBOutlet UITextView *_contentTextView;
    UIImageView *_imageView;
    UIButton *_closeButton;
}

@property (nonatomic, strong) UIToolbar *toolBar;

@end
