//
//  SegmentView.m
//  WangYiNews
//
//  Created by lifangli on 16/1/4.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "SegmentView.h"

@implementation SegmentView

-(instancetype)initSegmentView:(NSString *)firstName secondName:(NSString *)secondName
{
    self = [super init];
    if (self) {
        [self addButton:(NSString *)firstName secondName:(NSString *)secondName];
    }
    return self;
}

-(void)addButton:(NSString *)firstName secondName:(NSString *)secondName
{
    self.btnBackView = [Helper view:[UIColor whiteColor] nightColor:[UIColor whiteColor]];
    self.btnBackView.layer.cornerRadius = 15;
    [self addSubview:self.btnBackView];
    [self.btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.equalTo(@30);
        make.width.offset(120);
        make.top.equalTo(self);
    }];
    
    self.firstButton = [Helper button:firstName textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:16] tag:0 target:self action:@selector(firstBtnClick)];
    self.firstButton.selected = YES;
    [self.firstButton dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateSelected];
    [self addSubview: self.firstButton];
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.btnBackView.mas_width);
    }];
    
    self.secondButton = [Helper button:secondName textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:16] tag:0 target:self action:@selector(secondBtnClick)];
    [self.secondButton dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateSelected];
    [self addSubview: self.secondButton];
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(self.btnBackView.mas_width);
    }];
}

-(void)firstBtnClick
{
    self.firstButton.selected = YES;
    self.secondButton.selected = NO;
    [self.btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
    }];
    [self.btnBackView layoutIfNeeded];
    if ([self.delegate respondsToSelector:@selector(segmentViewFirstBtnClick:)]) {
        [self.delegate segmentViewFirstBtnClick:self];
    }
}

-(void)secondBtnClick
{
    self.firstButton.selected = NO;
    self.secondButton.selected = YES;
    [self.btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(120);
    }];
    [self.btnBackView layoutIfNeeded];
    if ([self.delegate respondsToSelector:@selector(segmentViewSecondBtnClick:)]) {
        [self.delegate segmentViewSecondBtnClick:self];
    }
}

@end
