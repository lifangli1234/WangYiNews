//
//  DiscoveryViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "DiscoveryViewController.h"

@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavigationBar];
}

-(void)createNavigationBar
{
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    
    UIView *IV = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [self.view addSubview:IV];
    [IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.offset(64);
    }];
    
    UILabel *titleLab = [Helper label:@"发现" font:TITLEFONT textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    [IV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IV).offset(20);
        make.centerX.equalTo(IV);
        make.height.offset(44);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
