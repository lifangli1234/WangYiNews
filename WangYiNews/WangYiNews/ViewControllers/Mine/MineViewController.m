//
//  MineViewController.m
//  News
//
//  Created by lifangli on 15/9/2.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "MineViewController.h"
#import "PreferenceViewController.h"
#import "LoginViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController
{
    UITableView *_myInfoListTableView;
    NSMutableArray *_myInfoList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    [self loadArr];
    [self crateTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadArr
{
    _myInfoList = [[NSMutableArray alloc] init];
    NSArray *nameArr = [[NSArray alloc] initWithObjects:@"我的消息",@"金币商城",@"金币任务",@"我的钱包",@"我的邮箱", nil];
    NSArray *imageArr = [[NSArray alloc] initWithObjects:@"user_set_icon_message@2x",@"user_set_icon_mall@2x",@"user_set_icon_mission@2x.png",@"user_set_icon_wallet@2x",@"user_set_icon_mail@2x", nil];
    for (int i=0; i<nameArr.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:nameArr[i] forKey:@"name"];
        [dic setValue:imageArr[i] forKey:@"image"];
        [_myInfoList addObject:dic];
    }
}

#pragma mark ------------------TableView-----------------
-(UIView *)createHeaderView
{
    UIView *headerView = [Helper view:[UIColor whiteColor] nightColor:[UIColor blackColor]];
    
    UIView *userHeader = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [headerView addSubview:userHeader];
    [userHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headerView);
        make.height.offset(225);
    }];
    
    UIButton *settingBtn = [Helper button:@"设置" textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:15] tag:0 target:self action:@selector(UserPreference)];
    [userHeader addSubview:settingBtn];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(userHeader).offset(-66);
        make.top.equalTo(userHeader).offset(25);
        make.size.sizeOffset(CGSizeMake(66, 25));
    }];
    
    UILabel *loginLabel = [Helper label:@"立即登录" font:[UIFont systemFontOfSize:18] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    [userHeader addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userHeader);
        make.height.offset(25);
        make.top.equalTo(userHeader).offset(138);
    }];
    
    UIButton *loginBtn = [Helper button:@"user_defaulthead@2x" target:self action:@selector(userLogin) tag:0];
        loginBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 12.5, 25, 12.5);
    [userHeader addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userHeader);
        make.size.sizeOffset(CGSizeMake(100, 100));
        make.top.equalTo(userHeader).offset(55);
    }];
    
    UILabel *coinLabel = [Helper label:@"赢金币抢大礼!" font:[UIFont systemFontOfSize:15] textColor:RGB(0.98, 0.93, 0.49) nightTextColor:RGB(0.90, 0.78, 0.43) textAligment:NSTextAlignmentCenter];
    [userHeader addSubview:coinLabel];
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userHeader);
        make.height.offset(25);
        make.top.equalTo(loginLabel.mas_bottom);
    }];
    
    UIView *bottomView = [Helper view:[UIColor whiteColor] nightColor:NIGHTBACKGROUNDCOLOR];
    [headerView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userHeader.mas_bottom);
        make.left.right.equalTo(headerView);
        make.bottom.equalTo(headerView).offset(-5);
    }];
    
    [self addButton:@"阅读" image:@"user_read_icon@2x" superView:bottomView index:0 count:4 tag:USERREAD_TAG];
    [self addButton:@"收藏" image:@"user_favor_icon@2x" superView:bottomView index:1 count:4 tag:USEFAVO_TAG];
    [self addButton:@"跟贴" image:@"user_comment_icon@2x" superView:bottomView index:2 count:4 tag:USECOMMENT_TAG];
    [self addButton:@"金币" image:@"user_coin_icon@2x" superView:bottomView index:3 count:4 tag:USECOIN_TAG];
    
    UIView *lineView = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
    lineView.layer.borderColor = [[UIColor grayColor] CGColor];
    lineView.layer.borderWidth = 0.5;
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headerView);
        make.height.offset(5);
    }];
    
    headerView.frame = CGRectMake(0, 0, [Helper screenWidth], 310);
    
    return headerView;
}

