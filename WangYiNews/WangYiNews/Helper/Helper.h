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

+(BOOL)isNightMode;

+(UILabel *)label:(NSString *)title font:(UIFont *)font textColor:(UIColor *)color nightTextColor:(UIColor *)nightColor textAligment:(NSTextAlignment)alignment;
+(UIImageView *)imageView:(NSString *)image;
+(UIView *)view:(UIColor *)backgroundColor nightColor:(UIColor *)nightBackgroundColor;
+(UIButton *)button:(NSString *)image target:(id)target action:(SEL)sel tag:(NSInteger)tag;
+(UIButton *)button:(NSString *)title textColor:(UIColor *)color nightTextColor:(UIColor *)nightColor textFont:(UIFont *)font tag:(NSInteger)tag target:(id)target action:(SEL)sel;

+(NSMutableArray *)addUrlsWithArr:(NSMutableArray *)arr count:(NSInteger)count;

+(UIView *)createNavigationBarWithTitle:(NSString *)title andTarget:(id)target andSel:(SEL)sel;

@end






