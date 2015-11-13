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
    [self.replyImg setImage:[UIImage imageNamed:@"cola_bubble_gray@2x.png"]];
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
        CGSize replySize = [self.replyLabel.text sizeWithAttributes:@{NSFontAttributeName:self.replyLabel.font}];
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(replySize.width+8);
        }];
        [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.replyLabel.mas_left).offset(4);
        }];
    }
    else{
        self.replyImg.hidden = YES;
        self.replyLabel.hidden = YES;
    }
    
    self.view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view1.layer.borderWidth = 0.5;
    self.view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view2.layer.borderWidth = 0.5;
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

@end
