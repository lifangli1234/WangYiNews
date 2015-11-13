//
//  SepecialModel.m
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "SepecialModel.h"

@implementation SepecialModel

+(instancetype)sepecialModelWithDict:(NSDictionary *)dict
{
    SepecialModel *sepecialModel = [[self alloc] init];
    [sepecialModel setValuesForKeysWithDictionary:dict];
    return sepecialModel;
}

@end
