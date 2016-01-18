//
//  PreferenceViewController.m
//  News
//
//  Created by lifangli on 15/9/6.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "PreferenceViewController.h"

@interface PreferenceViewController ()

@end

@implementation PreferenceViewController
{
    UITableView *_preferenceTableView;
    NSMutableArray *_preferenceList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
    [self createNavigationBar];
    [self createTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadPreferenceList];
}

-(void)createNavigationBar
{
    UIView *nav = [Helper createNavigationBarWithTitle:@"登录网易新闻" andTarget:self andSel:@selector(preferenceBack)];
    [self.view addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(64);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPreferenceList
{
    _preferenceList = [[NSMutableArray alloc] init];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"个人设置",@"绑定其他平台",@"字体设置",@"正文字号",@"夜间模式",@"自动设置夜间模式",@"推送设置",@"栏目插件设置",@"离线设置",@"智能头条",@"仅Wi-Fi网络下载图片",@"清理缓存",@"帮助与反馈",@"为网易新闻评分",@"态度封面",@"关于", nil];
    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:@"",@"",@"汉仪旗黑",@"中",@"",@"",@"",@"",@"",@"",@"",@"14.8 MB",@"",@"",@"",@"", nil];
    [_preferenceList addObject:arr];
    [_preferenceList addObject:arr1];
}

-(void)createTableView
{
    _preferenceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 79, [Helper screenWidth], [Helper screenHeight]-94)];
    _preferenceTableView.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
    _preferenceTableView.delegate = self;
    _preferenceTableView.dataSource = self;
    _preferenceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_preferenceTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_preferenceList objectAtIndex:0] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        UILabel *contentLab = [Helper label:[[_preferenceList objectAtIndex:0] objectAtIndex:indexPath.row] font:[UIFont systemFontOfSize:15] textColor:[UIColor darkGrayColor] nightTextColor:[UIColor grayColor] textAligment:NSTextAlignmentLeft];
        [cell addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(10);
            make.top.equalTo(cell);
            make.height.equalTo(@44);
        }];
    }
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 11) {
        UIView *lineView = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
        lineView.layer.borderWidth = 0.8;
        lineView.layer.borderColor = [GRAYCOLOR CGColor];
        [cell addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(-1);
            make.right.equalTo(cell).offset(1);
            make.bottom.equalTo(cell);
            make.height.equalTo(@15);
        }];
    }
    else{
        UIView *lineView = [Helper view:GRAYCOLOR nightColor:GRAYCOLOR];
        [cell addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell);
            make.right.equalTo(cell);
            make.bottom.equalTo(cell);
            make.height.equalTo(@0.8);
        }];
    }
    if (indexPath.row == 5 || indexPath.row == 4 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11) {
        if (indexPath.row == 11) {
            UILabel *contentLab = [Helper label:[[_preferenceList objectAtIndex:1] objectAtIndex:indexPath.row] font:[UIFont systemFontOfSize:16] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentRight];
            [cell addSubview:contentLab];
            [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).offset(-27.5);
                make.top.equalTo(cell);
                make.height.equalTo(@44);
            }];
        }
        else{
            
        }
    }
    else{
        if (indexPath.row == 2 || indexPath.row == 3) {
            UILabel *contentLab = [Helper label:[[_preferenceList objectAtIndex:1] objectAtIndex:indexPath.row] font:[UIFont systemFontOfSize:16] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentRight];
            [cell addSubview:contentLab];
            [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).offset(-27.5);
                make.top.equalTo(cell);
                make.height.equalTo(@44);
            }];
        }
        UIImageView *enterImg = [Helper imageView:@"lm_cell_detail_indicator@2x.png"];
        [cell addSubview:enterImg];
        [enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(15);
            make.right.equalTo(cell).offset(-10);
            make.size.sizeOffset(CGSizeMake(7.5, 14));
        }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 11) {
        return 59.0f;
    }
    else{
        return 44.0f;
    }
}

-(void)preferenceBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
