//
//  AddSubscribeCell.h
//  WangYiNews
//
//  Created by lifangli on 16/1/25.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSubscribeModel.h"

@interface AddSubscribeCell : UITableViewCell

@property (strong, nonatomic) AddSubscribeModel *am;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *catergory;
@property (weak, nonatomic) IBOutlet UILabel *subscribeCount;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIView *midLine;

- (IBAction)addSubscribe:(id)sender;

@end
