//
//  RadioModel.h
//  WangYiNews
//
//  Created by lifangli on 15/12/24.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioModel : NSObject

@property (nonatomic, strong) NSString *TAG;
@property (nonatomic, strong) NSString *TAGS;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *boardid;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *docid;
@property (nonatomic, strong) NSString *ename;
@property (nonatomic, strong) NSNumber *hasAD;
@property (nonatomic, assign) BOOL hasCover;
@property (nonatomic, strong) NSNumber *hasHead;
@property (nonatomic, assign) BOOL hasIcon;
@property (nonatomic, strong) NSNumber *hasImg;
@property (nonatomic, strong) NSString *imgsrc;
@property (nonatomic, strong) NSString *lmodify;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSString *pixel;
@property (nonatomic, strong) NSNumber *priority;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *template;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *url_3w;
@property (nonatomic, strong) NSNumber *votecount;

+ (instancetype)radioModelWithDict:(NSDictionary *)dict;

@end
