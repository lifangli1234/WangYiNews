//
//  SepecialContentModel.h
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SepecialContentModel : NSObject

//news  imgnews
@property (nonatomic, strong) NSString *boardid;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *imgsrc;
@property (nonatomic, strong) NSString *lmodify;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSNumber *votecount;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, strong) NSString *docid;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *TAGS;
@property (nonatomic, strong) NSString *TAG;
@property (nonatomic, strong) NSArray *imgextra;
@property (nonatomic,copy) NSString *skipID;
@property (nonatomic,copy) NSString *photosetID;
@property (nonatomic,copy) NSString *skipType;
@property (nonatomic,copy) NSNumber *priority;
@property (nonatomic,copy)NSNumber *imgType;
@property (nonatomic,strong)NSArray *specialextra;
@property (nonatomic,strong)NSArray *live_info;
@property (nonatomic,strong)NSArray *secList;
@property (nonatomic,copy) NSString *secDesc;
@property (nonatomic,copy) NSString *secTitle;
//投票：vote
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *voteid;
@property (nonatomic, strong) NSNumber *date_type;
@property (nonatomic, strong) NSNumber *option_type;
@property (nonatomic, strong) NSNumber *sumnum;
@property (nonatomic, strong) NSArray *voteitem;//{id,name,num(NSNumber)}
//精彩瞬间：photoset
@property (nonatomic, strong) NSString *channelid;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *datatime;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *postid;
@property (nonatomic, strong) NSString *setid;

//视频集锦：video
@property (nonatomic, strong) NSString *m3u8_url;
@property (nonatomic, strong) NSString *m3u8Hd_url;
@property (nonatomic, strong) NSString *mp4_url;
@property (nonatomic, strong) NSString *mp4Hd_url;
@property (nonatomic, strong) NSNumber *playersize;
@property (nonatomic, strong) NSString *replyBoard;
@property (nonatomic, strong) NSString *replyid;
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *videosource;
@property (nonatomic, strong) NSString *vurl;
@property (nonatomic, strong) NSString *topicid;
@property (nonatomic, strong) NSString *videotype;
@property (nonatomic, strong) NSArray *recommend;//(cover,length(NSNumber),m3u8_url,m3u8Hd_url,mp4_url,mp4Hd_url,replyBoard,replyid,title,videoid,videosource,vurl)

//timeline
@property (nonatomic, strong) NSString *important;
@property (nonatomic, strong) NSString *occurtime;

+ (instancetype)sepecialContentModelWithDict:(NSDictionary *)dict;

@end
