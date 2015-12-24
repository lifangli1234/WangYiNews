//
//  AudioModel.h
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioModel : NSObject

@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic, strong) NSMutableArray *tList;

+ (instancetype)audioModelWithDict:(NSDictionary *)dict;

@end
