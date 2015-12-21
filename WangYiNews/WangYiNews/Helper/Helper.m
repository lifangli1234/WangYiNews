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

+(UIButton *)button:(NSString *)title textColor:(UIColor *)color nightTextColor:(UIColor *)nightColor selectedTextColor:(UIColor *)selectedColor nightSelectedTextColor:(UIColor *)nightSelectedColor textFont:(UIFont *)font tag:(NSInteger)tag target:(id)target action:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button dk_setTitleColorPicker:DKColorWithColors(color, nightColor) forState:UIControlStateNormal];
    [button dk_setTitleColorPicker:DKColorWithColors(nightSelectedColor, selectedColor) forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return  button;
}

-(void)createNavigationBarWithSuperView:(UIView *)view andTitle:(NSString *)title andTarget:(id)target andSel:(SEL)sel
{
    UIImageView *IV = [Helper imageView:@"top_navigation_background@2x"];
    [view addSubview:IV];
    [IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(view);
        make.height.offset(64);
    }];
    
    UIButton *backBtn = [Helper button:@"top_navigation_back@2x" target:target action:sel tag:0];
    [view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UILabel *titleLab = [Helper label:title font:TITLEFONT textColor:DAYBACKGROUNDCOLOR nightTextColor:NIGHTTEXTCOLOR textAligment:NSTextAlignmentCenter];
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backBtn.mas_right);
        make.top.mas_equalTo(view).offset(20);
        make.right.mas_equalTo(view).offset(45);
    }];
}

+(NSMutableArray *)addUrlsWithArr:(NSMutableArray *)arr
{
    NSMutableArray *urlArr = [[NSMutableArray alloc] init];
    for (ChannelModel *ttm in arr) {
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
            urlStr = [NSString stringWithFormat:@"%@%@/0-20.html",SUBURL,ttm.tid];
        }
        [urlArr addObject:urlStr];
    }
    return urlArr;
}

@end






