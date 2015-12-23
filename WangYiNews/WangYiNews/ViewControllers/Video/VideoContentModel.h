//
//  VideoContentModel.h
//  WangYiNews
//
//  Created by lifangli on 15/12/23.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoContentModel : NSObject

@property(nonatomic,strong)NSString *cover;
@property(nonatomic,assign)NSInteger length;
@property(nonatomic,strong)NSString *m3u8Hd_url;
@property(nonatomic,strong)NSString *m3u8_url;
@property(nonatomic,strong)NSString *mp4Hd_url;
@property(nonatomic,strong)NSString *mp4_url;
@property(nonatomic,assign)NSInteger playCount;
@property(nonatomic,assign)NSInteger playersize;
@property(nonatomic,strong)NSString *ptime;
@property(nonatomic,strong)NSString *replyBoard;
@property(nonatomic,assign)NSInteger replyCount;
@property(nonatomic,strong)NSString *replyid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *vid;
@property(nonatomic,strong)NSString *videosource;
@property(nonatomic,strong)NSString *desc;

+ (instancetype)videoContentModelWithDict:(NSDictionary *)dict;

@end
