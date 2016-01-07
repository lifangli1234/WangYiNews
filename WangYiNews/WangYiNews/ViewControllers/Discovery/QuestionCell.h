//
//  QuestionCell.h
//  WangYiNews
//
//  Created by lifangli on 16/1/7.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModel.h"
#import "AnswerModel.h"

@interface QuestionCell : UITableViewCell

@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, strong) QuestionModel *questionModel;
@property (nonatomic, strong) AnswerModel *answerModel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadPic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIView *midLine;
@property (weak, nonatomic) IBOutlet UIView *specialistHeadView;
@property (weak, nonatomic) IBOutlet UIImageView *specialistHeadPic;
@property (weak, nonatomic) IBOutlet UILabel *specialistName;
@property (weak, nonatomic) IBOutlet UILabel *answer;
@property (weak, nonatomic) IBOutlet UILabel *answerTime;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UILabel *supportCount;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *supportBtn;
@property (weak, nonatomic) IBOutlet UIImageView *replyImg;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *supportImg;
- (IBAction)replyBtn:(id)sender;
- (IBAction)supportBtn:(id)sender;
- (IBAction)shareBtn:(id)sender;
@end
