//
//  AddSubscribeModel.m
//  WangYiNews
//
//  Created by lifangli on 16/1/25.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "AddSubscribeModel.h"

@implementation AddSubscribeModel

+ (instancetype)addSubscribeModelWithDict:(NSDictionary *)dict
{
    AddSubscribeModel *addSubscribeModel = [[self alloc] init];
    [AddSubscribeModel setValuesForKeysWithDictionary:dict];
    return addSubscribeModel;
}

@end
