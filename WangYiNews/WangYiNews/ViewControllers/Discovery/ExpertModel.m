//
//  ExpertModel.m
//  WangYiNews
//
//  Created by lifangli on 15/12/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "ExpertModel.h"

@implementation ExpertModel

+ (instancetype)expertModelWithDict:(NSDictionary *)dict
{
    ExpertModel *expertModel = [[self alloc] init];
    [ExpertModel setValuesForKeysWithDictionary:dict];
    return expertModel;
}

@end
