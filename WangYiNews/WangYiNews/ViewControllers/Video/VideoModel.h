//
//  VideoModel.h
//  News
//
//  Created by lifangli on 15/9/9.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,assign)NSNumber *length;
@property(nonatomic,strong)NSString *m3u8Hd_url;
@property(nonatomic,strong)NSString *m3u8_url;
@property(nonatomic,strong)NSString *mp4Hd_url;
@property(nonatomic,strong)NSString *mp4_url;
@property(nonatomic,assign)NSNumber *playCount;
@property(nonatomic,assign)NSNumber *playersize;
@property(nonatomic,strong)NSString *ptime;
@property(nonatomic,strong)NSString *replyBoard;
@property(nonatomic,assign)NSNumber *replyCount;
@property(nonatomic,strong)NSString *replyid;
@property(nonatomic,strong)NSString *sectiontitle;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *topicDesc;
@property(nonatomic,strong)NSString *topicImg;
@property(nonatomic,strong)NSString *topicName;
@property(nonatomic,strong)NSString *topicSid;
@property(nonatomic,strong)NSString *prompt;
@property(nonatomic,strong)NSString *videosource;
@property(nonatomic,strong)NSString *vid;
@property(nonatomic,strong)NSDictionary *videoTopic;//alias,ename,tid,tname


+ (instancetype)videoModelWithDict:(NSDictionary *)dict;

@end
