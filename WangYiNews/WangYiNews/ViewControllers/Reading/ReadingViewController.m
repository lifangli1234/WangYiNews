//
//  ReadingViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "ReadingViewController.h"
#import "ReadingCell.h"
#import "ReadingModel.h"
#import "LoginViewController.h"
#import "RecommendSubscribeViewController.h"
#import "AddSubscribeViewController.h"

@interface ReadingViewController ()

@end

@implementation ReadingViewController
{
    NSMutableArray *_listArr;
    BOOL isTableView1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _listArr = [[NSMutableArray alloc] init];
    isTableView1 = YES;
    [self.tableView1 addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView1 headerBeginRefreshing];
    self.tableView1.tableHeaderView = [self tableViewHeaderViewWithStr:@"获取更合口味的推荐"];
    self.tableView2.tableHeaderView = [self tableViewHeaderViewWithStr:@"同步多平台订阅内容"];
    self.tableView2.tableFooterView = [self tableViewFooterView];
}

-(void)initData
{
    [self setSegLStr:@"推荐阅读"];
    [self setSegRStr:@"我的订阅"];
}

-(void)loadNavigationBar
{
    self.naviLeftBtn.hidden = YES;
    SetButtonImage(self.naviRightBtn, @"top_navigation_readerplus@2x");
    [self.naviRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(27);
        make.size.sizeOffset(CGSizeMake(30, 30));
        make.right.equalTo(self.view).offset(-14);
    }];
}

-(void)loadData
{
    [self loadDataWithType:1 url:@"/recommend/getSubDocPic?from=yuedu&passport=&devId=4R70nVFo7N%2FjOGAl7Dql%2BgnhtyYRtyVIqBeGB12xtfEEIz0ZpgPoDMhS%2FpBn8zvR&size=20&version=5.5.1&spever=false&net=wifi&lat=8w3kFMWQUCWruG3di%2B0NGQ%3D%3D&lon=f1s7UDFEOarrXVFIH%2Bi3qw%3D%3D&ts=1453448295&sign=FQ9Dp9hpTQUKK3cxdmP5PxKOB1hsrOPbyUJp63eEoZF48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore" tableView:self.tableView1];
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url tableView:(UITableView *)tableView
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        [self.tableView1 headerEndRefreshing];
        [_listArr removeAllObjects];
        [_listArr addObjectsFromArray:[responseObject objectForKey:@"推荐"]];
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [tableView headerEndRefreshing];
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)tableViewHeaderViewWithStr:(NSString *)str
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Helper screenWidth], 105)];
    
    UIButton *login = [Helper button:@"立即登录" textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:17] tag:0 target:self action:@selector(login)];
    login.backgroundColor = [UIColor whiteColor];
    login.layer.borderColor = GRAYCOLOR.CGColor;
    login.layer.borderWidth = 0.5;
    [headerView addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(40);
        make.right.equalTo(headerView).offset(-40);
        make.top.equalTo(headerView).offset(25);
        make.height.offset(40);
    }];
    
    UILabel *label = [Helper label:str font:[UIFont systemFontOfSize:14] textColor:[UIColor lightGrayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(login.mas_bottom).offset(8);
        make.centerX.equalTo(headerView);
        make.height.offset(25);
    }];
    
    UIView *line = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headerView);
        make.height.offset(0.8);
    }];
    
    return  headerView;
}

