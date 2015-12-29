//
//  TabBarViewController.m
//  SecondHandCar
//
//  Created by lifangli on 15/8/17.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "TabBarViewController.h"
#import "CustomButton.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController
{
    UIView *_tabBarView;
    UIButton *_customButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self createTabBar];
}

-(void)createTabBar
{
    _tabBarView = [[UIView alloc] init];
    _tabBarView.dk_backgroundColorPicker = DKColorWithColors(DAYBACKGROUNDCOLOR, NIGHTBACKGROUNDCOLOR);
    _tabBarView.layer.borderColor = [Helper isNightMode]?[NIGHTLINECOLOR CGColor]:[LINECOLOR CGColor];
    _tabBarView.layer.borderWidth = 0.5;
    [self.view addSubview:_tabBarView];
    
    [_tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.mas_equalTo(self.view);
        make.height.offset(49);
    }];
    
    [self creatButton:@"tabbar_icon_news_normal@2x.png" select:@"tabbar_icon_news_highlight@2x.png" nightNormal:@"night_tabbar_icon_news_normal@2x.png" nightSelected:@"night_tabbar_icon_news_highlight@2x.png" title:@"新闻" index:0];
    [self creatButton:@"tabbar_icon_reader_normal@2x.png" select:@"tabbar_icon_reader_highlight@2x.png" nightNormal:@"night_tabbar_icon_reader_normal@2x.png" nightSelected:@"night_tabbar_icon_reader_highlight@2x.png" title:@"阅读" index:1];
    [self creatButton:@"tabbar_icon_media_normal@2x.png" select:@"tabbar_icon_media_highlight@2x.png" nightNormal:@"night_tabbar_icon_media_normal@2x.png" nightSelected:@"night_tabbar_icon_media_highlight@2x.png" title:@"视听" index:2];
    [self creatButton:@"tabbar_icon_bar_normal@2x.png" select:@"tabbar_icon_bar_highlight@2x.png" nightNormal:@"night_tabbar_icon_bar_normal@2x.png" nightSelected:@"night_tabbar_icon_bar_highlight@2x.png" title:@"话题" index:3];
    [self creatButton:@"tabbar_icon_me_normal@2x.png" select:@"tabbar_icon_me_highlight@2x.png" nightNormal:@"night_tabbar_icon_me_normal@2x.png" nightSelected:@"night_tabbar_icon_me_highlight@2x.png" title:@"我" index:4];
}

- (void)creatButton:(NSString *)normal select:(NSString *)selected nightNormal:(NSString *)nightNormal nightSelected:(NSString *)nightSelected title:(NSString *)title index:(int)index
{
    CGFloat customBtnW = [Helper screenWidth]/5;
    CGFloat customBtnH = 49;
    CGFloat customBtnX = customBtnW*index;
    
    UILabel *lab = [Helper label:title font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    lab.frame = CGRectMake(customBtnX, 24, customBtnW, 25);
    lab.tag = index;
    [_tabBarView addSubview:lab];

    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(customBtnX, 0, customBtnW, customBtnH);
    customBtn.tag = index;
    [customBtn setImage:[UIImage imageNamed:[Helper isNightMode]?nightNormal:normal] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:[Helper isNightMode]?nightSelected:selected] forState:UIControlStateDisabled];
    [customBtn addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    switch (index) {
        case 0:{
            customBtn.contentEdgeInsets = UIEdgeInsetsMake(8, (customBtnW-21)/2, 25, (customBtnW-21)/2);
            [self changeViewController:customBtn];
        }
            break;
        case 1:
            customBtn.contentEdgeInsets = UIEdgeInsetsMake(7, (customBtnW-20)/2, 24, (customBtnW-20)/2);
            break;
        case 2:
            customBtn.contentEdgeInsets = UIEdgeInsetsMake(6.5, (customBtnW-19)/2, 23.5, (customBtnW-19)/2);
            break;
        case 3:
            customBtn.contentEdgeInsets = UIEdgeInsetsMake(5.5, (customBtnW-18)/2, 22.5, (customBtnW-18)/2);
            break;
        case 4:
            customBtn.contentEdgeInsets = UIEdgeInsetsMake(6.5, (customBtnW-19)/2, 23.5, (customBtnW-19)/2);
            break;
        default:
            break;
    }
    [_tabBarView addSubview:customBtn];
}

-(void)changeViewController:(UIButton *)btn
{
    for (UIView *subview in _tabBarView.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            if (btn.tag == subview.tag) {
                ((UILabel *)subview).textColor = BASERED;
            }
            else{
                ((UILabel *)subview).textColor = [Helper isNightMode]?[UIColor lightGrayColor]:[UIColor grayColor];
            }
        }
    }
    self.selectedIndex = btn.tag;
    btn.enabled = NO;
    if (_customButton != btn) {
        _customButton.enabled = YES;
    }
    _customButton = btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
