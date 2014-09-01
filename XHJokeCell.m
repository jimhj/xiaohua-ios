//
//  XHJokeCell.m
//  XiaoHuaApp
//
//  Created by HuangJin on 14-8-28.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHJokeCell.h"
#import "XHJoke.h"
#import "NSString+IsEmpty.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define FONT_SIZE 14.0f

@implementation XHJokeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [self.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:self.contentLabel];
        
        self.jokePicture = [[UIImageView alloc] init];
        self.jokePicture.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.jokePicture];

        self.bottomLeftView = [[UIView alloc] init];
        
        self.bottomLeftView.layer.borderColor = [UIColor redColor].CGColor;
        self.bottomLeftView.layer.borderWidth = 1.0f;
        
        self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.upButton.frame = CGRectMake(0, 0, 80.0f, 30.0f);
        
        self.upButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.upButton.layer.borderWidth = 1.0f;
//        [self.upButton setBackgroundImage: [UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
//        [self.upButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.upButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        
    }
    
    return self;
}

- (void)setUpCell:(XHJoke *)joke
{
    
    [self.contentLabel setText:joke.contentText];
    [self.contentLabel setFrame:joke.textFrame];
    
    if (![joke.picture_url isEmpty]) {
        self.jokePicture.frame = joke.pictureFrame;
        [self.jokePicture sd_setImageWithURL:[NSURL URLWithString:joke.picture_url] placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    } else {
        self.jokePicture.image = nil ;
    }
    
    [self.upButton setTitle:joke.up_votes_count forState:UIControlStateNormal];

//    [self.bottomLeftView addSubview:self.upButton];
    self.bottomLeftView.frame = [joke bottomFrame];
    [self addSubview:self.bottomLeftView];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
