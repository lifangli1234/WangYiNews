//
//  VideoTitleModel.h
//  WangYiNews
//
//  Created by lifangli on 15/12/23.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoTitleModel : NSObject

@property(nonatomic,strong)NSString *imgsrc;
@property(nonatomic,strong)NSString *sid;
@property(nonatomic,strong)NSString *title;

+ (instancetype)videoTitleModelWithDict:(NSDictionary *)dict;

@end
