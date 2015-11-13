//
//  ChannelModel.h
//  NetEaseNews
//
//  Created by wangshiyu13 on 15/1/24.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, strong) NSNumber *bannerOrder;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *ename;
@property (nonatomic, assign) BOOL hasCover;
@property (nonatomic, assign) BOOL hasIcon;
@property (nonatomic, assign) BOOL headLine;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, strong) NSNumber *isHot;
@property (nonatomic, strong) NSNumber *isNew;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, strong) NSNumber *recommendOrder;
@property (nonatomic, copy) NSString *showType;
@property (nonatomic, strong) NSNumber *special;
@property (nonatomic, copy) NSString *subnum;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *tagDate;
@property (nonatomic, copy) NSString *template;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *topicid;

+ (instancetype)channelModelWithDict:(NSDictionary *)dict;

@end
