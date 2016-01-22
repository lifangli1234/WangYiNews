//
//  RecommendedSubscribeCell.m
//  WangYiNews
//
//  Created by lifangli on 16/1/22.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "RecommendedSubscribeCell.h"

@implementation RecommendedSubscribeCell

- (void)awakeFromNib {
    // Initialization code
    
    [self layoutSubview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRm:(RecommendedSubscribeModel *)rm
{
    _rm = rm;
    
    //self.iconImg sd_setImageWithURL:[NSURL URLWithString:<#(nonnull NSString *)#>] placeholderImage:<#(UIImage *)#>
    self.catergory.text = rm.tname;
    self.subscribeCount.text = [NSString stringWithFormat:@"%@订阅",rm.subnum];
    self.title.text = rm.title;
    self.content.text = rm.digest;
}

-(void)layoutSubview
{
    self.iconImg.layer.cornerRadius = 5;
    self.iconImg.layer.masksToBounds = YES;
    self.midLine.dk_backgroundColorPicker = DKColorWithColors(GRAYCOLOR, NIGHTGRAYCOLOR);
    self.subscribeCount.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.content.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.catergory.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.title.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    
    UIView *line1 = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    line1.frame = CGRectMake(0, 0, [Helper screenWidth], 0.5);
    [self.bootomLine addSubview:line1];
    
    UIView *line2 = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    line2.frame = CGRectMake(0, 4.5, [Helper screenWidth], 0.5);
    [self.bootomLine addSubview:line2];
}

- (IBAction)addSubscribe:(id)sender {
}
@end
