//
//  Helper.h
//  FavoriteFree
//
//  Created by leisure on 14-4-22.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TodayNewsModel.h"
#import "VideoModel.h"

@interface Helper : NSObject

+(NSInteger)screenHeight;
+(NSInteger)screenWidth;

+(BOOL)isNightMode:(BOOL)isNight;

+(UILabel *)label:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color textAligment:(NSTextAlignment)alignment;
+(UIImageView *)imageView:(CGRect)frame name:(NSString *)name;
+(UIView *)view:(CGRect)frame backgroundColor:(UIColor *)color;
+(UIButton *)button:(NSString *)title normalImage:(NSString *)normalImage    highlightedImage:(NSString *)highlightedImage frame:(CGRect)frame target:(id)target action:(SEL)sel textColor:(UIColor *)color textFont:(UIFont *)font tag:(NSInteger)tag;

+(NSMutableArray *)addUrlsWithArr:(NSMutableArray *)arr;

-(void)createNavigationBarWithSuperView:(UIView *)view andTitle:(NSString *)title andTarget:(id)target andSel:(SEL)sel;

-(void)todayNewsDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr;
-(void)videoContentCellDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr;
-(void)videoTitleViewDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr;
-(void)audioDataWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr;
-(void)topNewsTitleListWithDict:(NSDictionary *)dic andArrKey:(NSString *)arrKey andArr:(NSMutableArray *)listArr;

+(NSMutableArray *)sepcialNewsDetailWithDict:(NSDictionary *)dic andKey:(NSString *)key;

@end