-(UIView *)tableViewFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Helper screenWidth], 255)];
    
    UIImageView *img = [Helper imageView:@"reader_myreader_blank@2x"];
    [footerView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView).offset(5);
        make.centerX.equalTo(footerView);
        make.size.sizeOffset(CGSizeMake(225, 195));
    }];
    
    UILabel *label = [Helper label:@"" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"寻找我感兴趣的订阅栏目"];
    NSString *attrStr = @"订阅栏目";
    [str addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.0 green:105.0/255.0 blue:210.0/255.0 alpha:1.0]} range:NSMakeRange(str.length-attrStr.length, attrStr.length)];
    label.attributedText = str;
    [footerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom);
        make.centerX.equalTo(footerView).offset(-15.5/2);
        make.height.offset(25);
    }];
    
    UIImageView *enterImg = [Helper imageView:@"lm_cell_detail_indicator@2x"];
    [footerView addSubview:enterImg];
    [enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.left.equalTo(label.mas_right).offset(8);
        make.size.sizeOffset(CGSizeMake(7.5, 14));
    }];
    
    return  footerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView1){
        return _listArr.count;
    }
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    
    if (tableView == self.tableView1){
        ReadingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReadingCell" owner:self options:nil] lastObject];
        }
        
        NSDictionary *dic = [_listArr objectAtIndex:indexPath.row];
        ReadingModel *rm = [ReadingModel objectWithKeyValues:dic];
        [cell setRm:rm];
        
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        UIImageView *img = [Helper imageView:@"reader_recommend_icon@2x"];
        [cell addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(cell).offset(10);
            make.size.sizeOffset(CGSizeMake(50.5, 50));
        }];
        
        UILabel *lab = [Helper label:@"今日订阅推荐" font:[UIFont systemFontOfSize:20] textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft];
        [cell addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(img.mas_right).offset(8);
            make.centerY.equalTo(cell).offset(-5);
            make.height.offset(70);
        }];
        
        UIImageView *enterImg = [Helper imageView:@"lm_cell_detail_indicator@2x"];
        [cell addSubview:enterImg];
        [enterImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell).offset(-5);
            make.right.equalTo(cell).offset(-17.5);
            make.size.sizeOffset(CGSizeMake(7.5, 14));
        }];
        
        UIView *line = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell);
            make.height.offset(5);
        }];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView2) {
        [self.navigationController pushViewController:[[RecommendSubscribeViewController alloc] init] animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        NSDictionary *dic = [_listArr objectAtIndex:indexPath.row];
        ReadingModel *rm = [ReadingModel objectWithKeyValues:dic];
        CGSize titleSize = [rm.title boundingRectWithSize:CGSizeMake([Helper screenWidth]-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        if (rm.recReason) {
            if ([rm.template isEqualToString:@"normal"]) {
                if (rm.imgsrc == nil || [rm.imgsrc isEqualToString:@""]) {
                    return 74+titleSize.height;
                }
                else
                    return 154;
            }
            else if ([rm.template isEqualToString:@"pic31"] || [rm.template isEqualToString:@"pic32"]){
                return 267+titleSize.height;
            }
            else {
                return 262+titleSize.height;
            }
        }
        else {
            if ([rm.template isEqualToString:@"normal"]) {
                if (rm.imgsrc == nil || [rm.imgsrc isEqualToString:@""]) {
                    return 50+titleSize.height;
                }
                else
                    return 130;
            }
            else if ([rm.template isEqualToString:@"pic31"] || [rm.template isEqualToString:@"pic32"]){
                return 241+titleSize.height;
            }
            else {
                return 236+titleSize.height;
            }
        }
    }
    else
        return 75;
}

#pragma mark----------------scrollViewDelegate------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/[Helper screenWidth];
    switch (index) {
        case 0:
        {
            self.segmentView.firstButton.selected = YES;
            self.segmentView.secondButton.selected = NO;
            [self.segmentView.btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.segmentView).offset(0);
            }];
            [self.segmentView.btnBackView layoutIfNeeded];
        }
            break;
        case 1:
        {
            self.segmentView.firstButton.selected = NO;
            self.segmentView.secondButton.selected = YES;
            [self.segmentView.btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.segmentView).offset(120);
            }];
            [self.segmentView.btnBackView layoutIfNeeded];
        }
            break;
        default:
            break;
    }
}

#pragma mark----------------btnAction------------
-(void)navigationRightBtnClick
{
    [self.navigationController pushViewController:[[AddSubscribeViewController alloc] init] animated:YES];
}

-(void)login
{
    [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}

-(void)segmentViewFirstBtnClick:(SegmentView *)segmentView
{
    self.contentScr.contentOffset = CGPointMake(0, 0);
}

-(void)segmentViewSecondBtnClick:(SegmentView *)segmentView
{
    self.contentScr.contentOffset = CGPointMake([Helper screenWidth], 0);
    //[self.tableView2 headerBeginRefreshing];
}

@end
