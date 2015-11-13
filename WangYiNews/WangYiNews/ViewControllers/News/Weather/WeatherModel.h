//
//  WeatherModel.h
//  WangYiNews
//
//  Created by lifangli on 15/10/29.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic, strong) NSArray *detailArray;
@property (nonatomic, strong) NSString *dt;
@property (nonatomic, strong) NSDictionary *pm2d5;
@property (nonatomic, strong) NSNumber *rt_temperature;

@end
