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
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadArr];
    //[self createHeaderView];
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
    NSArray *imageArr = [[NSArray alloc] initWithObjects:@"user_set_icon_message@2x.png",@"user_set_icon_mall@2x.png",@"user_set_icon_mission@2x.png",@"user_set_icon_wallet@2x.png",@"user_set_icon_mail@2x.png", nil];
    for (int i=0; i<nameArr.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:nameArr[i] forKey:@"name"];
        [dic setValue:imageArr[i] forKey:@"image"];
        [_myInfoList addObject:dic];
    }
}

#pragma mark ------------------TableView-----------------
/*-(void)createHeaderView
{
    UIView *headerView = [Helper view:CGRectMake(0, 0, [Helper screenWidth], 345) backgroundColor:[UIColor whiteColor]];
    
    UIView *userHeader = [Helper view:CGRectMake(0, 0, [Helper screenWidth], 255) backgroundColor:BASERED];
    [headerView addSubview:userHeader];
    
    [userHeader addSubview:[Helper button:@"设置" normalImage:nil highlightedImage:nil frame:CGRectMake([Helper screenWidth]-66, 25, 66, 25) target:self action:@selector(UserPreference) textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:15] tag:0]];
    [userHeader addSubview:[Helper label:@"立即登录" frame:CGRectMake(([Helper screenWidth]-120)/2, 138, 120, 25) font:[UIFont systemFontOfSize:18] textColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter]];
    UIButton *loginBtn = [Helper button:nil normalImage:@"user_defaulthead@2x.png" highlightedImage:nil frame:CGRectMake(([Helper screenWidth]-100)/2, 55, 100, 100) target:self action:@selector(userLogin) textColor:nil textFont:nil tag:0];
    loginBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 12.5, 25, 12.5);
    [userHeader addSubview:loginBtn];
    [userHeader addSubview:[Helper label:@"赢金币抢大礼!" frame:CGRectMake(([Helper screenWidth]-120)/2, 161, 120, 25) font:[UIFont systemFontOfSize:15] textColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:30.0/255.0 alpha:1.0] textAligment:NSTextAlignmentCenter]];
    
    UIView *bottomView = [Helper view:CGRectMake(0, 255, [Helper screenWidth], 85) backgroundColor:[UIColor whiteColor]];
    [headerView addSubview:bottomView];
    
    [bottomView addSubview:[Helper label:@"阅读" frame:CGRectMake(0, 46, ([Helper screenWidth]-1.5)/4, 26) font:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor] textAligment:NSTextAlignmentCenter]];
    UIButton *userReadBtn = [Helper button:nil normalImage:@"user_read_icon@2x.png" highlightedImage:nil frame:CGRectMake(0, 0, ([Helper screenWidth]-1.5)/4, 85) target:self action:@selector(userAction:) textColor:nil textFont:nil tag:USERREAD_TAG];
    userReadBtn.contentEdgeInsets = UIEdgeInsetsMake(21, (([Helper screenWidth]-1.5)/4-40)/2, 46, (([Helper screenWidth]-1.5)/4-40)/2);
    [bottomView addSubview:userReadBtn];
    [bottomView addSubview:[Helper view:CGRectMake(([Helper screenWidth]-1.5)/4, 0, 0.5, 85) backgroundColor:LINECOLOR]];
    
    [bottomView addSubview:[Helper label:@"收藏" frame:CGRectMake(([Helper screenWidth]-1.5)/4+0.5, 46, ([Helper screenWidth]-1.5)/4, 26) font:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor] textAligment:NSTextAlignmentCenter]];
    UIButton *userFavoBtn = [Helper button:nil normalImage:@"user_favor_icon@2x.png" highlightedImage:nil frame:CGRectMake(([Helper screenWidth]-1.5)/4+0.5, 0, ([Helper screenWidth]-1.5)/4, 85) target:self action:@selector(userAction:) textColor:nil textFont:nil tag:USEFAVO_TAG];
    userFavoBtn.contentEdgeInsets = UIEdgeInsetsMake(18, (([Helper screenWidth]-1.5)/4-25)/2, 42, (([Helper screenWidth]-1.5)/4-25)/2);
    [bottomView addSubview:userFavoBtn];
    [bottomView addSubview:[Helper view:CGRectMake(([Helper screenWidth]-1.5)/2+0.5, 0, 0.5, 85) backgroundColor:LINECOLOR]];
    
    [bottomView addSubview:[Helper label:@"跟贴" frame:CGRectMake(([Helper screenWidth]-1.5)/2+0.5, 46, ([Helper screenWidth]-1.5)/4, 26) font:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor] textAligment:NSTextAlignmentCenter]];
    UIButton *userCommentBtn = [Helper button:nil normalImage:@"user_comment_icon@2x.png" highlightedImage:nil frame:CGRectMake(([Helper screenWidth]-1.5)/2+0.5, 0, ([Helper screenWidth]-1.5)/4, 85) target:self action:@selector(userAction:) textColor:nil textFont:nil tag:USECOMMENT_TAG];
    userCommentBtn.contentEdgeInsets = UIEdgeInsetsMake(19, (([Helper screenWidth]-1.5)/4-22)/2, 43, (([Helper screenWidth]-1.5)/4-22)/2);
    [bottomView addSubview:userCommentBtn];
    [bottomView addSubview:[Helper view:CGRectMake(([Helper screenWidth]-1.5)/4*3+1, 0, 0.5, 85) backgroundColor:LINECOLOR]];
    
    [bottomView addSubview:[Helper label:@"金币" frame:CGRectMake(([Helper screenWidth]-1.5)/4*3+1, 46, ([Helper screenWidth]-1.5)/4, 26) font:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor] textAligment:NSTextAlignmentCenter]];
    UIButton *userCoinBtn = [Helper button:nil normalImage:@"user_coin_icon@2x.png" highlightedImage:nil frame:CGRectMake(([Helper screenWidth]-1.5)/4*3+1, 0, ([Helper screenWidth]-1.5)/4, 85) target:self action:@selector(userAction:) textColor:nil textFont:nil tag:USECOIN_TAG];
    userCoinBtn.contentEdgeInsets = UIEdgeInsetsMake(19, (([Helper screenWidth]-1.5)/4-29)/2, 44, (([Helper screenWidth]-1.5)/4-29)/2);
    [bottomView addSubview:userCoinBtn];
    
    UIView *lineView = [Helper view:CGRectMake(0, 340, [Helper screenWidth], 5) backgroundColor:GRAYCOLOR];
    lineView.layer.borderColor = [LINECOLOR CGColor];
    lineView.layer.borderWidth = 0.5;
    [headerView addSubview:lineView];
    
    [self.view addSubview:headerView];
}*/

