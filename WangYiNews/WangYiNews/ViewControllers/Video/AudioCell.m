//
//  AudioCell.m
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "AudioCell.h"
#import "AudioSubModel.h"
#import "RadioModel.h"

@implementation AudioCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAudioModel:(AudioModel *)audioModel
{
    self.catergoryName.text = audioModel.cname;
    self.enterLabel.text = @"进入";
    NSDictionary *dic1 = [audioModel.tList objectAtIndex:0];
    NSDictionary *dic2 = [audioModel.tList objectAtIndex:1];
    NSDictionary *dic3 = [audioModel.tList objectAtIndex:2];
    AudioSubModel *am1 = [AudioSubModel objectWithKeyValues:dic1];
    AudioSubModel *am2 = [AudioSubModel objectWithKeyValues:dic2];
    AudioSubModel *am3 = [AudioSubModel objectWithKeyValues:dic3];
    if ([am1.playCount integerValue]<10000) {
        self.playCount1.text = [NSString stringWithFormat:@"%ld",[am1.playCount integerValue]];
    }
    else{
        self.playCount1.text = [NSString stringWithFormat:@"%.1f万",[am1.playCount integerValue]/10000.0];
    }
    if ([am2.playCount integerValue]<10000) {
        self.playCount2.text = [NSString stringWithFormat:@"%ld",[am2.playCount integerValue]];
    }
    else{
        self.playCount2.text = [NSString stringWithFormat:@"%.1f万",[am2.playCount integerValue]/10000.0];
    }
    if ([am3.playCount integerValue]<10000) {
        self.playCount3.text = [NSString stringWithFormat:@"%ld",[am3.playCount integerValue]];
    }
    else{
        self.playCount3.text = [NSString stringWithFormat:@"%.1f万",[am3.playCount integerValue]/10000.0];
    }
    RadioModel *rm1 = [RadioModel objectWithKeyValues:am1.radio];
    RadioModel *rm2 = [RadioModel objectWithKeyValues:am2.radio];
    RadioModel *rm3 = [RadioModel objectWithKeyValues:am3.radio];
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:rm1.imgsrc] placeholderImage:nil];
    [self.img2 sd_setImageWithURL:[NSURL URLWithString:rm2.imgsrc] placeholderImage:nil];
    [self.img3 sd_setImageWithURL:[NSURL URLWithString:rm3.imgsrc] placeholderImage:nil];
    self.title1.text = rm1.tname;
    self.title2.text = rm2.tname;
    self.title3.text = rm3.tname;
    self.desc1.text = rm1.title;
    self.desc2.text = rm2.title;
    self.desc3.text = rm3.title;
}

