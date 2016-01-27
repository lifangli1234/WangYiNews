//
//  AddSubscribeCell.m
//  WangYiNews
//
//  Created by lifangli on 16/1/25.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "AddSubscribeCell.h"

@implementation AddSubscribeCell

- (void)awakeFromNib {
    // Initialization code
    
    [self layoutSubview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAm:(AddSubscribeModel *)am
{
    _am = am;
    self.catergory.text = am.tname;
    self.subscribeCount.text = [NSString stringWithFormat:@"%@订阅",am.subnum];
}

-(void)layoutSubview
{
    self.iconImg.layer.cornerRadius = 5;
    self.iconImg.layer.masksToBounds = YES;
    self.midLine.dk_backgroundColorPicker = DKColorWithColors(GRAYCOLOR, NIGHTGRAYCOLOR);
    self.subscribeCount.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.catergory.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
}

- (IBAction)addSubscribe:(id)sender {
}

@end
