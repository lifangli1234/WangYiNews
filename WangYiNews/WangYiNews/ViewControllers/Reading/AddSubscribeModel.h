//
//  AddSubscribeModel.h
//  WangYiNews
//
//  Created by lifangli on 16/1/25.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddSubscribeModel : NSObject

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *showType;
@property (nonatomic, strong) NSString *topicid;
@property (nonatomic, strong) NSNumber *ename;
@property (nonatomic, strong) NSString *subnum;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *template;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSNumber *bannerOrder;
@property (nonatomic, strong) NSNumber *isHot;
@property (nonatomic, strong) NSNumber *isNew;
@property (nonatomic, strong) NSNumber *recommend;
@property (nonatomic, strong) NSNumber *recommendOrder;
@property (nonatomic, assign) BOOL hasCover;
@property (nonatomic, assign) BOOL hasIcon;
@property (nonatomic, assign) BOOL headLine;

+ (instancetype)addSubscribeModelWithDict:(NSDictionary *)dict;

@end
