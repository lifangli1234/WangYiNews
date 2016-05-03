//
//  VideoCell.h
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@protocol VideoCellDelegate;

@interface VideoCell : UITableViewCell

@property (nonatomic, strong) VideoModel *model;
@property (weak, nonatomic) id<VideoCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *timeImg;
@property (weak, nonatomic) IBOutlet UIImageView *countImg;
@property (weak, nonatomic) IBOutlet UIImageView *penImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *describe;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UIImageView *comment;
@property (weak, nonatomic) IBOutlet UIImageView *pen;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
- (IBAction)shareBtn:(id)sender;
- (IBAction)videoPlay:(id)sender;

@end

@protocol VideoCellDelegate <NSObject>

-(void)videoCell:(VideoCell *)videoCell playButton:(UIButton *)btn;
-(void)videoCell:(VideoCell *)videoCell shareButton:(UIButton *)btn;

@end
