//
//  AudioModel.m
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "AudioModel.h"

@implementation AudioModel

+ (instancetype)audioModelWithDict:(NSDictionary *)dict
{
    AudioModel *audioModel = [[self alloc] init];
    [AudioModel setValuesForKeysWithDictionary:dict];
    return audioModel;
}

@end
