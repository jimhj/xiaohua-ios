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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"兄弟们给我顶上" delegate:self cancelButtonTitle:@"明白了" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)performReportButtonPressed:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"举报", nil];
    [sheet showInView:[sender superview]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = PRIMARY_BG_COLOR;
        
//        self.backgroundColor = [UIColor whiteColor];
//        self.layer.borderColor = [UIColor redColor].CGColor;
//        self.layer.borderWidth = 1.0f;
        
        self.cellMainView = [[UIView alloc] init];
        
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentLabel setFont:[UIFont systemFontOfSize:CELL_FONT_SIZE]];
        [self.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [self addSubview:self.contentLabel];
        
        self.jokePicture = [[UIImageView alloc] init];
        self.jokePicture.contentMode = UIViewContentModeScaleToFill;
//        [self addSubview:self.jokePicture];
        
        self.cellMainView.backgroundColor = [UIColor whiteColor];
        [self.cellMainView addSubview: self.contentLabel];
        [self.cellMainView addSubview: self.jokePicture];


        self.bottomView = [[UIView alloc] init];
        self.bottomView.frame = CGRectMake(0, 0, CELL_WIDTH, CELL_BOTTOM_VIEW_HEIGHT);
        
        self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
        self.upButton.frame = CGRectMake(0, 0, CELL_BUTTON_WIDTH, CELL_BUTTON_WIDTH);
        self.downButton.frame = CGRectMake(CELL_BUTTON_WIDTH, 0, CELL_BUTTON_WIDTH, CELL_BUTTON_WIDTH);
        self.commentButton.frame = CGRectMake(CELL_BUTTON_WIDTH * 2, 0, CELL_BUTTON_WIDTH, CELL_BUTTON_WIDTH);
        self.reportButton.frame = CGRectMake(260, 8, 12, CELL_BUTTON_WIDTH);
        
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

        UIImageView *_reportButtonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0, 12, 3)];
        _reportButtonIcon.image = [UIImage imageNamed:@"more.png"];
        [self.reportButton addSubview:_reportButtonIcon];
        [self.reportButton addTarget:self action:@selector(performReportButtonPressed:) forControlEvents:UIControlEventTouchDown];

        [self.bottomView addSubview:self.upButton];
        [self.bottomView addSubview:self.downButton];
        [self.bottomView addSubview:self.commentButton];
        [self.bottomView addSubview:self.reportButton];
        
        [self.cellMainView addSubview:self.bottomView];
        
//        self.cellMainView.layer.borderColor = [UIColor blueColor].CGColor;
//        self.cellMainView.layer.borderWidth = 1.0f;
        
        [self addSubview:self.cellMainView];
//        [self addSubview:self.bottomLeftView];
    }
    
    return self;
}

- (void)setUpCell:(XHJoke *)joke
{
    NSMutableAttributedString *attributedContentText = [joke setContentTextLineHeight:4];
    
    self.cellMainView.frame = joke.mainFrame;
    self.contentLabel.attributedText = attributedContentText;
    self.contentLabel.textColor = [UIColor colorWithRed:0.27 green:0.26 blue:0.26 alpha:1];
    self.contentLabel.frame = joke.textFrame;
    
    if ([joke didHavePicture]) {
        self.jokePicture.frame = joke.pictureFrame;
        [self.jokePicture sd_setImageWithURL:[NSURL URLWithString:joke.picture_url] placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    } else {
        self.jokePicture.image = nil ;
    }

    self.bottomView.frame = [joke bottomFrame];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self didSelectReportOption];
    }
}

- (void)didSelectReportOption
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"举报成功"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
