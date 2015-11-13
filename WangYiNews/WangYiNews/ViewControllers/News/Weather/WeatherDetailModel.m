//
//  WeatherDetailModel.m
//  WangYiNews
//
//  Created by lifangli on 15/10/29.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "WeatherDetailModel.h"

@implementation WeatherDetailModel

+ (instancetype)weatherDetailModelWithDict:(NSDictionary *)dict
{
    WeatherDetailModel *detailModel = [[self alloc] init];
    [detailModel setValuesForKeysWithDictionary:dict];
    return detailModel;
}

@end
