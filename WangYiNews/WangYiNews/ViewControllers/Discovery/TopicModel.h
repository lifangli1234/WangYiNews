//
//  TopicModel.h
//  WangYiNews
//
//  Created by lifangli on 15/12/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSDictionary *data;

+ (instancetype)topicModelWithDict:(NSDictionary *)dict;

@end
