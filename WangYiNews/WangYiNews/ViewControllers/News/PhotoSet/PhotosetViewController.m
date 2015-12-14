//
//  PhotosetViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "PhotosetViewController.h"

@interface PhotosetViewController ()

@property(nonatomic, assign) BOOL isNightMode;

@end

@implementation PhotosetViewController
{
    UIButton *_backBtn;
    UIButton *_replyCountBtn;
    UIView *_line;
    UIButton *_downLoadBtn;
    UIButton *_shareBtn;
    UIButton *_favouriteBtn;
}

-(void)setPhotoSetModel:(PhotoSetModel *)photoSetModel
{
    _photoSetModel = photoSetModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    [self createNavigationBar];
    [self createFooterButton];
}

-(void)createNavigationBar
{
    _backBtn = [Helper button:@"top_navigation_back@2x.png" highlightedImage:@"top_navigation_back_highlighted@2x.png" nightNormalImage:@"night_top_navigation_back@2x.png" nightHighlightedImage:@"night_top_navigation_back_highlighted@2x.png" target:self action:@selector(backBtn) tag:0 isNightMode:self.isNightMode];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(54, 44));
    }];
    
    _replyCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [self.replyCount sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _replyCountBtn.frame = CGRectMake([Helper screenWidth]-size.width-28, 20, size.width + 20, 40);
    _replyCountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_replyCountBtn setTitle:self.replyCount forState:UIControlStateNormal];
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
    _line = [Helper view:[UIColor grayColor] nightColor:[UIColor grayColor] isNightMode:self.isNightMode];
    [self.view addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-43.5);
        make.left.right.equalTo(self.view);
        make.height.offset(0.3);
    }];
    
    _favouriteBtn = [Helper button:@"night_icon_star@2x.png" highlightedImage:nil nightNormalImage:@"night_icon_star@2x.png" nightHighlightedImage:nil target:self action:@selector(addToFavotrite) tag:0 isNightMode:self.isNightMode];
    [self.view addSubview:_favouriteBtn];
    [_favouriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    _shareBtn = [Helper button:@"weather_share@2x.png" highlightedImage:@"weather_share_highlight@2x.png" nightNormalImage:@"weather_share@2x.png" nightHighlightedImage:@"weather_share_highlight@2x.png" target:self action:@selector(share) tag:0 isNightMode:self.isNightMode];
    [self.view addSubview:_shareBtn];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.right.equalTo(_favouriteBtn.mas_left).offset(-8);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    _downLoadBtn = [Helper button:@"" highlightedImage:@"" nightNormalImage:@"" nightHighlightedImage:@"" target:self action:@selector(downLoadImage) tag:0 isNightMode:self.isNightMode];
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
