//
//  NewsCell.m
//  WangYiNews
//
//  Created by lifangli on 15/10/24.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setNewsModel:(NewsModel *)newsModel
{
    _newsModel = newsModel;
    UIImage *image = [UIImage imageNamed:@"cola_bubble_gray@2x"];
    //[image stretchableImageWithLeftCapWidth:20 topCapHeight:8];
    [self.replyImg setImage:[UIImage imageNamed:@"cola_bubble_gray@2x"]];
    self.replyLabel.textColor = [UIColor grayColor];
    self.titleLabel.text = self.newsModel.title;
    self.descLabel.text = self.newsModel.digest;
    
    [self.imgsrc sd_setImageWithURL:[NSURL URLWithString:self.newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@""]];
    if (self.newsModel.imgextra.count == 2) {
        [self.imgsrc1 sd_setImageWithURL:[NSURL URLWithString:self.newsModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@""]];
        [self.imgsrc2 sd_setImageWithURL:[NSURL URLWithString:self.newsModel.imgextra[1][@"imgsrc"]]  placeholderImage:[UIImage imageNamed:@""]];
    }
    
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count>0) {
        if (count > 10000) {
            displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
        }else{
            displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
        }
        self.replyImg.hidden = NO;
        self.replyLabel.hidden = NO;
        self.replyLabel.text = displayCount;
    }
    else{
        self.replyImg.hidden = YES;
        self.replyLabel.hidden = YES;
    }
    
    if (newsModel.editor != nil && newsModel.editor.count>0) {
        self.headImg.hidden = NO;
        self.nickName.hidden = NO;
        self.headImg.layer.cornerRadius = 15;
        self.headImg.layer.masksToBounds = YES;
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[[newsModel.editor objectAtIndex:0] objectForKey:@"editorImg"]] placeholderImage:nil];
        self.nickName.text = [[newsModel.editor objectAtIndex:0] objectForKey:@"editorName"];
    }
    else{
        self.headImg.hidden = YES;
        self.nickName.hidden = YES;
    }
    if ([newsModel.imgType integerValue]==1) {
        [self layoutBigImageSubviews];
    }
    else if (newsModel.imgextra){
        [self layoutImagesSubviews];
    }
    else{
        [self layoutNormalSubviews];
    }
}

-(void)layoutNormalSubviews
{
    [self.imgsrc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(100, 75));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgsrc).offset(5);
        make.left.equalTo(self.imgsrc.mas_right).offset(8);
        make.right.equalTo(self).offset(-10);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.imgsrc.mas_right).offset(8);
        make.right.equalTo(self).offset(-10);
    }];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgsrc).offset(-5);
        make.right.equalTo(self).offset(-15);
    }];
    [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.replyLabel);
        make.right.equalTo(self.replyLabel).offset(5);
        make.left.equalTo(self.replyLabel).offset(-5);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgsrc.mas_bottom).offset(10);
        make.right.left.equalTo(self);
        make.height.offset(0.5);
    }];
}

-(void)layoutBigImageSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    [self.imgsrc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.height.offset(150);
    }];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgsrc).offset(5);
        make.top.equalTo(self.imgsrc.mas_bottom).offset(-15);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(5);
        make.top.equalTo(self.imgsrc.mas_bottom);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.newsModel.editor != nil && self.newsModel.editor.count>0) {
            make.top.equalTo(self.headImg.mas_bottom).offset(5);
        }
        else
            make.top.equalTo(self.imgsrc.mas_bottom).offset(8);
        make.left.right.equalTo(self.imgsrc);
    }];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel).offset(17);
        make.right.equalTo(self).offset(-15);
    }];
    [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.replyLabel);
        make.right.equalTo(self.replyLabel).offset(5);
        make.left.equalTo(self.replyLabel).offset(-5);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.newsModel.replyCount intValue]>0) {
            make.top.equalTo(self.replyImg.mas_bottom).offset(5);
        }
        else
            make.top.equalTo(self.descLabel.mas_bottom).offset(10);
        make.right.left.equalTo(self);
        make.height.offset(0.5);
    }];
}

-(void)layoutImagesSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    [self.imgsrc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.size.sizeOffset(CGSizeMake(([Helper screenWidth]-30)/3, 100));
    }];
    [self.imgsrc1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgsrc.mas_right).offset(5);
        make.top.width.height.equalTo(self.imgsrc);
    }];
    [self.imgsrc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgsrc1.mas_right).offset(5);
        make.top.width.height.equalTo(self.imgsrc1);
    }];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-15);
    }];
    [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.replyLabel);
        make.right.equalTo(self.replyLabel).offset(5);
        make.left.equalTo(self.replyLabel).offset(-5);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgsrc.mas_bottom).offset(10);
        make.right.left.equalTo(self);
        make.height.offset(0.5);
    }];
}

@end
