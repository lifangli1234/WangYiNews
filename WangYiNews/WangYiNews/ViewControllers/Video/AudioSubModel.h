//
//  AudioSubModel.h
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioSubModel : NSObject

@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSNumber *bannerOrder;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *ename;
@property (nonatomic, assign) BOOL hasCover;
@property (nonatomic, assign) BOOL hasIcon;
@property (nonatomic, assign) BOOL headLine;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSNumber *isHot;
@property (nonatomic, strong) NSNumber *isNew;
@property (nonatomic, strong) NSNumber *playCount;
@property (nonatomic, strong) NSDictionary *radio;
@property (nonatomic, strong) NSString *recommend;
@property (nonatomic, strong) NSNumber *recommendOrder;
@property (nonatomic, strong) NSString *showType;
@property (nonatomic, strong) NSString *subnum;
@property (nonatomic, strong) NSString *template;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *topicid;

+ (instancetype)audioSubModelWithDict:(NSDictionary *)dict;

@end
