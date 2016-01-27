//
//  NewsCategoryTitle.m
//  News
//
//  Created by lifangli on 15/9/16.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "NewsCategoryTitle.h"

@implementation NewsCategoryTitle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:21];
        
        self.scale = 0.0;
    }
    return self;
}

-(void)setScale:(CGFloat)scale
{
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    
    CGFloat minScale = 0.8;
    CGFloat curScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(curScale, curScale);
}

@end
