//
//  TopicModel.m
//  WangYiNews
//
//  Created by lifangli on 15/12/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

+ (instancetype)topicModelWithDict:(NSDictionary *)dict
{
    TopicModel *topicModel = [[self alloc] init];
    [TopicModel setValuesForKeysWithDictionary:dict];
    return topicModel;
}

@end
