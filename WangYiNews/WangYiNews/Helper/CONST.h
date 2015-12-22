//
//  CONST.h
//  MyProject
//
//  Created by leisure on 14-10-13.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#define BASEURL @"http://c.3g.163.com"

#define SetButtonImage(button,imageName) [button setImage:[Helper isNightMode]?([UIImage imageNamed:[NSString stringWithFormat:@"night_%@",imageName]]?[UIImage imageNamed:[NSString stringWithFormat:@"night_%@",imageName]]:[UIImage imageNamed:imageName]):[UIImage imageNamed:imageName] forState:UIControlStateNormal]
#define SetButtonImageHighlighted(button,imageName) [button setImage:[Helper isNightMode]?([UIImage imageNamed:[NSString stringWithFormat:@"night_%@_highlighted",imageName]]?[UIImage imageNamed:[NSString stringWithFormat:@"night_%@_highlighted",imageName]]:([UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]]?[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]]:[UIImage imageNamed:imageName])):([UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]]?[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]]:[UIImage imageNamed:imageName]) forState:UIControlStateNormal]
#define SetImageViewImage(imageView,imageName) [imageView setDk_imagePicker:DKImageWithImages([UIImage imageNamed:imageName], [UIImage imageNamed:[NSString stringWithFormat:@"night_%@",imageName]]?[UIImage imageNamed:[NSString stringWithFormat:@"night_%@",imageName]]:[UIImage imageNamed:imageName])]

#define RGB(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1.00]

#define DAYBACKGROUNDCOLOR [UIColor whiteColor]
#define NIGHTBACKGROUNDCOLOR [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0]
#define NIGHTTEXTCOLOR [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0]
#define BASERED [UIColor colorWithRed:0.86 green:0.24 blue:0.24 alpha:1.0]
#define BASERED_NIGHT [UIColor colorWithRed:0.62 green:0.16 blue:0.16 alpha:1.0]
#define LINECOLOR [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.0]
#define NIGHTLINECOLOR [UIColor colorWithRed:0.10 green:0.10 blue:0.10 alpha:1.0]
#define GRAYCOLOR [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0]
#define NIGHTGRAYCOLOR [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.0]

#define TITLEFONT [UIFont systemFontOfSize:18]
#define MIDBUTTONFONT [UIFont systemFontOfSize:15]
#define LITELEBUTTONFONT [UIFont systemFontOfSize:13]

#define TOP_NAV_HOTNEWS_TAG 1
#define TOP_NAV_SQUARE_TAG 2
#define USERREAD_TAG 3
#define USEFAVO_TAG 4
#define USECOMMENT_TAG 5
#define USECOIN_TAG 6
#define RECOMMENGREADING_TAG 7
#define MYSUBSCRIBE_TAG 8
#define READPLUS_TAG 9
#define VIDEO_TAG 10
#define RADIO_TAG 11
#define VIDEOTITLEVIEWBUTTON_TAG 12//(13/14/15)

#define AUDIO_MYDOWNLOAD_TAG 20
#define AUDIO_RECENT_TAG 21
#define WECHAT_LOGIN_TAG 22
#define XINLANG_LOGIN_TAG 23
#define QQ_LOGIN_TAG 24
