//
//  Helper.m
//  FavoriteFree
//
//  Created by leisure on 14-4-22.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import "Helper.h"
#import "AudioModel.h"
#import "AudioSubModel.h"
#import "TopNewsTitleModel.h"
#import "NewsDetailModel.h"

#define SUBURL @"/nc/article/list/"
#define HEADLINE @"/nc/article/headline/"
#define HOTPOINE @"/recommend/getSubDocPic?passport=&devId=C69552E9-7170-416D-ACC0-4432339E77AE&size=20&version=5.3.4&spever=false&net=wifi&lat=40.044000&lon=116.299841"
#define LOCAL @"/nc/article/local/5YyX5Lqs/0-20.html"
#define PHOTO @"/photo/api/list/0096/4GJ60096.json"
#define COMMENT @"/nc/article/comment/list/"
#define LIVE @"/nc/live/livelist.html"
#define CAR @"/nc/auto/list/5YyX5Lqs/0-20.html "
#define DUANZI @"/recommend/getChanRecomNews?channel=duanzi&passport=&devId=A88BD8D8-79E1-4EA6-9DC8-43A816FD0D77&size=20"
#define HOUSE @"/nc/article/house/5YyX5Lqs/0-20.html"

@implementation Helper

+(NSInteger)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+(NSInteger)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+(BOOL)isNightMode:(BOOL)isNight
{
    return isNight;
}

+(UILabel*)label:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color textAligment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.text = title;
    label.textAlignment = alignment;
    label.textColor = color;
    return label;
}

+(UIImageView*)imageView:(CGRect)frame name:(NSString *)name
{
    UIImageView * imageView=nil;
    if (name) {
        imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imageView.frame=frame;
    }
    else{
        imageView=[[UIImageView alloc] initWithFrame:frame];
    }
    
    return imageView;
}

+(UIView *)view:(CGRect)frame backgroundColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+(UIButton *)button:(NSString *)title normalImage:(NSString *)normalImage    highlightedImage:(NSString *)highlightedImage frame:(CGRect)frame target:(id)target action:(SEL)sel textColor:(UIColor *)color textFont:(UIFont *)font tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    button.titleLabel.font = font;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return  button;
}

+(NSMutableArray *)addUrlsWithArr:(NSMutableArray *)arr
{
    NSMutableArray *urlArr = [[NSMutableArray alloc] init];
    for (TopNewsTitleModel *ttm in arr) {
        NSString *urlStr = [[NSString alloc] init];
        if ([ttm.tname isEqualToString:@"头条"]) {
            urlStr = [NSString stringWithFormat:@"%@%@/0-140.html",HEADLINE,ttm.tid];
        }
        else if ([ttm.tname isEqualToString:@"热点"]){
            urlStr = [NSString stringWithFormat:@"%@",HOTPOINE];
        }
        else if ([ttm.tname isEqualToString:@"北京"]){
            urlStr = [NSString stringWithFormat:@"%@",LOCAL];
        }
        else if ([ttm.tname isEqualToString:@"图片"]){
            urlStr = [NSString stringWithFormat:@"%@",PHOTO];
        }
        else if ([ttm.tname isEqualToString:@"跟帖"]){
            urlStr = [NSString stringWithFormat:@"%@%@/0-20.html",COMMENT,ttm.tid];
        }
        else if ([ttm.tname isEqualToString:@"直播"]){
            urlStr = [NSString stringWithFormat:@"%@",LIVE];
        }
        else if ([ttm.tname isEqualToString:@"汽车"]){
            urlStr = [NSString stringWithFormat:@"%@",CAR];
        }
        else if ([ttm.tname isEqualToString:@"段子"]){
            urlStr = [NSString stringWithFormat:@"%@",DUANZI];
        }
        else if ([ttm.tname isEqualToString:@"房产"]){
            urlStr = [NSString stringWithFormat:@"%@",HOUSE];
        }
        else{
            urlStr = [NSString stringWithFormat:@"%@%@/0-20html",SUBURL,ttm.tid];
        }
        [urlArr addObject:urlStr];
    }
    return urlArr;
}

-(void)createNavigationBarWithSuperView:(UIView *)view andTitle:(NSString *)title andTarget:(id)target andSel:(SEL)sel
{
    [view addSubview:[Helper imageView:CGRectMake(0, 0, [Helper screenWidth], 64) name:@"top_navigation_background@2x.png"]];
    
    [view addSubview:[Helper button:nil normalImage:@"top_navigation_back@2x.png" highlightedImage:@"top_navigation_back_highlighted@2x.png" frame:CGRectMake(0, 20, 45, 44) target:target action:sel textColor:nil textFont:nil tag:0]];
    
    [view addSubview:[Helper label:title frame:CGRectMake(45, 20, [Helper screenWidth]-90, 44) font:TITLEFONT textColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter]];
}

