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

#define CELL_BUTTON_WIDTH 60.f

@implementation XHJokeCell

- (void)performUpVoteButtonPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"兄弟们给我顶上" delegate:self cancelButtonTitle:@"明白了" otherButtonTitles:nil, nil];
    [alert show];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentLabel setFont:[UIFont systemFontOfSize:CELL_FONT_SIZE]];
        [self.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:self.contentLabel];
        
        self.jokePicture = [[UIImageView alloc] init];
        self.jokePicture.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.jokePicture];

        self.bottomLeftView = [[UIView alloc] init];
        self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        self.bottomLeftView.layer.borderColor = [UIColor redColor].CGColor;
//        self.bottomLeftView.layer.borderWidth = 1.0f;
//        self.upButton.layer.borderColor = [UIColor redColor].CGColor;
//        self.upButton.layer.borderWidth = 1.0f;
//        self.downButton.layer.borderColor = [UIColor greenColor].CGColor;
//        self.downButton.layer.borderWidth = 1.0f;
        
        self.upButton.frame = CGRectMake(0, 0, CELL_BUTTON_WIDTH, CELL_BUTTON_WIDTH);
        self.downButton.frame = CGRectMake(CELL_BUTTON_WIDTH, 0, CELL_BUTTON_WIDTH, CELL_BUTTON_WIDTH);
        self.commentButton.frame = CGRectMake(CELL_BUTTON_WIDTH * 2, 0, 60, CELL_BUTTON_WIDTH);
        
        UIImageView *_upButtonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        _upButtonIcon.image = [UIImage imageNamed:@"up.png"];
        self.upButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 30, 16)];
        self.upButtonLabel.font = [UIFont systemFontOfSize:14.0f];
        self.upButtonLabel.textColor = PRIMARY_GRAY_COLOR;
        [self.upButton addTarget:self action:@selector(performUpVoteButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self.upButton addSubview:_upButtonIcon];
        [self.upButton addSubview:self.upButtonLabel];
        
        UIImageView *_downButtonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        _downButtonIcon.image = [UIImage imageNamed:@"down.png"];
        self.downButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 30, 16)];
        self.downButtonLabel.font = [UIFont systemFontOfSize:14.0f];
        self.downButtonLabel.textColor = PRIMARY_GRAY_COLOR;
        [self.downButton addSubview:_downButtonIcon];
        [self.downButton addSubview:self.downButtonLabel];
    
        UIImageView *_commentButtonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0, 21, 16)];
        _commentButtonIcon.image = [UIImage imageNamed:@"comment.png"];
        self.commentButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 40, 16)];
        self.commentButtonLabel.font = [UIFont systemFontOfSize:14.0f];
        self.commentButtonLabel.textColor = PRIMARY_GRAY_COLOR;
        [self.commentButton addSubview:_commentButtonIcon];
        [self.commentButton addSubview:self.commentButtonLabel];

        [self.bottomLeftView addSubview:self.upButton];
        [self.bottomLeftView addSubview:self.downButton];
        [self.bottomLeftView addSubview:self.commentButton];
        
        [self addSubview:self.bottomLeftView];
    }
    
    return self;
}

- (void)setUpCell:(XHJoke *)joke
{
    NSMutableAttributedString *attributedContentText = [joke setContentTextLineHeight:4];
    
    self.contentLabel.attributedText = attributedContentText;
    self.contentLabel.textColor = [UIColor colorWithRed:0.27 green:0.26 blue:0.26 alpha:1];
    self.contentLabel.frame = joke.textFrame;
    
    if ([joke didHavePicture]) {
        self.jokePicture.frame = joke.pictureFrame;
        [self.jokePicture sd_setImageWithURL:[NSURL URLWithString:joke.picture_url] placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    } else {
        self.jokePicture.image = nil ;
    }

    self.bottomLeftView.frame = [joke bottomFrame];
    self.upButtonLabel.text = joke.up_votes_count;
    self.downButtonLabel.text = joke.down_votes_count;
    self.commentButtonLabel.text = joke.comments_count;
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
