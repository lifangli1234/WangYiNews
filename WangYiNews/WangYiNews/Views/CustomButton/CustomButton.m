//
//  CustomButton.m
//  SecondHandCar
//
//  Created by lifangli on 15/8/17.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageWidth = contentRect.size.height*0.5;
    CGFloat imageHeight = contentRect.size.height*0.5;
    CGFloat imageX = (contentRect.size.width-imageWidth)/2;
    return CGRectMake(imageX, 5, imageWidth, imageHeight);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height*0.5 + 5;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

@end