-(void)layoutSubviews
{
    self.img1.layer.cornerRadius = (([Helper screenWidth]-50)/3)/2;
    self.img2.layer.cornerRadius = (([Helper screenWidth]-50)/3)/2;
    self.img3.layer.cornerRadius = (([Helper screenWidth]-50)/3)/2;
    self.img1.layer.masksToBounds = YES;
    self.img2.layer.masksToBounds = YES;
    self.img3.layer.masksToBounds = YES;
    self.bottomLine.layer.borderColor = [Helper isNightMode]?NIGHTGRAYCOLOR.CGColor:GRAYCOLOR.CGColor;
    self.bottomLine.layer.borderWidth = 0.5;
    SetImageViewImage(self.enterImg, @"lm_cell_detail_indicator@2x");
    SetImageViewImage(self.playImg1, @"audionews_index_play@2x");
    SetImageViewImage(self.playImg2, @"audionews_index_play@2x");
    SetImageViewImage(self.playImg3, @"audionews_index_play@2x");
    SetImageViewImage(self.tag1, @"audionews_index_tag@2x");
    SetImageViewImage(self.tag2, @"audionews_index_tag@2x");
    SetImageViewImage(self.tag3, @"audionews_index_tag@2x");
    self.contentView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    self.catergoryLine.dk_backgroundColorPicker = DKColorWithColors(GRAYCOLOR, NIGHTGRAYCOLOR);
    self.bottomLine.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
    self.catergoryName.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.title1.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.title2.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.title3.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.desc1.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.desc2.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.desc3.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.playCount1.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.playCount2.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.playCount3.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.enterLabel.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    [self.catergoryImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(3);
        make.size.sizeOffset(CGSizeMake(24, 24));
    }];
    [self.catergoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.catergoryImg.mas_right).offset(8);
        make.top.equalTo(self);
        make.height.offset(30);
    }];
    [self.enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(8);
        make.size.sizeOffset(CGSizeMake(8, 14));
    }];
    [self.enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.enterImg.mas_left).offset(-8);
        make.top.equalTo(self);
        make.height.offset(30);
    }];
    [self.catergortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.offset(30);
    }];
    [self.catergoryLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.catergortBtn.mas_bottom);
        make.height.offset(1);
    }];
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.catergoryLine.mas_bottom).offset(10);
        make.size.sizeOffset(CGSizeMake(([Helper screenWidth]-50)/3, ([Helper screenWidth]-50)/3));
    }];
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img1.mas_right).offset(15);
        make.top.equalTo(self.catergoryLine.mas_bottom).offset(10);
        make.size.sizeOffset(CGSizeMake(([Helper screenWidth]-50)/3, ([Helper screenWidth]-50)/3));
    }];
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img2.mas_right).offset(15);
        make.top.equalTo(self.catergoryLine.mas_bottom).offset(10);
        make.size.sizeOffset(CGSizeMake(([Helper screenWidth]-50)/3, ([Helper screenWidth]-50)/3));
    }];
    [self.playImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.img1);
    }];
    [self.playImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.img2);
    }];
    [self.playImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.img3);
    }];
    [self.title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img1.mas_left);
        make.right.equalTo(self.img1.mas_right);
        make.top.equalTo(self.img1.mas_bottom).offset(5);
        make.height.offset(21);
    }];
    [self.title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img2.mas_left);
        make.right.equalTo(self.img2.mas_right);
        make.top.equalTo(self.img2.mas_bottom).offset(5);
        make.height.offset(21);
    }];
    [self.title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img3.mas_left);
        make.right.equalTo(self.img3.mas_right);
        make.top.equalTo(self.img3.mas_bottom).offset(5);
        make.height.offset(21);
    }];
    [self.desc1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img1.mas_left);
        make.right.equalTo(self.img1.mas_right);
        make.top.equalTo(self.title1.mas_bottom);
        make.height.offset(32);
    }];
    [self.desc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img2.mas_left);
        make.right.equalTo(self.img2.mas_right);
        make.top.equalTo(self.title2.mas_bottom);
        make.height.offset(32);
    }];
    [self.desc3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img3.mas_left);
        make.right.equalTo(self.img3.mas_right);
        make.top.equalTo(self.title3.mas_bottom);
        make.height.offset(32);
    }];
    [self.playCount1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.img1).offset(23/2);
        make.top.equalTo(self.desc1.mas_bottom);
        make.height.offset(21);
    }];
    [self.playCount2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.img2).offset(23/2);
        make.top.equalTo(self.desc2.mas_bottom);
        make.height.offset(21);
    }];
    [self.playCount3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.img3).offset(23/2);
        make.top.equalTo(self.desc3.mas_bottom);
        make.height.offset(21);
    }];
    [self.tag1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playCount1.mas_left).offset(-8);
        make.top.equalTo(self.desc1.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(15, 13));
    }];
    [self.tag2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playCount2.mas_left).offset(-8);
        make.top.equalTo(self.desc2.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(15, 13));
    }];
    [self.tag3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playCount3.mas_left).offset(-8);
        make.top.equalTo(self.desc3.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(15, 13));
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.playCount1.mas_bottom).offset(8);
        make.height.offset(5);
    }];
    [self.playBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.catergoryLine.mas_bottom);
        make.size.sizeOffset(CGSizeMake([Helper screenWidth]/3, 103 + ([Helper screenWidth]-50)/3));
    }];
    [self.playBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playBtn1.mas_right);
        make.top.equalTo(self.catergoryLine.mas_bottom);
        make.size.sizeOffset(CGSizeMake([Helper screenWidth]/3, 103 + ([Helper screenWidth]-50)/3));
    }];
    [self.playBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playBtn2.mas_right);
        make.top.equalTo(self.catergoryLine.mas_bottom);
        make.size.sizeOffset(CGSizeMake([Helper screenWidth]/3, 103 + ([Helper screenWidth]-50)/3));
    }];
}

@end
