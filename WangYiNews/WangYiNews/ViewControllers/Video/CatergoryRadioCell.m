//
//  CatergoryRadioCell.m
//  WangYiNews
//
//  Created by lifangli on 15/12/25.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "CatergoryRadioCell.h"
#import "RadioModel.h"

@implementation CatergoryRadioCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAudioSubModle:(AudioSubModel *)audioSubModle
{
    if ([audioSubModle.playCount integerValue]<10000) {
        self.playCountLab.text = [NSString stringWithFormat:@"%ld",[audioSubModle.playCount integerValue]];
    }
    else{
        self.playCountLab.text = [NSString stringWithFormat:@"%.1f万",[audioSubModle.playCount integerValue]/10000.0];
    }
    self.titleLab.text = audioSubModle.tname;
    RadioModel *rm = [RadioModel objectWithKeyValues:audioSubModle.radio];
    self.descLab.text = rm.title;
    [self.imgsrc sd_setImageWithURL:[NSURL URLWithString:rm.imgsrc] placeholderImage:nil];
}

-(void)layoutSubviews
{
    self.imgsrc.layer.cornerRadius = 85/2;
    self.imgsrc.layer.masksToBounds = YES;
    SetImageViewImage(self.tagImg, @"audionews_index_tag@2x");
    SetImageViewImage(self.playImg, @"audionews_index_play@2x");
    self.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    self.titleLab.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.descLab.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.playCountLab.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.line.dk_backgroundColorPicker = DKColorWithColors(GRAYCOLOR, NIGHTGRAYCOLOR);
    [self.imgsrc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(85, 85));
    }];
    [self.playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgsrc);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgsrc.mas_right).offset(8);
        make.top.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-15);
        make.height.offset(25);
    }];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgsrc.mas_right).offset(8);
        make.top.equalTo(self.titleLab.mas_bottom).offset(0);
        make.right.equalTo(self).offset(-15);
        make.height.offset(50);
    }];
    [self.playCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-8);
        make.right.equalTo(self).offset(-15);
        make.height.offset(25);
    }];
    [self.tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playCountLab);
        make.right.equalTo(self.playCountLab.mas_left).offset(-8);
        make.size.sizeOffset(CGSizeMake(15, 13));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.offset(1);
    }];
}

@end
