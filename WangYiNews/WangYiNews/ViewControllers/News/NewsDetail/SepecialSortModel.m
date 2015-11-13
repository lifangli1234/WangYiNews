//
//  SepecialSortModel.m
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "SepecialSortModel.h"

@implementation SepecialSortModel

+ (instancetype)sepecialSortModelWithDict:(NSDictionary *)dict
{
    SepecialSortModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
