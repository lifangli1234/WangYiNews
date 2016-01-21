//
//  ReadingCell.m
//  WangYiNews
//
//  Created by lifangli on 16/1/9.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "ReadingCell.h"

@implementation ReadingCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRm:(ReadingModel *)rm
{
    _rm = rm;
    
    self.titleLabel.text = rm.title;
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:rm.imgsrc] placeholderImage:nil];
    self.sourceLabel.text = rm.source;
    SetButtonImage(self.clearBtn, @"recommendlist_cell_close@2x");
    
    if (rm.recReason) {
        self.recReasonImg.hidden = NO;
        self.recReasonLabel.hidden = NO;
        self.recReasonLabel.text = self.rm.recReason;
        [self setRecReasonImg:self.recReasonImg];
    }
    else{
        self.recReasonImg.hidden = YES;
        self.recReasonLabel.hidden = YES;
    }
    if (rm.imgsrc == nil || [rm.imgsrc isEqualToString:@""]) {
        self.img1.hidden = YES;
        self.img2.hidden = YES;
        self.img3.hidden = YES;
    }
    else{
        self.img1.hidden = NO;
        if (rm.imgnewextra.count>0) {
            self.img2.hidden = NO;
            self.img3.hidden = NO;
            [self.img2 sd_setImageWithURL:[NSURL URLWithString:[[rm.imgnewextra objectAtIndex:0] objectForKey:@"imgsrc"]] placeholderImage:nil];
            [self.img3 sd_setImageWithURL:[NSURL URLWithString:[[rm.imgnewextra objectAtIndex:1] objectForKey:@"imgsrc"]] placeholderImage:nil];
        }
    }
    if (self.rm.imgsrc == nil || [self.rm.imgsrc isEqualToString:@""]){
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            if (self.rm.recReason) {
                make.top.equalTo(self.recReasonLabel.mas_bottom).offset(8);
            }
            else{
                make.top.equalTo(self).offset(10);
            }
        }];
        [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
            make.height.offset(20);
        }];
        [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self.sourceLabel);
            make.size.sizeOffset(CGSizeMake(20, 12));
        }];
    }
    else{
        if ([rm.template isEqualToString:@"normal"]) {
            [self layoutNormalSubviews];
        }
        else if ([rm.template isEqualToString:@"pic32"] || [rm.template isEqualToString:@"pic31"]){
            [self layoutImgsSubviews];
        }
        else {
            [self layoutBigImgSubviews];
        }
    }
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self);
        make.height.equalTo(@5);
    }];
}

-(void)setRecReasonImg:(UIImageView *)recReasonImg
{
    if (self.rm.recReason) {
        if ([self.rm.recReason isEqualToString:@"北京本地"]) {
            SetImageViewImage(recReasonImg, @"recommend_reason_2@2x");
            [self.recReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(28);
                make.top.equalTo(self).offset(8);
                make.top.equalTo(@20);
            }];
            [self.recReasonImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.sizeOffset(CGSizeMake(10, 12));
                make.centerY.equalTo(self.recReasonLabel);
            }];
        }
        else if ([self.rm.recReason isEqualToString:@"猜你喜欢"]) {
            SetImageViewImage(recReasonImg, @"recommend_reason_1@2x");
            [self.recReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(28);
                make.top.equalTo(self).offset(8);
                make.top.equalTo(@20);
            }];
            [self.recReasonImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.sizeOffset(CGSizeMake(10, 10));
                make.centerY.equalTo(self.recReasonLabel);
            }];
        }
        else if ([self.rm.recReason isEqualToString:@"网友热议"] || [self.rm.recReason isEqualToString:@"大家都在看"]) {
            SetImageViewImage(recReasonImg, @"recommend_reason_0@2x");
            [self.recReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(27.5);
                make.top.equalTo(self).offset(8);
                make.top.equalTo(@20);
            }];
            [self.recReasonImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.sizeOffset(CGSizeMake(9.5, 12.5));
                make.centerY.equalTo(self.recReasonLabel);
            }];
        }
        else {
            SetImageViewImage(recReasonImg, @"recommend_reason_7@2x");
            [self.recReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(25);
                make.top.equalTo(self).offset(8);
                make.top.equalTo(@20);
            }];
            [self.recReasonImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.sizeOffset(CGSizeMake(7, 10));
                make.centerY.equalTo(self.recReasonLabel);
            }];
        }
    }
}

-(void)layoutNormalSubviews
{
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.size.sizeOffset(CGSizeMake(150, 105));
        if (self.rm.recReason) {
            make.top.equalTo(self.recReasonLabel.mas_bottom).offset(8);
        }
        else{
            make.top.equalTo(self).offset(10);
        }
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img1.mas_right).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.img1);
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img1.mas_right).offset(10);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.img1);
    }];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.sourceLabel);
        make.size.sizeOffset(CGSizeMake(20, 12));
    }];
}

-(void)layoutBigImgSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        if (self.rm.recReason) {
            make.top.equalTo(self.recReasonLabel.mas_bottom).offset(8);
        }
        else{
            make.top.equalTo(self).offset(10);
        }
    }];
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.height.offset(175);
    }];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@20);
        make.top.equalTo(self.img1.mas_bottom).offset(8);
    }];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.sourceLabel);
        make.size.sizeOffset(CGSizeMake(20, 12));
    }];
}

-(void)layoutImgsSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        if (self.rm.recReason) {
            make.top.equalTo(self.recReasonLabel.mas_bottom).offset(8);
        }
        else{
            make.top.equalTo(self).offset(10);
        }
    }];
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.rm.template isEqualToString:@"pic32"]) {
            make.left.equalTo(self).offset(10);
        }
        else{
            make.right.equalTo(self).offset(-10);
        }
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.size.sizeOffset(CGSizeMake(160, 90));
    }];
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.rm.template isEqualToString:@"pic32"]) {
            make.left.equalTo(self).offset(10);
        }
        else{
            make.right.equalTo(self).offset(-10);
        }
        make.top.equalTo(self.img2.mas_bottom).offset(4);
        make.size.sizeOffset(CGSizeMake(160, 90));
    }];
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.rm.template isEqualToString:@"pic32"]) {
            make.right.equalTo(self).offset(-10);
            make.left.equalTo(self.img2.mas_right).offset(4);
        }
        else{
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self.img2.mas_left).offset(-4);
        }
        make.top.equalTo(self.img2);
        make.bottom.equalTo(self.img3);
    }];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@20);
        make.top.equalTo(self.img1.mas_bottom).offset(8);
    }];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.sourceLabel);
        make.size.sizeOffset(CGSizeMake(20, 12));
    }];
}

-(void)setColor
{
    self.img1.layer.masksToBounds = YES;
    self.img2.layer.masksToBounds = YES;
    self.img3.layer.masksToBounds = YES;
    self.recReasonLabel.dk_textColorPicker = DKColorWithColors(BASERED, BASERED_NIGHT);
    self.titleLabel.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.sourceLabel.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.bottomLine.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
}

@end
