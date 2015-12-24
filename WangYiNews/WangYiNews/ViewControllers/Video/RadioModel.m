//
//  RadioModel.m
//  WangYiNews
//
//  Created by lifangli on 15/12/24.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "RadioModel.h"

@implementation RadioModel

+ (instancetype)radioModelWithDict:(NSDictionary *)dict
{
    RadioModel *radioModel = [[self alloc] init];
    [RadioModel setValuesForKeysWithDictionary:dict];
    return radioModel;
}

@end
