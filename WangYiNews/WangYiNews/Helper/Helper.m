//
//  Helper.m
//  FavoriteFree
//
//  Created by leisure on 14-4-22.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import "Helper.h"
#import "ChannelModel.h"

#define SUBURL @"/nc/article/list/"
#define HOTPOINE @"/recommend/getSubDocPic?passport=&devId=4R70nVFo7N%2FjOGAl7Dql%2BgnhtyYRtyVIqBeGB12xtfEEIz0ZpgPoDMhS%2FpBn8zvR&size=20&version=5.5.0&spever=false&net=wifi&lat=&lon=&ts=1452488786&sign=pd7N48tHRS5TvRJR7dDDPjxWzIoCXNneU3inmhjcVHh48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
#define LOCAL @"/nc/article/local/5YyX5Lqs/0-20.html"
#define PHOTO @"/photo/api/list/0096/4GJ60096.json"
#define COMMENT @"/nc/article/comment/list/"
#define LIVE @"/nc/live/livelist.html"
#define CAR @"/nc/auto/list/5YyX5Lqs/0-20.html "
#define DUANZI @"/recommend/getChanRecomNews?channel=duanzi&passport=&devId=4R70nVFo7N%2FjOGAl7Dql%2BgnhtyYRtyVIqBeGB12xtfEEIz0ZpgPoDMhS%2FpBn8zvR&size=20&version=5.5.0&spever=false&net=wifi&lat=uJQXXHviitk5NqEmCMPrww%3D%3D&lon=rhp4fqzFw1y0FLn%2F%2FF8NHg%3D%3D&ts=1452489280&sign=vHSGETotqW9kk2zp4mWON%2FA%2BSd4UIrxm0alvsTfNiEZ48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
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

+(BOOL)isNightMode
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isNightMode"] integerValue] == 1) {
        return YES;
    }
    else
        return NO;
}

+(UILabel*)label:(NSString *)title font:(UIFont *)font textColor:(UIColor *)color nightTextColor:(UIColor *)nightColor textAligment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.text = title;
    label.textAlignment = alignment;
    label.dk_textColorPicker = DKColorWithColors(color, nightColor);
    return label;
}

+(UIImageView*)imageView:(NSString *)image
{
    UIImageView * imageView=nil;
    if (image) {
        imageView=[[UIImageView alloc] init];
        SetImageViewImage(imageView, image);
    }
    else{
        imageView=[[UIImageView alloc] init];
    }
    return imageView;
}

+(UIView *)view:(UIColor *)backgroundColor nightColor:(UIColor *)nightBackgroundColor
{
    UIView *view = [[UIView alloc] init];
    view.dk_backgroundColorPicker = DKColorWithColors(backgroundColor, nightBackgroundColor);
    return view;
}

+(UIButton *)button:(NSString *)image target:(id)target action:(SEL)sel tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    SetButtonImage(button, image);
    SetButtonImageHighlighted(button, image);
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return  button;
}

+(UIButton *)button:(NSString *)title textColor:(UIColor *)color nightTextColor:(UIColor *)nightColor textFont:(UIFont *)font tag:(NSInteger)tag target:(id)target action:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button dk_setTitleColorPicker:DKColorWithColors(color, nightColor) forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return  button;
}

+(UIView *)createNavigationBarWithTitle:(NSString *)title andTarget:(id)target andSel:(SEL)sel
{
    UIView *IV = [Helper view:BASERED nightColor:BASERED_NIGHT];
    
    UIButton *backBtn = [Helper button:@"top_navigation_back@2x" target:target action:sel tag:0];
    [IV addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IV);
        make.top.mas_equalTo(IV).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UILabel *titleLab = [Helper label:title font:TITLEFONT textColor:DAYBACKGROUNDCOLOR nightTextColor:NIGHTTEXTCOLOR textAligment:NSTextAlignmentCenter];
    [IV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backBtn.mas_right);
        make.top.mas_equalTo(IV).offset(20);
        make.right.mas_equalTo(IV).offset(-45);
        make.height.offset(44);
    }];
    
    return IV;
}

+(NSMutableArray *)addUrlsWithArr:(NSMutableArray *)arr
{
    NSMutableArray *urlArr = [[NSMutableArray alloc] init];
    for (ChannelModel *ttm in arr) {
        NSString *urlStr = [[NSString alloc] init];
        if ([ttm.tname isEqualToString:@"头条"]) {
            urlStr = [NSString stringWithFormat:@"/nc/article/headline/%@/%d-20.html?from=toutiao&passport=&devId=4R70nVFo7N%2FjOGAl7Dql%2BgnhtyYRtyVIqBeGB12xtfEEIz0ZpgPoDMhS%2FpBn8zvR&size=20&version=5.5.0&spever=false&net=wifi&lat=&lon=&ts=1452523392&sign=x95ySVU9uSqwqFbt1Ubd3YUtCuLswI8YQmBBOEJwu2B48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore",ttm.tid,0];
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
            urlStr = [NSString stringWithFormat:@"%@%@/0-20.html",SUBURL,ttm.tid];
        }
        [urlArr addObject:urlStr];
    }
    return urlArr;
}

@end






