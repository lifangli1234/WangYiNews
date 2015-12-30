//
//  ExpertModel.h
//  WangYiNews
//
//  Created by lifangli on 15/12/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertModel : NSObject

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *classification;
@property (nonatomic, strong) NSString *expertId;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, strong) NSNumber *concernCount;
@property (nonatomic, strong) NSString *headpicurl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picurl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *state;

+ (instancetype)expertModelWithDict:(NSDictionary *)dict;

@end