-(void)addButton:(NSString *)name image:(NSString *)imageName superView:(UIView *)superView index:(NSInteger)index count:(NSInteger)count tag:(NSInteger)tag
{
    CGFloat width = ([Helper screenWidth]-(count-1)*0.5)/count;
    
    UILabel *lab = [Helper label:name font:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    [superView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView);
        make.height.offset(26);
        make.width.offset(width);
        make.left.equalTo(superView).offset(width*index);
    }];
    
    UIButton *btn = [Helper button:imageName target:self action:@selector(userAction:) tag:tag];
    
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab);
        make.top.equalTo(superView);
        make.height.offset(85);
        make.width.equalTo(lab.mas_width);
    }];
    
    UIView *line = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
    [superView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn.mas_right);
        make.width.offset(0.5);
        make.top.bottom.equalTo(superView);
    }];
    
    switch (index) {
        case 0:
            btn.contentEdgeInsets = UIEdgeInsetsMake(21, (([Helper screenWidth]-(count*0.5))/count-40)/2, 46, (([Helper screenWidth]-(count*0.5))/count-40)/2);
            break;
        case 1:
            btn.contentEdgeInsets = UIEdgeInsetsMake(18, (([Helper screenWidth]-(count*0.5))/count-25)/2, 42, (([Helper screenWidth]-(count*0.5))/count-25)/2);
            break;
        case 2:
            btn.contentEdgeInsets = UIEdgeInsetsMake(19, (([Helper screenWidth]-(count*0.5))/count-22)/2, 43, (([Helper screenWidth]-(count*0.5))/count-22)/2);
            break;
        case 3:
            btn.contentEdgeInsets = UIEdgeInsetsMake(19, (([Helper screenWidth]-(count*0.5))/count-29)/2, 44, (([Helper screenWidth]-(count*0.5))/count-29)/2);
            break;
        default:
            break;
    }
}

-(void)crateTableView
{
    _myInfoListTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _myInfoListTableView.dataSource = self;
    _myInfoListTableView.delegate = self;
    _myInfoListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myInfoListTableView.tableHeaderView = [self createHeaderView];
    [self.view addSubview:_myInfoListTableView];
}

#pragma mark ----------------TableViewDelegate------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myInfoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.contentView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    UIImageView *img = [Helper imageView:[_myInfoList[indexPath.row] objectForKey:@"image"]];
    [cell.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset(12);
        make.left.equalTo(cell.contentView).offset(10);
        make.size.sizeOffset(CGSizeMake(20, 20));
    }];
    
    UILabel *lab = [Helper label:[_myInfoList[indexPath.row] objectForKey:@"name"] font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft];
    [cell.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView);
        make.height.offset(44);
        make.left.equalTo(img.mas_left).offset(14);
    }];
    
    UIImageView *enterImg = [Helper imageView:@"lm_cell_detail_indicator@2x"];
    [cell.contentView addSubview:enterImg];
    [enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset(15);
        make.right.equalTo(cell.contentView).offset(-17.5);
        make.size.sizeOffset(CGSizeMake(7.5, 14));
    }];

    if (indexPath.row == 0 || indexPath.row == 3) {
        UIView *lineView = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
        lineView.layer.borderColor = [[UIColor grayColor] CGColor];
        lineView.layer.borderWidth = 0.5;
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell.contentView);
            make.height.offset(5);
        }];
    }
    else{
        UIView *lineView = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell.contentView);
            make.height.offset(0.5);
        }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 3) {
        return 49.0f;
    }
    else{
        return 44.5f;
    }
}

#pragma mark -----------------buttonAction--------------
-(void)userLogin
{
    [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}

-(void)UserPreference
{
    [self.navigationController pushViewController:[[PreferenceViewController alloc] init] animated:YES];
}

-(void)userAction:(UIButton *)btn
{}

@end
