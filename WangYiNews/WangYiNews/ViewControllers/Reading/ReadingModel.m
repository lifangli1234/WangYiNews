//
//  ReadingModel.m
//  WangYiNews
//
//  Created by lifangli on 16/1/21.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "ReadingModel.h"

@implementation ReadingModel

+ (instancetype)readingModelWithDict:(NSDictionary *)dict
{
    ReadingModel *readingModel = [[self alloc] init];
    [ReadingModel setValuesForKeysWithDictionary:dict];
    return readingModel;
}

@end
