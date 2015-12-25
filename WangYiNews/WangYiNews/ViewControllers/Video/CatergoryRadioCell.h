//
//  CatergoryRadioCell.h
//  WangYiNews
//
//  Created by lifangli on 15/12/25.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioSubModel.h"

@interface CatergoryRadioCell : UITableViewCell

@property (nonatomic, strong) AudioSubModel *audioSubModle;
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc;
@property (weak, nonatomic) IBOutlet UIImageView *tagImg;
@property (weak, nonatomic) IBOutlet UIImageView *playImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@end
