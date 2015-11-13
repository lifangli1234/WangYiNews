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
    
    [self createTabBar];
}

-(void)createTabBar
{
    CGFloat tabBarViewY = self.view.frame.size.height - 49;
    
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, tabBarViewY, self.view.frame.size.width, 49)];
    _tabBarView.backgroundColor = [UIColor whiteColor];
    _tabBarView.layer.borderColor = [[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0] CGColor];
    _tabBarView.layer.borderWidth = 0.5;
    [self.view addSubview:_tabBarView];
    
    [self creatButtonWithNormalName:@"tabbar_icon_news_normal@2x.png" andSelectName:@"tabbar_icon_news_highlight@2x.png" andTitle:@"新闻" andIndex:0];
    [self creatButtonWithNormalName:@"tabbar_icon_reader_normal@2x.png" andSelectName:@"tabbar_icon_reader_highlight@2x.png" andTitle:@"阅读" andIndex:1];
    [self creatButtonWithNormalName:@"tabbar_icon_media_normal@2x.png" andSelectName:@"tabbar_icon_media_highlight@2x.png" andTitle:@"视听" andIndex:2];
    [self creatButtonWithNormalName:@"tabbar_icon_found_normal@2x.png" andSelectName:@"tabbar_icon_found_highlight@2x.png" andTitle:@"发现" andIndex:3];
    [self creatButtonWithNormalName:@"tabbar_icon_me_normal@2x.png" andSelectName:@"tabbar_icon_me_highlight@2x.png" andTitle:@"我" andIndex:4];
}

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    CGFloat customBtnW = _tabBarView.frame.size.width/5;
    CGFloat customBtnH = _tabBarView.frame.size.height;
    CGFloat customBtnX = customBtnW*index;
    
    UILabel *lab = [Helper label:title frame:CGRectMake(customBtnX, 24, customBtnW, 25) font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter];
    lab.tag = index;
    [_tabBarView addSubview:lab];

    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(customBtnX, 0, customBtnW, customBtnH);
    customBtn.tag = index;
    [customBtn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
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
            customBtn.contentEdgeInsets = UIEdgeInsetsMake(5.5, (customBtnW-16)/2, 22.5, (customBtnW-16)/2);
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
                ((UILabel *)subview).textColor = [UIColor grayColor];
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
