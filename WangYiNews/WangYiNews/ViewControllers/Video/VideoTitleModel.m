//
//  VideoTitleModel.m
//  WangYiNews
//
//  Created by lifangli on 15/12/23.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "VideoTitleModel.h"

@implementation VideoTitleModel

+ (instancetype)videoTitleModelWithDict:(NSDictionary *)dict
{
    VideoTitleModel *videoTitle = [[self alloc] init];
    [VideoTitleModel setValuesForKeysWithDictionary:dict];
    return videoTitle;
}

@end
