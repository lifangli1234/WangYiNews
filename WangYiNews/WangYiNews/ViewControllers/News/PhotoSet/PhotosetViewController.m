//
//  PhotosetViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "PhotosetViewController.h"
#import "PhotoSetScrollView.h"

@interface PhotosetViewController ()

@end

@implementation PhotosetViewController
{
    UIButton *_backBtn;
    UIButton *_replyCountBtn;
    UIView *_line;
    UIButton *_downLoadBtn;
    UIButton *_shareBtn;
    UIButton *_favouriteBtn;
    PhotoSetScrollView *_photoSetView;
    PhotoSetModel *_photoSetModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    [self createImageSroll];
    [self createNavigationBar];
    [self createFooterButton];
}

-(void)createImageSroll
{
    NSArray *idArr = [self.newsModel.skipID componentsSeparatedByString:@"|"];
    NSString *url = [NSString stringWithFormat:@"/photo/api/set/0096/%@.json",idArr[1]];
    [[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _photoSetModel = [PhotoSetModel objectWithKeyValues:responseObject];
        _photoSetView = [[PhotoSetScrollView alloc] init];
        [_photoSetView setPhotoSetModel:_photoSetModel];
        _photoSetView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_photoSetView];
        [_photoSetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(20);
            make.right.left.bottom.equalTo(self.view);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)createNavigationBar
{
    _backBtn = [Helper button:@"top_navigation_back@2x" target:self action:@selector(backBtn) tag:0];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(54, 44));
    }];
    
    _replyCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [[NSString stringWithFormat:@"%@",_newsModel.replyCount] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _replyCountBtn.frame = CGRectMake([Helper screenWidth]-size.width-28, 20, size.width + 20, 40);
    _replyCountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_replyCountBtn setTitle:[NSString stringWithFormat:@"%@",_newsModel.replyCount] forState:UIControlStateNormal];
    [_replyCountBtn needsUpdateConstraints];
    UIImage *normalImg = [UIImage imageNamed:@"contentview_commentbacky"];
    UIImage *highlightedImg = [UIImage imageNamed:@"contentview_commentbacky_selected"];
    CGFloat normalW = normalImg.size.width;
    CGFloat normalH = normalImg.size.height;
    CGFloat highW = highlightedImg.size.width;
    CGFloat highH = highlightedImg.size.height;
    normalImg = [normalImg resizableImageWithCapInsets:UIEdgeInsetsMake(normalH * 0.5, normalW * 0.5, normalH * 0.5, normalW * 0.5)];
    highlightedImg = [highlightedImg resizableImageWithCapInsets:UIEdgeInsetsMake(highH * 0.5, highW * 0.5, highH * 0.5, highW * 0.5)];
    [_replyCountBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_replyCountBtn setBackgroundImage:highlightedImg forState:UIControlStateHighlighted];
    _replyCountBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 15);
    [self.view addSubview:_replyCountBtn];
}

-(void)createFooterButton
{
    _line = [Helper view:[UIColor grayColor] nightColor:[UIColor grayColor]];
    [self.view addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-43.5);
        make.left.right.equalTo(self.view);
        make.height.offset(0.3);
    }];
    
    _favouriteBtn = [Helper button:@"night_icon_star@2x" target:self action:@selector(addToFavotrite) tag:0];
    [self.view addSubview:_favouriteBtn];
    [_favouriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    _shareBtn = [Helper button:@"weather_share@2x" target:self action:@selector(share) tag:0];
    [self.view addSubview:_shareBtn];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.right.equalTo(_favouriteBtn.mas_left).offset(-8);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    _downLoadBtn = [Helper button:@"" target:self action:@selector(downLoadImage) tag:0];
    [self.view addSubview:_downLoadBtn];
    [_downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.right.equalTo(_shareBtn.mas_left).offset(-8);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)downLoadImage
{}

-(void)share
{}

-(void)addToFavotrite
{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
