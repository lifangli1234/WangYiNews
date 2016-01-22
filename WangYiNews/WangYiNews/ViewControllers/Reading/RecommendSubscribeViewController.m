//
//  RecommendSubscribeViewController.m
//  WangYiNews
//
//  Created by lifangli on 16/1/22.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "RecommendSubscribeViewController.h"
#import "RecommendedSubscribeCell.h"
#import "RecommendedSubscribeModel.h"

@interface RecommendSubscribeViewController ()

@end

@implementation RecommendSubscribeViewController
{
    NSMutableArray *_recommendedSubscribeList;
    NSMutableArray *_bannerList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _recommendedSubscribeList = [[NSMutableArray alloc] init];
    _bannerList = [[NSMutableArray alloc] init];
    [self.tableView1 addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView1 headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData
{
    [self setIsNormal:YES];
    [self setTitleStr:@"今日订阅推荐"];
}

-(void)loadNavigationBar
{
    SetButtonImage(self.naviLeftBtn, @"top_navigation_back@2x");
    self.naviRightBtn.hidden = YES;
    [self.naviLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(44, 44));
    }];
    self.contentScr.frame = CGRectMake(0, 64, [Helper screenWidth], [Helper screenHeight]-64);
    self.tableView1.frame = CGRectMake(0, 0, [Helper screenWidth], [Helper screenHeight]-64);
}

-(void)loadData
{
    [[[NetworkTools sharedNetworkTools] GET:@"/nc/topicset/subscribe/recommend.html" parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        [self.tableView1 headerEndRefreshing];
        [_recommendedSubscribeList removeAllObjects];
        [_recommendedSubscribeList addObjectsFromArray:[responseObject objectForKey:@"recommendlist"]];
        [_bannerList removeAllObjects];
        [_bannerList addObjectsFromArray:[responseObject objectForKey:@"bannerlist"]];
        [self.tableView1 reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView1 headerEndRefreshing];
    }] resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _recommendedSubscribeList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"cell";
    RecommendedSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommendedSubscribeCell" owner:self options:nil] lastObject];
    }
    
    NSDictionary *dic = [_recommendedSubscribeList objectAtIndex:indexPath.row];
    RecommendedSubscribeModel *rm = [RecommendedSubscribeModel objectWithKeyValues:dic];
    [cell setRm:rm];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}

-(void)navigationLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
