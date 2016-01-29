//
//  WebViewViewController.m
//  WangYiNews
//
//  Created by lifangli on 16/1/29.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController
{
    UIWebView *_web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigationBar];
    [self loadWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNavigationBar
{
    UIButton *backBtn = [Helper button:@"icon_back@2x" target:self action:@selector(backBtn) tag:0];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(54, 44));
    }];
    
    UIButton *replyCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [[NSString stringWithFormat:@"%@跟帖",_newsModel.replyCount] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    replyCountBtn.frame = CGRectMake([Helper screenWidth]-size.width-28, 20, size.width + 20, 40);
    replyCountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [replyCountBtn setTitle:[NSString stringWithFormat:@"%@跟帖",_newsModel.replyCount] forState:UIControlStateNormal];
    [replyCountBtn needsUpdateConstraints];
    UIImage *normalImg = [UIImage imageNamed:@"contentview_commentbacky"];
    UIImage *highlightedImg = [UIImage imageNamed:@"contentview_commentbacky_selected"];
    CGFloat normalW = normalImg.size.width;
    CGFloat normalH = normalImg.size.height;
    CGFloat highW = highlightedImg.size.width;
    CGFloat highH = highlightedImg.size.height;
    normalImg = [normalImg resizableImageWithCapInsets:UIEdgeInsetsMake(normalH * 0.5, normalW * 0.5, normalH * 0.5, normalW * 0.5)];
    highlightedImg = [highlightedImg resizableImageWithCapInsets:UIEdgeInsetsMake(highH * 0.5, highW * 0.5, highH * 0.5, highW * 0.5)];
    [replyCountBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [replyCountBtn setBackgroundImage:highlightedImg forState:UIControlStateHighlighted];
    replyCountBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 15);
    [self.view addSubview:replyCountBtn];
    
    UIView *line = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(63);
        make.height.offset(1);
    }];
}

-(void)loadWebView
{
    _web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [Helper screenWidth], [Helper screenHeight]-64)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsModel.url_3w]];
    [_web loadRequest:request];
    [self.view addSubview:_web];
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
