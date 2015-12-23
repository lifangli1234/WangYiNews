//
//  VideoContentModel.m
//  WangYiNews
//
//  Created by lifangli on 15/12/23.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "VideoContentModel.h"

@implementation VideoContentModel

+ (instancetype)videoContentModelWithDict:(NSDictionary *)dict
{
    VideoContentModel *videoContentModel = [[self alloc] init];
    [VideoContentModel setValuesForKeysWithDictionary:dict];
    return videoContentModel;
}

@end
