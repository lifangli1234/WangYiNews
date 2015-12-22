//
//  VideoModel.m
//  News
//
//  Created by lifangli on 15/9/9.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+ (instancetype)videoModelWithDict:(NSDictionary *)dict
{
    VideoModel *videoModel = [[self alloc] init];
    [VideoModel setValuesForKeysWithDictionary:dict];
    return videoModel;
}

@end
