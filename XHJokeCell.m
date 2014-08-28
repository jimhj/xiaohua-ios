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

#define CELL_WIDTH 320.0f
#define CELL_MARGIN 10.0f
#define FONT_SIZE 18.0f
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
        self.jokePicture.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)setUpCell:(XHJoke *)joke
{
    [self.contentLabel setText:joke.contentText];
    CGSize size = [joke calcCellSize];
    [self.contentLabel setFrame:CGRectMake(CELL_MARGIN, CELL_MARGIN, CELL_WIDTH - (CELL_MARGIN * 2), MAX(size.height, DEFAULT_HEIGHT))];
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
