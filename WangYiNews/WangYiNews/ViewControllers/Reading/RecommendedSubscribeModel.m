//
//  RecommendedSubscribeModel.m
//  WangYiNews
//
//  Created by lifangli on 16/1/22.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "RecommendedSubscribeModel.h"

@implementation RecommendedSubscribeModel

+ (instancetype)recommendedSubscribeModelWithDict:(NSDictionary *)dict
{
    RecommendedSubscribeModel *recommendedSubscribeModel = [[self alloc] init];
    [RecommendedSubscribeModel setValuesForKeysWithDictionary:dict];
    return recommendedSubscribeModel;
}

@end
