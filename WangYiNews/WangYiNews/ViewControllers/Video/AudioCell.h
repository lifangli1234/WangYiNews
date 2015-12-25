//
//  AudioCell.h
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioModel.h"

@protocol AudioCellDelegate;

@interface AudioCell : UITableViewCell

@property (weak, nonatomic) id<AudioCellDelegate> delegate;
@property (strong, nonatomic) AudioModel *audioModel;
@property (weak, nonatomic) IBOutlet UIImageView *catergoryImg;
@property (weak, nonatomic) IBOutlet UILabel *catergoryName;
@property (weak, nonatomic) IBOutlet UIImageView *enterImg;
@property (weak, nonatomic) IBOutlet UILabel *enterLabel;
@property (weak, nonatomic) IBOutlet UIView *catergoryLine;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *playImg1;
@property (weak, nonatomic) IBOutlet UIImageView *playImg2;
@property (weak, nonatomic) IBOutlet UIImageView *playImg3;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *desc1;
@property (weak, nonatomic) IBOutlet UILabel *desc2;
@property (weak, nonatomic) IBOutlet UILabel *desc3;
@property (weak, nonatomic) IBOutlet UIImageView *tag1;
@property (weak, nonatomic) IBOutlet UIImageView *tag2;
@property (weak, nonatomic) IBOutlet UIImageView *tag3;
@property (weak, nonatomic) IBOutlet UILabel *playCount1;
@property (weak, nonatomic) IBOutlet UILabel *playCount2;
@property (weak, nonatomic) IBOutlet UILabel *playCount3;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIButton *playBtn1;
@property (weak, nonatomic) IBOutlet UIButton *playBtn2;
@property (weak, nonatomic) IBOutlet UIButton *playBtn3;
@property (weak, nonatomic) IBOutlet UIButton *catergortBtn;
- (IBAction)catergoryBtn:(id)sender;
- (IBAction)playBtn1:(id)sender;
- (IBAction)playBtn2:(id)sender;
- (IBAction)playBtn3:(id)sender;

@end

@protocol AudioCellDelegate <NSObject>

-(void)audioCellCatergoryBtnClick:(NSInteger)tag;
-(void)audioCellPlayBtn1Click:(NSInteger)tag;
-(void)audioCellPlayBtn2Click:(NSInteger)tag;
-(void)audioCellPlayBtn3Click:(NSInteger)tag;

@end
