//
//  PhotosetViewController.h
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSetModel.h"

@interface PhotosetViewController : UIViewController

@property (nonatomic, strong) PhotoSetModel *photoSetModel;
@property (nonatomic, strong) NSString *replyCount;

@end
