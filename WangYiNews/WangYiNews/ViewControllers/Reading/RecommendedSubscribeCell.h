//
//  RecommendedSubscribeCell.h
//  WangYiNews
//
//  Created by lifangli on 16/1/22.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendedSubscribeModel.h"

@interface RecommendedSubscribeCell : UITableViewCell

@property (strong, nonatomic) RecommendedSubscribeModel *rm;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *catergory;
@property (weak, nonatomic) IBOutlet UILabel *subscribeCount;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIView *midLine;
@property (weak, nonatomic) IBOutlet UIView *bootomLine;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

- (IBAction)addSubscribe:(id)sender;

@end
