//
//  SepecialSortModel.h
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SepecialSortModel : NSObject

@property (nonatomic, strong) NSArray *docs;
@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSString *shortname;
@property (nonatomic, strong) NSString *showformat;
@property (nonatomic, strong) NSString *timeformat;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *type;

+ (instancetype)sepecialSortModelWithDict:(NSDictionary *)dict;

@end
