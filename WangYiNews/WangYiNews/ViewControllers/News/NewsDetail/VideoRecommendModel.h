//
//  VideoRecommendModel.h
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoRecommendModel : NSObject

@property (nonatomic, strong) NSString *m3u8_url;
@property (nonatomic, strong) NSString *m3u8Hd_url;
@property (nonatomic, strong) NSString *mp4_url;
@property (nonatomic, strong) NSString *mp4Hd_url;
@property (nonatomic, strong) NSNumber *length;
@property (nonatomic, strong) NSString *replyBoard;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *replyid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *videoid;
@property (nonatomic, strong) NSString *videosource;
@property (nonatomic, strong) NSString *vurl;

@end
