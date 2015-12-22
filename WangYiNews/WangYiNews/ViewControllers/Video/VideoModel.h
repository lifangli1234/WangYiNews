//
//  VideoModel.h
//  News
//
//  Created by lifangli on 15/9/9.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString *titleViewImgsrc;
@property (nonatomic, strong) NSString *titleViewTitle;

@property (nonatomic, strong) NSString *contentCellTitle;
@property (nonatomic, strong) NSString *contentCellDescription;
@property (nonatomic, assign) NSInteger contentCellReplyCount;
@property (nonatomic, strong) NSString *contentCellCover;
@property (nonatomic, assign) NSInteger contentCellLength;
@property (nonatomic, assign) NSInteger contentCellPlayCount;

+ (instancetype)videoModelWithDict:(NSDictionary *)dict;

@end
