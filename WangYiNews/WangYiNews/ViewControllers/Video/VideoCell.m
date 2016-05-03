//
//  VideoCell.m
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(VideoModel *)model
{
    self.title.text = model.title;
    self.describe.text = model.desc;
    [self.cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"video_cell_content_bg@2x.png"]];
    NSInteger min = [model.length integerValue]/60;
    NSInteger sec = [model.length integerValue]%60;
    self.time.text = [NSString stringWithFormat:@"%.2ld:%.2ld",min,sec];
    if ([model.playCount integerValue]<10000) {
        self.playCount.text = [NSString stringWithFormat:@"%ld",[model.playCount integerValue]];
    }
    else{
        self.playCount.text = [NSString stringWithFormat:@"%.1f万",[model.playCount integerValue]/10000.0];
    }
    self.comment.layer.cornerRadius = 33/2;
    self.comment.layer.borderColor = [LINECOLOR CGColor];
    self.comment.layer.borderWidth = 0.5;
    if (model.replyCount>0) {
        self.replyCount.hidden = NO;
        if ([model.replyCount integerValue]<10000) {
            self.replyCount.text = [NSString stringWithFormat:@"%ld",[model.replyCount integerValue]];
        }
        else{
            self.replyCount.text = [NSString stringWithFormat:@"%.1f万",[model.replyCount integerValue]/10000.0];
        }
    }
    else{
        self.replyCount.text = nil;
    }
    
}

-(void)layoutSubviews
{
    self.contentView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    self.line.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
    self.time.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.replyCount.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.playCount.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.describe.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.title.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    SetImageViewImage(self.timeImg, @"video_list_cell_time@2x");
    SetImageViewImage(self.countImg, @"video_list_cell_count@2x");
    SetButtonImage(self.shareBtn, @"video_category_share@2x");
    SetButtonImage(self.playBtn, @"video_list_cell_big_icon@2x");
    SetImageViewImage(self.penImg, @"video_comment_pen@2x");
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.offset(25);
        make.top.equalTo(self).offset(12);
    }];
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.offset(25);
        make.top.equalTo(self.title.mas_bottom);
    }];
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.offset(200);
        make.top.equalTo(self.describe.mas_bottom).offset(3);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.cover);
        make.size.sizeOffset(CGSizeMake(50, 50));
    }];
    [self.timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(16, 16));
        make.centerY.equalTo(self.time);
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeImg.mas_right).offset(6);
        make.top.equalTo(self.cover.mas_bottom).offset(15);
        make.height.offset(21);
    }];
    [self.countImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.time.mas_right).offset(14);
        make.top.equalTo(self.timeImg);
        make.size.sizeOffset(CGSizeMake(16, 16));
    }];
    [self.playCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countImg.mas_right).offset(6);
        make.top.equalTo(self.time);
        make.height.offset(21);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.cover.mas_bottom).offset(8);
        make.size.sizeOffset(CGSizeMake(33, 33));
    }];
    [self.replyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pen.mas_left).offset(-8);
        make.height.offset(33);
        make.top.equalTo(self.comment);
    }];
    if (self.replyCount.text == nil) {
        [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareBtn.mas_left).offset(-10);
            make.height.offset(33);
            make.top.equalTo(self.cover.mas_bottom).offset(8);
            make.left.equalTo(self.penImg.mas_left).offset(-8);
        }];
    }
    else{
        [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareBtn.mas_left).offset(-10);
            make.height.offset(33);
            make.top.equalTo(self.cover.mas_bottom).offset(8);
            make.left.equalTo(self.replyCount.mas_left).offset(-8);
        }];
    }
    [self.pen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.comment).offset(-8);
        make.size.sizeOffset(CGSizeMake(15, 12));
        make.top.equalTo(self.comment).offset(10);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self);
        make.height.offset(5);
    }];
}

- (IBAction)shareBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(videoCell:shareButton:)]) {
        [self.delegate videoCell:self shareButton:self.shareBtn];
    }
}

- (IBAction)videoPlay:(id)sender {
    if ([self.delegate respondsToSelector:@selector(videoCell:playButton:)]) {
        [self.delegate videoCell:self playButton:self.playBtn];
    }
}
@end
