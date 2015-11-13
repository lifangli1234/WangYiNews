//
//  WeatherDetailModel.h
//  WangYiNews
//
//  Created by lifangli on 15/10/29.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDetailModel : NSObject

@property (nonatomic, strong) NSString *climate;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *nongli;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *wind;

+ (instancetype)weatherDetailModelWithDict:(NSDictionary *)dict;

@end
