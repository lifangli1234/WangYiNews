//
//  PhotoSetScrollView.m
//  WangYiNews
//
//  Created by lifangli on 15/12/18.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "PhotoSetScrollView.h"

@implementation PhotoSetScrollView

-(NSMutableArray *)imageViewArr
{
    if (_imageViewArr == nil) {
        _imageViewArr = [[NSMutableArray alloc] init];
    }
    return _imageViewArr;
}

-(void)setPhotoSetModel:(PhotoSetModel *)photoSetModel
{
    _photoSetModel = photoSetModel;
    [self layoutSubviewsWithModel:_photoSetModel];
}

-(void)layoutSubviewsWithModel:(PhotoSetModel *)model
{
    self.imageArr = [NSMutableArray arrayWithArray:model.photos];
    
    _photoSetScr = [[UIScrollView alloc] init];
    _photoSetScr.backgroundColor = [UIColor clearColor];
    _photoSetScr.contentSize = CGSizeMake([Helper screenWidth]*self.imageArr.count, [Helper screenHeight]);
    for (int i=0; i<3; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake([Helper screenWidth]*i, 0, [Helper screenWidth], [Helper screenHeight]);
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i]] placeholderImage:[UIImage imageNamed:@""]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_photoSetScr addSubview:imgView];
        
        [self.imageViewArr addObject:imgView];
    }
    [self addSubview:_photoSetScr];
}

@end
