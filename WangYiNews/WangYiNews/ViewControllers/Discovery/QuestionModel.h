//
//  QuestionModel.h
//  WangYiNews
//
//  Created by lifangli on 16/1/6.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *relatedExpertId;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSNumber *cTime;
@property (nonatomic, strong) NSString *userHeadPicUrl;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)questionModelWithDict:(NSDictionary *)dict;

@end
