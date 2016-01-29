//
//  SepecialCell.m
//  WangYiNews
//
//  Created by lifangli on 15/10/31.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "SepecialCell.h"

@implementation SepecialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContentModel:(SepecialContentModel *)contentModel
{
    _contentModel = contentModel;
    
    self.replyLabel.textColor = [UIColor grayColor];
    UIImage *normalImg = [UIImage imageNamed:@"cola_bubble_gray@2x"];
    CGFloat normalW = normalImg.size.width;
    CGFloat normalH = normalImg.size.height;
    normalImg = [normalImg resizableImageWithCapInsets:UIEdgeInsetsMake(normalH * 0.5, normalW * 0.5, normalH * 0.5, normalW * 0.5)];
    [self.replyImg setImage:normalImg];
    self.titleLabel.text = self.contentModel.title;
    self.descLabel.text = self.contentModel.digest;
    
    [self.imgsrc sd_setImageWithURL:[NSURL URLWithString:self.contentModel.imgsrc] placeholderImage:[UIImage imageNamed:@""]];
    if (self.contentModel.imgextra.count == 2) {
        [self.imgsrc3 sd_setImageWithURL:[NSURL URLWithString:self.contentModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@""]];
        [self.imgsrc4 sd_setImageWithURL:[NSURL URLWithString:self.contentModel.imgextra[1][@"imgsrc"]]  placeholderImage:[UIImage imageNamed:@""]];
    }
    
    CGFloat count =  [self.contentModel.replyCount intValue];
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
    
    self.view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view1.layer.borderWidth = 0.5;
    self.view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view2.layer.borderWidth = 0.5;
    
    [self layoutVideoSubviews];
    
    if ([contentModel.imgType integerValue]==1) {
        [self layoutBigImageSubviews];
    }
    else if (contentModel.imgextra.count>0){
        [self layoutImagesSubviews];
    }
    else{
        [self layoutNormalSubviews];
    }
}

-(void)layoutVideoSubviews
{
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.offset(([Helper screenWidth]-30)/2);
        make.height.offset(([Helper screenWidth]-30)/2+30);
    }];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(self.view1);
        make.height.equalTo(self.view1);
    }];
    [self.digst1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.mas_equalTo(self.view1);
        make.height.offset(30);
    }];
    [self.digst2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.mas_equalTo(self.view2);
        make.height.offset(30);
    }];
    [self.imgsrc1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view1);
        make.bottom.equalTo(self.view1).offset(-30);
    }];
    [self.imgsrc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view2);
        make.bottom.equalTo(self.view2).offset(-30);
    }];
    [self.imgplay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view1);
        make.centerY.equalTo(self.imgsrc1);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    [self.imgplay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view2);
        make.centerY.equalTo(self.imgsrc2);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.digst1.mas_bottom).offset(15);
        make.left.and.right.equalTo(self);
        make.height.offset(1);
    }];
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
    [self.tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgsrc).offset(-5);
        make.right.equalTo(self).offset(-10);
        make.size.sizeOffset(CGSizeMake(13, 13));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize tagLeblSize = [self.tagLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
        make.size.sizeOffset(CGSizeMake(tagLeblSize.width+3, tagLeblSize.height+2));
        make.bottom.equalTo(self.imgsrc).offset(-5);
        make.right.equalTo(self).offset(-10);
    }];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        if ([self.newsModel.skipType isEqualToString:@"photoset"] || [self.newsModel.TAG isEqualToString:@"视频"] || [self.newsModel.TAG isEqualToString:@"语音"]) {
//            make.right.equalTo(self.tagImg.mas_left).offset(-8);
//            make.centerY.equalTo(self.tagImg);
//        }
//        else if ([self.newsModel.TAG isEqualToString:@"正在直播"] || [self.newsModel.TAG isEqualToString:@"独家"] || [self.newsModel.skipType isEqualToString:@"special"]) {
//            make.right.equalTo(self.tagLabel.mas_left).offset(-8);
//            make.centerY.equalTo(self.tagLabel);
//        }
//        else {
            make.bottom.equalTo(self.imgsrc).offset(-5);
            make.right.equalTo(self).offset(-15);
//        }
    }];
    CGSize replyLeblSize = [self.replyLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.replyLabel);
        make.width.offset(replyLeblSize.width+12);
        make.height.offset(replyLeblSize.height);
    }];
    [self.bootomLine mas_makeConstraints:^(MASConstraintMaker *make) {
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
//    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imgsrc).offset(5);
//        make.top.equalTo(self.imgsrc.mas_bottom).offset(-15);
//        make.size.sizeOffset(CGSizeMake(30, 30));
//    }];
//    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.headImg.mas_right).offset(5);
//        make.top.equalTo(self.imgsrc.mas_bottom);
//    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (self.newsModel.editor != nil && self.newsModel.editor.count>0) {
//            make.top.equalTo(self.headImg.mas_bottom).offset(5);
//        }
//        else
            make.top.equalTo(self.imgsrc.mas_bottom).offset(8);
        make.left.right.equalTo(self.imgsrc);
    }];
    [self.tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel).offset(17);
        make.right.equalTo(self).offset(-10);
        make.size.sizeOffset(CGSizeMake(13, 13));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize tagLeblSize = [self.tagLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
        make.size.sizeOffset(CGSizeMake(tagLeblSize.width+3, tagLeblSize.height+2));
        make.top.equalTo(self.descLabel).offset(17);
        make.right.equalTo(self).offset(-10);
    }];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        if ([self.contentModel.skipType isEqualToString:@"photoset"] || [self.newsModel.TAG isEqualToString:@"视频"] || [self.newsModel.TAG isEqualToString:@"语音"]) {
//            make.right.equalTo(self.tagImg.mas_left).offset(-8);
//            make.centerY.equalTo(self.tagImg);
//        }
//        else if ([self.newsModel.TAG isEqualToString:@"正在直播"] || [self.newsModel.TAG isEqualToString:@"独家"] || [self.newsModel.skipType isEqualToString:@"special"]) {
//            make.right.equalTo(self.tagLabel.mas_left).offset(-8);
//            make.centerY.equalTo(self.tagLabel);
//        }
//        else{
            make.top.equalTo(self.descLabel).offset(17);
            make.right.equalTo(self).offset(-15);
//        }
    }];
    CGSize replyLeblSize = [self.replyLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.replyLabel);
        make.width.offset(replyLeblSize.width+12);
        make.height.offset(replyLeblSize.height);
    }];
    [self.bootomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.contentModel.replyCount intValue]>0) {
            make.top.equalTo(self.replyImg.mas_bottom).offset(5);
        }
        else {
//            if ([self.newsModel.skipType isEqualToString:@"photoset"] || [self.newsModel.TAG isEqualToString:@"视频"] || [self.newsModel.TAG isEqualToString:@"语音"]) {
//                make.top.equalTo(self.tagImg.mas_bottom).offset(5);
//            }
//            else if ([self.newsModel.TAG isEqualToString:@"正在直播"] || [self.newsModel.TAG isEqualToString:@"独家"] || [self.newsModel.skipType isEqualToString:@"special"]) {
//                make.top.equalTo(self.tagLabel.mas_bottom).offset(5);
//            }
//            else{
                make.top.equalTo(self.descLabel.mas_bottom).offset(10);
//            }
        }
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
    [self.imgsrc3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgsrc.mas_right).offset(5);
        make.top.width.height.equalTo(self.imgsrc);
    }];
    [self.imgsrc4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgsrc3.mas_right).offset(5);
        make.top.width.height.equalTo(self.imgsrc3);
    }];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-15);
    }];
    CGSize replyLeblSize = [self.replyLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.replyLabel);
        make.width.offset(replyLeblSize.width+12);
        make.height.offset(replyLeblSize.height);
    }];
    [self.bootomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgsrc.mas_bottom).offset(10);
        make.right.left.equalTo(self);
        make.height.offset(0.5);
    }];
}

