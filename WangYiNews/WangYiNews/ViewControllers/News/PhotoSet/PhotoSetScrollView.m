//
//  PhotoSetScrollView.m
//  WangYiNews
//
//  Created by lifangli on 15/12/18.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "PhotoSetScrollView.h"
#import "PhotoModel.h"

@implementation PhotoSetScrollView
{
    UILabel *_countLabel;
    UILabel *_content;
    UIScrollView *contentScr;
}

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
    _photoSetScr.frame = CGRectMake(0, 0, [Helper screenWidth], [Helper screenHeight]);
    _photoSetScr.backgroundColor = [UIColor clearColor];
    _photoSetScr.pagingEnabled = YES;
    _photoSetScr.bounces = NO;
    _photoSetScr.delegate = self;
    _photoSetScr.showsHorizontalScrollIndicator = NO;
    _photoSetScr.contentSize = CGSizeMake([Helper screenWidth]*self.imageArr.count, [Helper screenHeight]);
    for (int i=0; i<self.imageArr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake([Helper screenWidth]*i, 0, [Helper screenWidth], [Helper screenHeight]);
        [imgView sd_setImageWithURL:[NSURL URLWithString:[self.imageArr[i] objectForKey:@"imgurl"]] placeholderImage:[UIImage imageNamed:@""]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_photoSetScr addSubview:imgView];
        
        [self.imageViewArr addObject:imgView];
    }
    [self addSubview:_photoSetScr];
    
    [self addSubscriptionWithModel:model];
}

-(void)addSubscriptionWithModel:(PhotoSetModel *)model
{
    UIView *view = [Helper view:[UIColor colorWithWhite:0 alpha:0.6] nightColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-44);
        make.left.right.equalTo(self);
        make.height.offset(160);
    }];
    
    UILabel *title = [Helper label:model.setname font:[UIFont boldSystemFontOfSize:17] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.right.equalTo(view).offset(-10);
        make.top.equalTo(view);
        make.height.offset(30);
    }];
    
    UILabel *totalCountLabel = [Helper label:[NSString stringWithFormat:@"/%ld",self.imageArr.count] font:[UIFont systemFontOfSize:13] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentRight];
    [view addSubview:totalCountLabel];
    [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-10);
        make.centerY.equalTo(title);
    }];
    
    _countLabel = [Helper label:[NSString stringWithFormat:@"%d",1] font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentRight];
    [view addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalCountLabel.mas_left);
        make.centerY.equalTo(totalCountLabel);
    }];
    
    contentScr = [[UIScrollView alloc] init];
    contentScr.frame = CGRectMake(10, 30, [Helper screenWidth]-20, 130);
    contentScr.backgroundColor = [UIColor clearColor];
    contentScr.bounces = NO;
    contentScr.showsVerticalScrollIndicator = NO;
    [view addSubview:contentScr];
    
    NSDictionary *dic = [self.imageArr objectAtIndex:0];
    PhotoModel *pm = [PhotoModel objectWithKeyValues:dic];
    _content = [Helper label:[NSString stringWithFormat:@"%@   %@",pm.imgtitle,pm.note] font:[UIFont systemFontOfSize:13] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft];
    _content.numberOfLines = 0;
    _content.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize titleSize = [_content.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    _content.frame = CGRectMake(0, 0, [Helper screenWidth]-20, titleSize.height);
    contentScr.contentSize = CGSizeMake([Helper screenWidth]-20, titleSize.height);
    [contentScr addSubview:_content];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger offset = scrollView.contentOffset.x/[Helper screenWidth];
    NSDictionary *dic = [self.imageArr objectAtIndex:offset];
    PhotoModel *pm = [PhotoModel objectWithKeyValues:dic];
    _content.text = [NSString stringWithFormat:@"%@   %@",pm.imgtitle,pm.note];
    CGSize titleSize = [_content.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    _content.frame = CGRectMake(0, 0, [Helper screenWidth]-20, titleSize.height);
    contentScr.contentSize = CGSizeMake([Helper screenWidth]-20, titleSize.height);
    _countLabel.text = [NSString stringWithFormat:@"%ld",offset+1];
}

@end
