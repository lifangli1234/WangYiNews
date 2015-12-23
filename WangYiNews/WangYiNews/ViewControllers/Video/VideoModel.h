//
//  VideoModel.h
//  News
//
//  Created by lifangli on 15/9/9.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSMutableArray *videoSidList;
@property (nonatomic, strong) NSMutableArray *videoList;

@property (nonatomic, strong) NSString *videoHomeSid;

+ (instancetype)videoModelWithDict:(NSDictionary *)dict;

@end
