//
//  QuestionCell.m
//  WangYiNews
//
//  Created by lifangli on 16/1/7.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell

- (void)awakeFromNib {
    // Initialization code
    
    [self dayNightMode];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setQuestionModel:(QuestionModel *)questionModel
{
    [self.userHeadPic sd_setImageWithURL:[NSURL URLWithString:questionModel.userHeadPicUrl] placeholderImage:[UIImage imageNamed:[Helper isNightMode]?@"night_covernewscell_editor_default@2x":@"covernewscell_editor_default@2x"]];
    self.userName.text = questionModel.userName;
    self.question.text = questionModel.content;
}

-(void)setAnswerModel:(AnswerModel *)answerModel
{
    _answerModel = answerModel;
    [self.specialistHeadPic sd_setImageWithURL:[NSURL URLWithString:answerModel.specialistHeadPicUrl] placeholderImage:[UIImage imageNamed:[Helper isNightMode]?@"night_covernewscell_editor_default@2x":@"covernewscell_editor_default@2x"]];
    self.specialistName.text = answerModel.specialistName;
    self.answer.text = answerModel.content;
    self.answerTime.text = [self setTime:answerModel.cTime];
    self.replyCount.text = ([self.answerModel.replyCount integerValue] > 0)?[NSString stringWithFormat:@"%@",answerModel.replyCount]:@"";
    self.supportCount.text = ([self.answerModel.supportCount integerValue] > 0)?[NSString stringWithFormat:@"%@",answerModel.supportCount]:@"";
    [self.replyBtn setImage:[UIImage imageNamed:[Helper isNightMode]?@"":@""] forState:UIControlStateNormal];
    [self.supportBtn setImage:[UIImage imageNamed:[Helper isNightMode]?@"":@""] forState:UIControlStateNormal];
    [self.shareBtn setImage:[UIImage imageNamed:[Helper isNightMode]?@"":@""] forState:UIControlStateNormal];
}

-(NSString *)setTime:(NSNumber *)date
{
    NSString *str=[NSString stringWithFormat:@"%@",date];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* current_date = [[NSDate alloc] init];
    NSTimeInterval time=[current_date timeIntervalSinceDate:detaildate];//间隔的秒数
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    
    NSString *dateContent;
    if(days>0){
        if (days == 1) {
            dateContent = @"昨天";
        }
        else {
            dateContent = [dateFormatter stringFromDate: detaildate];
        }
    }
    else if(hours>0){
        dateContent = [NSString stringWithFormat:@"%d%@",hours,@"小时前"];
    }
    else if (minute > 0){
        dateContent = [NSString stringWithFormat:@"%d%@",minute,@"分钟前"];
    }
    else{
        dateContent = @"刚刚";
    }
    return dateContent;
}

- (IBAction)replyBtn:(id)sender {
}

- (IBAction)supportBtn:(id)sender {
}

- (IBAction)shareBtn:(id)sender {
}

-(void)dayNightMode
{
    self.dk_backgroundColorPicker = DKColorWithColors(DAYBACKGROUNDCOLOR, NIGHTBACKGROUNDCOLOR);
    self.midLine.dk_backgroundColorPicker = DKColorWithColors(GRAYCOLOR, NIGHTGRAYCOLOR);
    self.bottomLine.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
    self.userName.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.question.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.replyCount.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.supportCount.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.specialistName.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.answerTime.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    self.answer.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.replyImg.dk_imagePicker = DKImageWithNames(@"video_comment_pen@2x", @"night_video_comment_pen@2x");
    self.supportImg.dk_imagePicker = DKImageWithNames(@"comment_support@2x", @"night_comment_support@2x");
    self.userHeadPic.layer.cornerRadius = 15;
    self.userHeadPic.layer.masksToBounds = YES;
    self.specialistHeadPic.layer.cornerRadius = 15;
    self.specialistHeadPic.layer.masksToBounds = YES;
    self.specialistHeadView.layer.cornerRadius = 16;
    self.specialistHeadView.layer.masksToBounds = YES;
    self.specialistHeadView.layer.borderWidth = 1;
    self.specialistHeadView.layer.borderColor = [UIColor colorWithRed:140.0/255.0 green:196.0/255.0 blue:251.0/255.0 alpha:1.0].CGColor;
    self.replyBtn.layer.borderWidth = 0.5;
    self.replyBtn.layer.cornerRadius = 15;
    self.supportBtn.layer.cornerRadius = 15;
    self.supportBtn.layer.borderWidth = 0.5;
    self.supportBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 30, 7, 12);
    self.replyBtn.contentEdgeInsets = UIEdgeInsetsMake(9, 30, 9, 12);
}

