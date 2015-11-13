//
//  NetworkTools.m
//  WangYiNews
//
//  Created by lifangli on 15/10/21.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+(instancetype)sharedNetworkTools
{
    static NetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}

@end
