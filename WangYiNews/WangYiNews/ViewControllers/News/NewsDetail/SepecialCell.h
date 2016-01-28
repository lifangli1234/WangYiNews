//
//  SepecialCell.h
//  WangYiNews
//
//  Created by lifangli on 15/10/31.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SepecialContentModel.h"

@interface SepecialCell : UITableViewCell

@property (strong, nonatomic) SepecialContentModel *contentModel;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc1;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc2;
@property (weak, nonatomic) IBOutlet UIImageView *imgplay1;
@property (weak, nonatomic) IBOutlet UIImageView *imgplay2;
@property (weak, nonatomic) IBOutlet UILabel *digst1;
@property (weak, nonatomic) IBOutlet UILabel *digst2;
@property (weak, nonatomic) IBOutlet UIView *bootomLine1;

@property (weak, nonatomic) IBOutlet UIImageView *replyImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc3;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc4;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *tagImg;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *tagLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *bootomLine;

@end
