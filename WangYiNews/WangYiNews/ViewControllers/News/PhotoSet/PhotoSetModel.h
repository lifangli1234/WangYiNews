//
//  PhotoSetModel.h
//  WangYiNews
//
//  Created by lifangli on 15/11/11.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSetModel : NSObject

@property(nonatomic, strong)NSString *autoid;
@property(nonatomic, strong)NSString *boardid;
@property(nonatomic, strong)NSString *clientadurl;
@property(nonatomic, strong)NSString *commenturl;
@property(nonatomic, strong)NSString *cover;
@property(nonatomic, strong)NSString *createdate;
@property(nonatomic, strong)NSString *creator;
@property(nonatomic, strong)NSString *datatime;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)NSString *imgsum;
@property(nonatomic, strong)NSString *postid;
@property(nonatomic, strong)NSString *reporter;
@property(nonatomic, strong)NSString *scover;
@property(nonatomic, strong)NSString *series;
@property(nonatomic, strong)NSString *setname;
@property(nonatomic, strong)NSString *settag;
@property(nonatomic, strong)NSString *source;
@property(nonatomic, strong)NSString *tcover;
@property(nonatomic, strong)NSString *url;
@property(nonatomic, strong)NSArray *photos;
@property(nonatomic, strong)NSArray *relatedids;

@end