//-(void)setTagImgView:(UIImageView *)img
//{
//    if ([self.newsModel.skipType isEqualToString:@"photoset"] || [self.newsModel.TAG isEqualToString:@"视频"] || [self.newsModel.TAG isEqualToString:@"语音"]) {
//        self.tagLabel.hidden = YES;
//        self.tagImg.hidden = NO;
//        if ([self.newsModel.skipType isEqualToString:@"photoset"]) {
//            SetImageViewImage(self.tagImg, @"cell_tag_photo@2x");
//        }
//        else if ([self.newsModel.TAG isEqualToString:@"语音"]) {
//            SetImageViewImage(self.tagImg, @"cell_tag_audio@2x");
//        }
//        else{
//            SetImageViewImage(self.tagImg, @"cell_tag_video@2x");
//        }
//    }
//    else if ([self.newsModel.TAG isEqualToString:@"正在直播"] || [self.newsModel.TAG isEqualToString:@"独家"] || [self.newsModel.skipType isEqualToString:@"special"]) {
//        self.tagLabel.hidden = NO;
//        self.tagImg.hidden = YES;
//        if ([self.newsModel.TAG isEqualToString:@"正在直播"]) {
//            self.tagLabel.text = @"正在直播";
//            self.tagLabel.textColor = [UIColor blueColor];
//            self.tagLabel.layer.borderColor = [UIColor blueColor].CGColor;
//        }
//        else if ([self.newsModel.TAG isEqualToString:@"独家"]){
//            self.tagLabel.text = @"独家";
//            self.tagLabel.textColor = [UIColor blueColor];
//            self.tagLabel.layer.borderColor = [UIColor blueColor].CGColor;
//        }
//        else{
//            self.tagLabel.text = @"专题";
//            self.tagLabel.textColor = BASERED;
//            self.tagLabel.layer.borderColor = BASERED.CGColor;
//        }
//    }
//    else{
//        self.tagLabel.hidden = YES;
//        self.tagImg.hidden = YES;
//    }
//}

@end