-(void)todayNewsDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr
{
    NSMutableArray *arr = [dic objectForKey:arrKey];
    for (NSDictionary *subDic in arr) {
        TodayNewsModel *todayNewsModel = [[TodayNewsModel alloc] init];
        todayNewsModel.title = [subDic objectForKey:@"title"];
        todayNewsModel.imgsrc = [subDic objectForKey:@"imgsrc"];
        todayNewsModel.replyCount = [[subDic objectForKey:@"replyCount"] integerValue];
        todayNewsModel.digest = [subDic objectForKey:@"digest"];
        todayNewsModel.docid = [subDic objectForKey:@"docid"];
        todayNewsModel.boardid = [subDic objectForKey:@"boardid"];
        todayNewsModel.skipID = [subDic objectForKey:@"skipID"];
        todayNewsModel.skipType = [subDic objectForKey:@"skipType"];
        [listArr addObject:todayNewsModel];
    }
}

-(void)videoContentCellDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr
{
    NSMutableArray *arr = [dic objectForKey:arrKey];
    for (NSDictionary *subDic in arr) {
        VideoModel *videoModel = [[VideoModel alloc] init];
        videoModel.contentCellCover = [subDic objectForKey:@"cover"];
        videoModel.contentCellDescription = [subDic objectForKey:@"description"];
        videoModel.contentCellLength = [[subDic objectForKey:@"length"] integerValue];
        videoModel.contentCellReplyCount = [[subDic objectForKey:@"replyCount"] integerValue];
        videoModel.contentCellPlayCount = [[subDic objectForKey:@"playCount"] integerValue];
        videoModel.contentCellTitle = [subDic objectForKey:@"title"];
        [listArr addObject:videoModel];
    }
}

-(void)videoTitleViewDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr
{
    NSMutableArray *arr = [dic objectForKey:arrKey];
    for (NSDictionary *subDic in arr) {
        VideoModel *videoModel = [[VideoModel alloc] init];
        videoModel.titleViewImgsrc = [subDic objectForKey:@"imgsrc"];
        videoModel.titleViewTitle = [subDic objectForKey:@"title"];
        [listArr addObject:videoModel];
    }
}

-(void)audioDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr
{
    NSMutableArray *arr = [dic objectForKey:arrKey];
    for (NSDictionary *subDic in arr) {
        AudioModel *audioModel = [[AudioModel alloc] init];
        audioModel.cName = [subDic objectForKey:@"cname"];
        audioModel.tList = [[NSMutableArray alloc] init];
        NSMutableArray *subArr = [subDic objectForKey:@"tList"];
        for(NSDictionary *listDic in subArr){
            AudioSubModel *audioSubModel = [[AudioSubModel alloc] init];
            audioSubModel.playCount = [[listDic objectForKey:@"playCount"] integerValue];
            NSDictionary *radioDic = [listDic objectForKey:@"radio"];
            audioSubModel.title = [radioDic objectForKey:@"title"];
            audioSubModel.imgsrc = [radioDic objectForKey:@"imgsrc"];
            audioSubModel.tname = [radioDic objectForKey:@"tname"];
            [audioModel.tList addObject:audioSubModel];
        }
        [listArr addObject:audioModel];
    }
}

-(void)topNewsTitleListWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr
{
    NSMutableArray *arr = [dic objectForKey:arrKey];
    for (NSDictionary *subDic in arr) {
        TopNewsTitleModel *ttm = [[TopNewsTitleModel alloc] init];
        ttm.cid = [subDic objectForKey:@"cid"];
        ttm.tid = [subDic objectForKey:@"tid"];
        ttm.topicid = [subDic objectForKey:@"topicid"];
        ttm.tname = [subDic objectForKey:@"tname"];
        ttm.isHot = [subDic objectForKey:@"isHot"];
        ttm.isNew = [subDic objectForKey:@"isNew"];
        [listArr addObject:ttm];
    }
}

