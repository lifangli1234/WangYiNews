//
//  TopicCell.h
//  WangYiNews
//
//  Created by lifangli on 15/12/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpertModel.h"

@protocol TopicCellDelegate;

@interface TopicCell : UITableViewCell
@property (weak, nonatomic) id<TopicCellDelegate> delegate;
@property (strong, nonatomic) ExpertModel *expertModel;
@property (weak, nonatomic) IBOutlet UIImageView *addImg;
- (IBAction)addOrRemoveToAttention:(id)sender;
@property (assign, nonatomic) CGFloat cellHeight;
@property (weak, nonatomic) IBOutlet UIImageView *bigImg;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userDesc;
@property (weak, nonatomic) IBOutlet UILabel *endAsk;
@property (weak, nonatomic) IBOutlet UILabel *attentionNum;
@property (weak, nonatomic) IBOutlet UIImageView *sepLine;
@property (weak, nonatomic) IBOutlet UILabel *catergory;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIView *bootomLine;
@end
@protocol TopicCellDelegate <NSObject>

-(void)topicCellAddOrRemoveToAttention:(TopicCell *)topicCell;

@end