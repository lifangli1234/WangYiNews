//
//  QuestionModel.m
//  WangYiNews
//
//  Created by lifangli on 16/1/6.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

+ (instancetype)questionModelWithDict:(NSDictionary *)dict
{
    QuestionModel *questionModel = [[self alloc] init];
    [QuestionModel setValuesForKeysWithDictionary:dict];
    return questionModel;
}

@end