+(NSMutableArray *)sepcialNewsDetailWithDict:(NSDictionary *)dic andKey:(NSString *)key
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    NSDictionary *subDic = [dic objectForKey:key];
    NewsDetailModel *ndb = [[NewsDetailModel alloc] init];
    ndb.banner = [subDic objectForKey:@"banner"];
    ndb.digest = [subDic objectForKey:@"digest"];
    ndb.imgsrc = [subDic objectForKey:@"imgsrc"];
    ndb.lmodify = [subDic objectForKey:@"lmodify"];
    ndb.ptime = [subDic objectForKey:@"ptime"];
    ndb.sid = [subDic objectForKey:@"sid"];
    ndb.sname = [subDic objectForKey:@"sname"];
    ndb.tag = [subDic objectForKey:@"tag"];
    ndb.type = [subDic objectForKey:@"type"];
    NSMutableArray *subArr = [subDic objectForKey:@"topics"];
    for(NSDictionary *dic1 in subArr){
        NewsDetailModel *ndb1 = [[NewsDetailModel alloc] init];
        ndb1.index = [dic1 objectForKey:@"index"];
        ndb1.shortname = [dic1 objectForKey:@"shortname"];
        ndb1.tname = [dic1 objectForKey:@"tname"];
        ndb1.type1 = [dic1 objectForKey:@"type"];
        [ndb.topics addObject:ndb1];
        NSMutableArray *subArr1 = [subDic objectForKey:@"docs"];
        for(NSDictionary *dic2 in subArr1){
            NewsDetailModel *ndb2 = [[NewsDetailModel alloc] init];
            ndb2.digest2 = [dic2 objectForKey:@"digest"];
            ndb2.docid = [dic2 objectForKey:@"docid"];
            ndb2.imgsrc2 = [dic2 objectForKey:@"imgsrc"];
            ndb2.lmodify2 = [dic2 objectForKey:@"lmodify"];
            ndb2.ptime2 = [dic2 objectForKey:@"ptime"];
            ndb2.replyCount = [dic2 objectForKey:@"replyCount"];
            ndb2.tag2 = [dic2 objectForKey:@"tag"];
            ndb2.title = [dic2 objectForKey:@"title"];
            [ndb1.docs addObject:ndb2];
        }
    }
    NSMutableArray *SubArr = [subDic objectForKey:@"topicsplus"];
    for(NSDictionary *dic1 in SubArr){
        NewsDetailModel *ndb1 = [[NewsDetailModel alloc] init];
        ndb1.index = [dic1 objectForKey:@"index"];
        ndb1.shortname = [dic1 objectForKey:@"shortname"];
        ndb1.tname = [dic1 objectForKey:@"tname"];
        ndb1.type1 = [dic1 objectForKey:@"type"];
        [ndb.topics addObject:ndb1];
        NSMutableArray *subArr1 = [subDic objectForKey:@"docs"];
        for(int i=0; i<subArr1.count; i++){
            NSDictionary *dic2 = subArr1[i];
            NewsDetailModel *ndb2 = [[NewsDetailModel alloc] init];
            ndb2.cover = [dic2 objectForKey:@"cover"];
            ndb2.m3u8_url = [dic2 objectForKey:@"m3u8_url"];
            ndb2.m3u8Hd_url = [dic2 objectForKey:@"m3u8Hd_url"];
            ndb2.mp4_url = [dic2 objectForKey:@"mp4_url"];
            ndb2.mp4Hd_url = [dic2 objectForKey:@"mp4Hd_url"];
            ndb2.playersize = [dic2 objectForKey:@"playersize"];
            ndb2.replyBoard = [dic2 objectForKey:@"replyBoard"];
            ndb2.replyid = [dic2 objectForKey:@"replyid"];
            ndb2.title = [dic2 objectForKey:@"title"];
            ndb2.topicid = [dic2 objectForKey:@"topicid"];
            ndb2.ptime2 = [dic2 objectForKey:@"ptime"];
            ndb2.vid = [dic2 objectForKey:@"vid"];
            ndb2.videosource = [dic2 objectForKey:@"videosource"];
            ndb2.videotype = [dic2 objectForKey:@"videotype"];
            ndb2.vurl = [dic2 objectForKey:@"vurl"];
            [ndb1.docs addObject:ndb2];
            NSMutableArray *subArr2 = [[NSMutableArray alloc] init];
            if (i==0) {
                subArr2 = [subDic objectForKey:@"recommend"];
            }
            else{
                subArr2 = [subDic objectForKey:@"secList"];
            }
            for(NSDictionary *dic3 in subArr2){
                NewsDetailModel *ndb3 = [[NewsDetailModel alloc] init];
                ndb3.cover3 = [dic3 objectForKey:@"cover"];
                ndb3.m3u8_url3 = [dic2 objectForKey:@"m3u8_url"];
                ndb3.m3u8Hd_url3 = [dic2 objectForKey:@"m3u8Hd_url"];
                ndb3.mp4_url3 = [dic2 objectForKey:@"mp4_url"];
                ndb3.mp4Hd_url3 = [dic2 objectForKey:@"mp4Hd_url"];
                ndb3.lenght = [dic2 objectForKey:@"lenght"];
                ndb3.replyBoard3 = [dic2 objectForKey:@"replyBoard"];
                ndb3.replyid3 = [dic2 objectForKey:@"replyid"];
                ndb3.title3 = [dic2 objectForKey:@"title"];
                ndb3.videoid = [dic2 objectForKey:@"videoid"];
                ndb3.videosource3 = [dic2 objectForKey:@"videosource"];
                ndb3.vurl3 = [dic2 objectForKey:@"vurl"];
                [ndb2.recommend addObject:ndb3];
            }
        }
    }
    [tempArr addObject:ndb];
    return tempArr;
}

@end






