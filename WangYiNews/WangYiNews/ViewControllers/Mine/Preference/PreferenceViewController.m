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
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[[Helper alloc] init] createNavigationBarWithSuperView:self.view andTitle:@"设置" andTarget:self andSel:@selector(preferenceBack)];
    [self createTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadPreferenceList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPreferenceList
{
    _preferenceList = [[NSMutableArray alloc] init];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"个人设置",@"绑定其他平台",@"字体设置",@"正文字号",@"头条智能排序",@"推送设置",@"栏目插件设置",@"离线设置",@"仅Wi-Fi网络下载图片",@"清理缓存",@"帮助与反馈",@"为网易新闻评分",@"态度封面",@"关于", nil];
    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:@"为网易新闻评分",@"态度封面",@"关于", nil];
    [_preferenceList addObject:arr];
    [_preferenceList addObject:arr1];
}

-(void)createTableView
{
    _preferenceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [Helper screenWidth], [Helper screenHeight]-64)];
    _preferenceTableView.backgroundColor = GRAYCOLOR;
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
    }
    UILabel *contentLab = [Helper label:[[_preferenceList objectAtIndex:0] objectAtIndex:indexPath.row] frame:CGRectMake(10, 0, [Helper screenWidth]-160, 44) font:[UIFont systemFontOfSize:15] textColor:[UIColor darkGrayColor] textAligment:NSTextAlignmentLeft];
    [cell.contentView addSubview:contentLab];
    if (indexPath.row == 0) {
        contentLab.frame = CGRectMake(10, 10, [Helper screenWidth]-160, 44);
        [cell.contentView addSubview:[Helper view:CGRectMake(0, 0, [Helper screenWidth], 10) backgroundColor:GRAYCOLOR]];
        [cell.contentView addSubview:[Helper view:CGRectMake(0, 9.5, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
        [cell.contentView addSubview:[Helper view:CGRectMake(0, 53.5, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
    }
    else if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 9) {
        UIView *lineView = [Helper view:CGRectMake(0, 44, [Helper screenWidth], 10) backgroundColor:GRAYCOLOR];
        lineView.layer.borderWidth = 0.5;
        lineView.layer.borderColor = [LINECOLOR CGColor];
        [cell.contentView addSubview:lineView];
    }
    else{
        [cell.contentView addSubview:[Helper view:CGRectMake(0, 43.5, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
        if (indexPath.row == [[_preferenceList objectAtIndex:0] count]-1){
            [cell.contentView addSubview:[Helper view:CGRectMake(0, 44, [Helper screenWidth], 10) backgroundColor:GRAYCOLOR]];
        }
    }
    if (indexPath.row == 8 || indexPath.row == 4) {
        
    }
    else if(indexPath.row == 9){
        
    }
    else{
        if (indexPath.row == 2 || indexPath.row == 3) {
            
        }
        UIImageView *enterImg = [Helper imageView:CGRectMake([Helper screenWidth]-17.5, 15, 7.5, 14) name:@"lm_cell_detail_indicator@2x.png"];
        [cell.contentView addSubview:enterImg];
        if (indexPath.row == 0) {
            enterImg.frame = CGRectMake([Helper screenWidth]-21.5, 25, 7.5, 14);
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ||indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 9 ||indexPath.row == [[_preferenceList objectAtIndex:0] count]-1) {
        return 54.0f;
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
