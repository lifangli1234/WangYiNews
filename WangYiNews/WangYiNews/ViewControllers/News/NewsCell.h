//
//  NewsCell.h
//  WangYiNews
//
//  Created by lifangli on 15/10/24.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

@property (strong, nonatomic) NewsModel *newsModel;

@property (weak, nonatomic) IBOutlet UIImageView *sortImg;
@property (weak, nonatomic) IBOutlet UILabel *sortLab;
@property (weak, nonatomic) IBOutlet UIImageView *replyImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc1;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc2;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

//+ (NSString *)idForRow:(NewsModel *)newsModel;
//
//+ (CGFloat)heightForRow:(NewsModel *)newsModel;

@end
