//
//  TopicCell.m
//  WangYiNews
//
//  Created by lifangli on 15/12/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setExpertModel:(ExpertModel *)expertModel
{
    [self.bigImg sd_setImageWithURL:[NSURL URLWithString:expertModel.picurl] placeholderImage:nil];
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:expertModel.headpicurl] placeholderImage:nil];
    self.userName.text = expertModel.name;
    self.userDesc.text = expertModel.alias;
    self.endAsk.text = @"结束提问";
    self.attentionNum.text = [NSString stringWithFormat:@"%@ 关注",expertModel.concernCount];
    self.catergory.text = expertModel.classification;
    self.sepLine.dk_imagePicker = DKImageWithNames(@"qa_cell_tail@2x", @"night_qa_cell_tail@2x");
    
    [self subViewLayout:expertModel.state];
}

-(void)subViewLayout:(NSNumber *)state
{
    self.headerImg.layer.cornerRadius = 20;
    self.headerImg.layer.masksToBounds = YES;
    self.bigImg.layer.masksToBounds = YES;
    self.headerImg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headerImg.layer.borderWidth = 1;
    self.endAsk.layer.cornerRadius = 3;
    self.endAsk.layer.borderColor = [UIColor grayColor].CGColor;
    self.endAsk.layer.borderWidth = 0.5;
    self.userDesc.numberOfLines = 0;
    self.userDesc.lineBreakMode = NSLineBreakByWordWrapping;
    self.bootomLine.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
    self.userDesc.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.endAsk.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.attentionNum.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.catergory.dk_textColorPicker = DKColorWithColors([UIColor colorWithRed:0.0 green:105.0/255.0 blue:210.0/255.0 alpha:1.0], [UIColor colorWithRed:0.0 green:195.0/255.0 blue:255.0/255.0 alpha:1.0]);
    self.cellHeight = 0;
    
    [self.bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.offset(175);
    }];
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigImg).offset(15);
        make.bottom.equalTo(self.bigImg).offset(-15);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImg.mas_right).offset(8);
        make.centerY.equalTo(self.headerImg);
    }];
    self.cellHeight = self.cellHeight+175;
    //[titleContent boundingRectWithSize:CGSizeMake(kScreen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CGSize descSize = [self.userDesc.text sizeWithFont:[UIFont systemFontOfSize:17]
                                     constrainedToSize:CGSizeMake([Helper screenWidth]-30, 50000)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    [self.userDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.bigImg.mas_bottom).offset(8);
        make.height.offset(80);
    }];
    self.cellHeight = self.cellHeight+8+80;
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.userDesc.mas_bottom).offset(8);
        make.size.sizeOffset(CGSizeMake(60, 30));
    }];
    if ([state intValue] == 1) {
        self.endAsk.hidden = YES;
        [self.attentionNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self.attentionBtn);
            make.height.offset(21);
        }];
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.attentionNum.mas_right).offset(8);
            make.centerY.equalTo(self.attentionNum);
            make.size.sizeOffset(CGSizeMake(1, 10));
        }];
        [self.catergory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sepLine.mas_right).offset(8);
            make.top.equalTo(self.attentionNum.mas_top);
            make.height.equalTo(self.attentionNum.mas_height);
        }];
    }
    else{
        self.endAsk.hidden = NO;
        [self.endAsk mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self.attentionBtn);
            make.height.offset(21);
            make.width.offset(58);
        }];
        [self.attentionNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.endAsk.mas_right).offset(8);
            make.centerY.equalTo(self.attentionBtn);
            make.height.offset(21);
        }];
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.attentionNum.mas_right).offset(8);
            make.centerY.equalTo(self.attentionNum);
            make.size.sizeOffset(CGSizeMake(1, 10));
        }];
        [self.catergory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sepLine.mas_right).offset(8);
            make.top.equalTo(self.attentionNum.mas_top);
            make.height.equalTo(self.attentionNum.mas_height);
        }];
    }
    [self.bootomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.attentionBtn.mas_bottom).offset(8);
        make.left.right.equalTo(self);
        make.height.offset(5);
    }];
    self.cellHeight = self.cellHeight+51;
}

@end
