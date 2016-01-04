//
//  SegmentView.h
//  WangYiNews
//
//  Created by lifangli on 16/1/4.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentViewDelegate;

@interface SegmentView : UIView

-(instancetype)initSegmentView:(NSString *)firstName secondName:(NSString *)secondName;

@property(weak, nonatomic)id<SegmentViewDelegate>delegate;
@property(nonatomic, strong)UIView *btnBackView;
@property(nonatomic, strong)UIButton *firstButton;
@property(nonatomic, strong)UIButton *secondButton;

@end

@protocol SegmentViewDelegate <NSObject>

-(void)segmentViewFirstBtnClick:(SegmentView *)segmentView;
-(void)segmentViewSecondBtnClick:(SegmentView *)segmentView;

@end