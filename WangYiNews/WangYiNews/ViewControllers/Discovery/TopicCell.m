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
    [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
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
    [self.attentionBtn setTitleColor:[UIColor colorWithRed:0.86 green:0.34 blue:0.34 alpha:1.00] forState:UIControlStateNormal];
    self.attentionBtn.layer.borderColor = [UIColor colorWithRed:0.96 green:0.84 blue:0.84 alpha:1.00].CGColor;
    self.attentionBtn.layer.borderWidth = 0.5;
    self.attentionBtn.layer.cornerRadius = 25/2;
    self.attentionBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 11, 0, 0);
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
    CGSize descSize = [self.userDesc.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.userDesc.font} context:nil].size;
    [self.userDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.bigImg.mas_bottom).offset(8);
    }];
    self.cellHeight = self.cellHeight+8+descSize.height;
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.userDesc.mas_bottom).offset(8);
        make.size.sizeOffset(CGSizeMake(60, 25));
    }];
    [self.addImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.attentionBtn).offset(-16);
        make.centerY.equalTo(self.attentionBtn);
        make.size.sizeOffset(CGSizeMake(13, 13));
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
    self.cellHeight = self.cellHeight+46;
}

- (IBAction)addOrRemoveToAttention:(id)sender {
    if ([self.delegate respondsToSelector:@selector(topicCellAddOrRemoveToAttention:)]) {
        [self.delegate topicCellAddOrRemoveToAttention:self];
    }
}
@end
