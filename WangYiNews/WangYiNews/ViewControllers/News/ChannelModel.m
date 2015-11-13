//
//  ChannelModel.m
//  NetEaseNews
//
//  Created by wangshiyu13 on 15/1/24.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

+ (instancetype)channelModelWithDict:(NSDictionary *)dict
{
    ChannelModel *channelModel = [[self alloc] init];
    [channelModel setValuesForKeysWithDictionary:dict];
    return channelModel;
}

@end
