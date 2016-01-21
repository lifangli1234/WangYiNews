//
//  ReadingModel.h
//  WangYiNews
//
//  Created by lifangli on 16/1/21.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadingModel : NSObject

@property (nonatomic, strong) NSString *boardid;
@property (nonatomic, strong) NSNumber *clkNum;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *docid;
@property (nonatomic, strong) NSNumber *downTimes;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSNumber *imgType;
@property (nonatomic, strong) NSString *imgsrc;
@property (nonatomic, strong) NSNumber *picCount;
@property (nonatomic, strong) NSString *pixel;
@property (nonatomic, strong) NSString *program;
@property (nonatomic, strong) NSString *prompt;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, strong) NSString *recType;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSString *replyid;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *template;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *unlikeReason;
@property (nonatomic, strong) NSNumber *upTimes;
@property (nonatomic, strong) NSString *TAG;
@property (nonatomic, strong) NSString *TAGS;
@property (nonatomic, strong) NSString *recReason;
@property (nonatomic, strong) NSArray *imgnewextra;

+ (instancetype)readingModelWithDict:(NSDictionary *)dict;

@end
