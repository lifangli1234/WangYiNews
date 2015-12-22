//
//  AudioSubModel.m
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "AudioSubModel.h"

@implementation AudioSubModel

+ (instancetype)audioSubModelWithDict:(NSDictionary *)dict
{
    AudioSubModel *audioSubModel = [[self alloc] init];
    [AudioSubModel setValuesForKeysWithDictionary:dict];
    return audioSubModel;
}

@end