-(void)layoutSubviews
{
    self.replyBtn.layer.borderColor = [Helper isNightMode]?NIGHTLINECOLOR.CGColor:LINECOLOR.CGColor;
    self.supportBtn.layer.borderColor = [Helper isNightMode]?NIGHTLINECOLOR.CGColor:LINECOLOR.CGColor;
    SetButtonImage(self.shareBtn, @"icon_share@2x");
    
    self.cellHeight = 0;
    
    [self.userHeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(15);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userHeadPic.mas_right).offset(8);
        make.centerY.equalTo(self.userHeadPic);
        make.height.offset(30);
    }];
    CGSize questionSize = [self.question.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-58, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.question.font} context:nil].size;
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_left);
        make.top.equalTo(self.userName.mas_bottom);
        make.right.equalTo(self).offset(-10);
    }];
    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_left);
        make.top.equalTo(self.question.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@0.5);
    }];
    self.cellHeight = self.cellHeight+30.5+questionSize.height;
    [self.specialistHeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.userHeadPic);
        make.top.equalTo(self.midLine.mas_bottom).offset(10);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    [self.specialistHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.specialistHeadPic);
        make.size.sizeOffset(CGSizeMake(34, 34));
    }];
    [self.specialistName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midLine.mas_left);
        make.centerY.equalTo(self.specialistHeadPic);
        make.height.offset(30);
    }];
    CGSize answerSize = [self.answer.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-58, 51) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.answer.font} context:nil].size;
    [self.answer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.specialistName.mas_left);
        make.top.equalTo(self.specialistName.mas_bottom);
        make.right.equalTo(self).offset(-10);
        if (answerSize.height>51) {
            make.height.offset(51);
        }
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.answer.mas_bottom).offset(10);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    [self.supportImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-20);
        make.centerY.equalTo(self.shareBtn);
        make.size.sizeOffset(CGSizeMake(15, 12));
    }];
    [self.supportCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.supportImg.mas_left).offset(-8);
        make.centerY.equalTo(self.supportImg);
        make.height.offset(30);
    }];
    [self.supportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-8);
        make.centerY.equalTo(self.shareBtn);
        make.height.offset(30);
        if ([self.answerModel.supportCount integerValue]==0) {
            make.left.equalTo(self.supportImg.mas_left).offset(-12);
        }
        else{
            make.left.equalTo(self.supportCount.mas_left).offset(-12);
        }
    }];
    [self.replyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.supportBtn.mas_left).offset(-20);
        make.centerY.equalTo(self.supportBtn);
        make.size.sizeOffset(CGSizeMake(19, 16));
    }];
    [self.replyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.replyImg.mas_left).offset(-8);
        make.centerY.equalTo(self.replyImg);
        make.height.offset(30);
    }];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.supportBtn.mas_left).offset(-8);
        make.centerY.equalTo(self.supportBtn);
        make.height.offset(30);
        if ([self.answerModel.replyCount integerValue]==0) {
            make.left.equalTo(self.replyImg.mas_left).offset(-12);
        }
        else{
            make.left.equalTo(self.replyCount.mas_left).offset(-12);
        }
    }];
    [self.answerTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.answer.mas_left);
        make.centerY.equalTo(self.replyBtn);
        make.height.offset(30);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.replyBtn.mas_bottom).offset(10);
        make.height.offset(5);
    }];
    self.cellHeight = self.cellHeight+105.5+questionSize.height+answerSize.height;
}

@end
