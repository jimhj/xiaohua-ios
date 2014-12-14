//
//  XHCommentCell.m
//  XiaoHuaApp
//
//  Created by Jimmy Huang on 14/12/14.
//  Copyright (c) 2014年 Ebooom. All rights reserved.
//

#import "XHCommentCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation XHCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = PRIMARY_BG_COLOR;

        self.cellMainView = [[UIView alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];

        
        self.cellMainView.backgroundColor = [UIColor whiteColor];
        [self.cellMainView addSubview: self.contentLabel];
          
        [self addSubview:self.cellMainView];
    }
    return self;
}

- (void)setUpCell:(XHComment *)comment
{
    self.cellMainView.frame = CGRectMake(CELL_MARGIN, 10, CELL_WIDTH - (CELL_MARGIN * 2), 43);
    self.contentLabel.text = comment.body;
    self.contentLabel.frame = CGRectMake(30, 8, CELL_WIDTH - (CELL_MARGIN * 2), 30);
    self.contentLabel.textColor = [UIColor colorWithRed:0.27 green:0.26 blue:0.26 alpha:1];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:comment.user.avatarUrl] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
    imageView.frame = CGRectMake(15, 23, 20, 20);
    imageView.layer.cornerRadius = 10;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
}
@end
