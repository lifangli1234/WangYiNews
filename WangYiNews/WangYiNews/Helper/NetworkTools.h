//
//  NetworkTools.h
//  WangYiNews
//
//  Created by lifangli on 15/10/21.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;

@end
