//
//  RecommendedSubscribeModel.h
//  WangYiNews
//
//  Created by lifangli on 16/1/22.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendedSubscribeModel : NSObject

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *docid;
@property (nonatomic, strong) NSNumber *ename;
@property (nonatomic, strong) NSString *subnum;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgsrc;

+ (instancetype)recommendedSubscribeModelWithDict:(NSDictionary *)dict;

@end