-(void)crateTableView
{
    _myInfoListTableView = [[UITableView alloc] init];
    _myInfoListTableView.frame = CGRectMake(0, 345, [Helper screenWidth], [Helper screenHeight]-345);
    _myInfoListTableView.dataSource = self;
    _myInfoListTableView.delegate = self;
    _myInfoListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myInfoListTableView.scrollEnabled = NO;
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
//    [cell.contentView addSubview:[Helper imageView:CGRectMake(10, 12, 20, 20) name:[_myInfoList[indexPath.row] objectForKey:@"image"]]];
//    [cell.contentView addSubview:[Helper label:[_myInfoList[indexPath.row] objectForKey:@"name"] frame:CGRectMake(44, 0, 200, 44) font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] textAligment:NSTextAlignmentLeft]];
//    [cell.contentView addSubview:[Helper imageView:CGRectMake([Helper screenWidth]-17.5, 15, 7.5, 14) name:@"lm_cell_detail_indicator@2x.png"]];
//    if (indexPath.row == 0 || indexPath.row == 3) {
//        UIView *lineView = [Helper view:CGRectMake(0, 44, [Helper screenWidth], 5) backgroundColor:GRAYCOLOR];
//        lineView.layer.borderColor = [LINECOLOR CGColor];
//        lineView.layer.borderWidth = 0.5;
//        [cell.contentView addSubview:lineView];
//    }
//    else{
//        [cell.contentView addSubview:[Helper view:CGRectMake(0, 44, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
//    }
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
