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

#define CELL_WIDTH 320.0f
#define CELL_MARGIN 10.0f
#define FONT_SIZE 14.0f
#define DEFAULT_HEIGHT 44.0f

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
    }
    return self;
}

- (void)setUpCell:(XHJoke *)joke
{
    [self.contentLabel setText:joke.contentText];
    CGSize size = [joke calcContentTextSize];
    
    float contentTextHeight = MAX(size.height, DEFAULT_HEIGHT);
    
    [self.contentLabel setFrame:CGRectMake(CELL_MARGIN, CELL_MARGIN, CELL_WIDTH - (CELL_MARGIN * 2), contentTextHeight)];
    
    if (![joke.picture_url isEmpty]) {
        
        float picWidth = CELL_WIDTH - (CELL_MARGIN * 2);
        float picHeight = picWidth * [joke.picture_height floatValue] / [joke.picture_width floatValue];
        
        self.jokePicture.frame = CGRectMake(CELL_MARGIN, CELL_MARGIN + contentTextHeight, picWidth, picHeight);
        
        [self.jokePicture sd_setImageWithURL:[NSURL URLWithString:joke.picture_url] placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    } else {
        self.jokePicture.image = nil ;
    }
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
