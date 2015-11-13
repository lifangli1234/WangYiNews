//
//  NewsModel.m
//  WangYiNews
//
//  Created by lifangli on 15/10/24.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+(instancetype)newsModelWithDict:(NSDictionary *)dict
{
    NewsModel *newsModel = [[self alloc] init];
    [NewsModel setValuesForKeysWithDictionary:dict];
    return newsModel;
}

@end
