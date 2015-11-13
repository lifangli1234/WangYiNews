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
    
    self.replyLabel.textColor = [UIColor grayColor];
    [self.replyImg setImage:[UIImage imageNamed:@"cola_bubble_gray@2x.png"]];
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
}

+ (NSString *)idForRow:(NewsModel *)newsModel
{
    if (newsModel.imgType){
        return @"BigPhotoCell";
    }else if (newsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"BasicCell";
    }
}

@end
