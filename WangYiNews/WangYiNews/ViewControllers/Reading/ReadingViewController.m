//
//  ReadingViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "ReadingViewController.h"

@interface ReadingViewController ()

@end

@implementation ReadingViewController
{
    UIButton *_recommendedBtn;
    UIButton *_orderedBtn;
    UIView *_btnBackView;
    UIView *segmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavigation];
}

-(void)createNavigation
{
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    
    UIView *navView = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.offset(64);
    }];
    
    UIButton *readPlusBtn = [Helper button:@"top_navigation_readerplus@2x" target:self action:@selector(readPlus) tag:0];
    [navView addSubview:readPlusBtn];
    [readPlusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView).offset(27);
        make.size.sizeOffset(CGSizeMake(30, 30));
        make.right.equalTo(navView).offset(-14);
    }];
    
    segmentView = [Helper view:[UIColor clearColor] nightColor:[UIColor clearColor]];
    segmentView.layer.borderColor = [UIColor whiteColor].CGColor;
    segmentView.layer.borderWidth = 0.5;
    segmentView.layer.cornerRadius = 15;
    [navView addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView).offset(27);
        make.size.sizeOffset(CGSizeMake(200, 30));
        make.centerX.equalTo(navView);
    }];
    
    _btnBackView = [Helper view:[UIColor whiteColor] nightColor:[UIColor whiteColor]];
    _btnBackView.layer.cornerRadius = 15;
    [segmentView addSubview:_btnBackView];
    [_btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(segmentView);
        make.width.offset(100);
    }];
    
    _recommendedBtn = [Helper button:@"推荐阅读" textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:17] tag:RECOMMENGREADING_TAG target:self action:@selector(readingPageBtn:)];
    _recommendedBtn.layer.cornerRadius = 15;
    _recommendedBtn.selected = YES;
    [_recommendedBtn dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateSelected];
    [segmentView addSubview: _recommendedBtn];
    [_recommendedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(segmentView);
        make.width.offset(100);
    }];
    
    _orderedBtn = [Helper button:@"我的订阅" textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:17] tag:MYSUBSCRIBE_TAG target:self action:@selector(readingPageBtn:)];
    _orderedBtn.layer.cornerRadius = 15;
    [_orderedBtn dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateSelected];
    [segmentView addSubview: _orderedBtn];
    [_orderedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(segmentView);
        make.width.offset(100);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----------------btnAction------------
-(void)readingPageBtn:(UIButton *)btn
{
    if (btn.tag == RECOMMENGREADING_TAG) {
        btn.selected = YES;
        _orderedBtn.selected = NO;
        [_btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(segmentView);
        }];
        [_btnBackView layoutIfNeeded];
    }
    else if(btn.tag == MYSUBSCRIBE_TAG){
        btn.selected = YES;
        _recommendedBtn.selected = NO;
        [_btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(segmentView).offset(100);
        }];
        [_btnBackView layoutIfNeeded];
    }
    else{
        
    }
}

-(void)readPlus
{}

@end
