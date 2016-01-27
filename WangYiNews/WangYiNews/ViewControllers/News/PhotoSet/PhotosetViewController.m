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
    UIView *_bottomView;
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
//    UIImageView *img = [Helper imageView:@"night_contentview_image_default@2x"];
//    [self.view addSubview:img];
//    [img mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.sizeOffset(CGSizeMake(100, 100));
//    }];
    _photoSetView = [[PhotoSetScrollView alloc] init];
    _photoSetView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_photoSetView];
    [_photoSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.right.left.bottom.equalTo(self.view);
    }];
    
    UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [testActivityIndicator startAnimating];
    [self.view addSubview:testActivityIndicator];
    [testActivityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    NSArray *idArr = [self.newsModel.skipID componentsSeparatedByString:@"|"];
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:idArr[0]];
    NSString *str = [mStr substringWithRange:NSMakeRange(mStr.length-4, 4)];
    NSString *url = [NSString stringWithFormat:@"/photo/api/set/%@/%@.json",str,idArr[1]];
    [[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [testActivityIndicator stopAnimating];
        _photoSetModel = [PhotoSetModel objectWithKeyValues:responseObject];
        [_photoSetView setPhotoSetModel:_photoSetModel];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [testActivityIndicator stopAnimating];
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
    CGSize size = [[NSString stringWithFormat:@"%@跟帖",_newsModel.replyCount] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _replyCountBtn.frame = CGRectMake([Helper screenWidth]-size.width-28, 20, size.width + 20, 40);
    _replyCountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_replyCountBtn setTitle:[NSString stringWithFormat:@"%@跟帖",_newsModel.replyCount] forState:UIControlStateNormal];
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
    _bottomView = [Helper view:[UIColor colorWithWhite:0 alpha:0.6] nightColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.offset(44);
    }];
    
    UIView *line = [Helper view:[UIColor grayColor] nightColor:[UIColor grayColor]];
    [_bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-43.5);
        make.left.right.equalTo(self.view);
        make.height.offset(0.3);
    }];
    
    UIButton *favouriteBtn = [Helper button:@"night_icon_star@2x" target:self action:@selector(addToFavotrite) tag:0];
    [_bottomView addSubview:favouriteBtn];
    [favouriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(_bottomView);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UIButton *shareBtn = [Helper button:@"weather_share@2x" target:self action:@selector(share) tag:0];
    [_bottomView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomView);
        make.right.equalTo(favouriteBtn.mas_left).offset(-8);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UIButton *downLoadBtn = [Helper button:@"" target:self action:@selector(downLoadImage) tag:0];
    [_bottomView addSubview:downLoadBtn];
    [downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomView);
        make.right.equalTo(shareBtn.mas_left).offset(-8);
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
