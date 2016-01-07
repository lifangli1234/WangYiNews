//
//  AnswerModel.h
//  WangYiNews
//
//  Created by lifangli on 16/1/6.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerModel : NSObject

@property (nonatomic, strong) NSString *answerId;
@property (nonatomic, strong) NSString *board;
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *cTime;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSString *relatedQuestionId;
@property (nonatomic, strong) NSString *specialistHeadPicUrl;
@property (nonatomic, strong) NSString *specialistName;
@property (nonatomic, strong) NSNumber *supportCount;

+ (instancetype)expertModelWithDict:(NSDictionary *)dict;

@end
