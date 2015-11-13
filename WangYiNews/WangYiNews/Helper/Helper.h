//
//  Helper.h
//  FavoriteFree
//
//  Created by leisure on 14-4-22.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject

+(NSInteger)screenHeight;
+(NSInteger)screenWidth;

+(BOOL)isNightMode:(BOOL)isNight;

+(UILabel *)label:(NSString *)title font:(UIFont *)font textColor:(UIColor *)color nightTextColor:(UIColor *)nightColor textAligment:(NSTextAlignment)alignment isNightMode:(BOOL)isNightMode;
+(UIImageView *)imageView:(NSString *)image nightImage:(NSString *)nightImage isNightMode:(BOOL)isNightMode;
+(UIView *)view:(UIColor *)backgroundColor nightColor:(UIColor *)nightBackgroundColor isNightMode:(BOOL)isNightMode;
+(UIButton *)button:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage nightNormalImage:(NSString *)nightNormalImage nightHighlightedImage:(NSString *)nightHighlightedImage target:(id)target action:(SEL)sel tag:(NSInteger)tag isNightMode:(BOOL)isNightMode;
+(UIButton *)button:(NSString *)title textColor:(UIColor *)color nightTextColor:(UIColor *)nightColor textFont:(UIFont *)font tag:(NSInteger)tag target:(id)target action:(SEL)sel isNightMode:(BOOL)isNightMode;

+(NSMutableArray *)addUrlsWithArr:(NSMutableArray *)arr;

-(void)createNavigationBarWithSuperView:(UIView *)view andTitle:(NSString *)title andTarget:(id)target andSel:(SEL)sel isNightMode:(BOOL)isNightMode;

@end






