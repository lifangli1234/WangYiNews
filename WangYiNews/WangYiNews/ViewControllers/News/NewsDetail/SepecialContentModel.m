//
//  SepecialContentModel.m
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "SepecialContentModel.h"

@implementation SepecialContentModel

+ (instancetype)sepecialContentModelWithDict:(NSDictionary *)dict
{
    SepecialContentModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
