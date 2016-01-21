//
//  ReadingCell.h
//  WangYiNews
//
//  Created by lifangli on 16/1/9.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingModel.h"

@interface ReadingCell : UITableViewCell

@property (nonatomic, strong) ReadingModel *rm;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *recReasonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recReasonImg;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end
