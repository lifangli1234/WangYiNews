//
//  PhotoSetScrollView.h
//  WangYiNews
//
//  Created by lifangli on 15/12/18.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSetModel.h"

@interface PhotoSetScrollView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *photoSetScr;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)NSMutableArray *imageViewArr;
@property(nonatomic,strong)PhotoSetModel *photoSetModel;

@end
