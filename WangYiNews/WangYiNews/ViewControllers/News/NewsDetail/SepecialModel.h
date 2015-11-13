//
//  SepecialModel.h
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SepecialModel : NSObject

@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSArray *headpics;//(doctag,imgsrc,tag,title,url)
@property (nonatomic, strong) NSNumber *del;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *imgsrc;
@property (nonatomic, strong) NSString *lmodify;
@property (nonatomic, strong) NSString *photoset;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, strong) NSString *sdocid;
@property (nonatomic, strong) NSString *shownav;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *sname;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSArray *topicslatest;
@property (nonatomic, strong) NSArray *topicspatch;
@property (nonatomic, strong) NSArray *topicsplus;
@property (nonatomic, strong) NSArray *webviews;//(pic,title,url,priority(NSNumber))

+ (instancetype)sepecialModelWithDict:(NSDictionary *)dict;

@end
