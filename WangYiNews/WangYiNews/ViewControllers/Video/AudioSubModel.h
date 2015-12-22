//
//  AudioSubModel.h
//  News
//
//  Created by lifangli on 15/9/10.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioSubModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, strong) NSString *imgsrc;

+ (instancetype)audioSubModelWithDict:(NSDictionary *)dict;

@end
