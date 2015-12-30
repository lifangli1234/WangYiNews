//
//  DiscoveryViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "TopicCell.h"
#import "TopicModel.h"
#import "ExpertModel.h"

@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController
{
    UITableView *_listTableView;
    NSMutableArray *_topicArr;
    NSInteger count;
    CGFloat height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _topicArr = [[NSMutableArray alloc] init];
    count = 1;
    [self createNavigationBar];
    [self createTableView];
    [_listTableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    [self loadDataWithType:1 url:@"/newstopic/list/expert/0-10.html"];
}

-(void)loadMoreData
{
    [self loadDataWithType:2 url:[NSString stringWithFormat:@"/newstopic/list/expert/%ld-10.html",count]];
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        TopicModel *topicModel= [TopicModel objectWithKeyValues:responseObject];
        if (type == 1) {
            [_topicArr removeAllObjects];
            [_topicArr addObjectsFromArray:[topicModel.data objectForKey:@"expertList"]];
            [_listTableView headerEndRefreshing];
        }else if(type == 2){
            [_topicArr addObjectsFromArray:[topicModel.data objectForKey:@"expertList"]];
            [_listTableView footerEndRefreshing];
        }
        [_listTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [_listTableView headerEndRefreshing];
    }] resume];
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
    
    UIButton *searchBtn = [Helper button:@"search_icon@2x" target:self action:@selector(searchBtn) tag:0];
    searchBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [IV addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IV).offset(20);
        make.left.equalTo(IV);
        make.size.sizeOffset(CGSizeMake(44, 44));
    }];
    
    UILabel *titleLab = [Helper label:@"问吧" font:TITLEFONT textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    [IV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IV).offset(20);
        make.centerX.equalTo(IV);
        make.height.offset(44);
    }];
    
    UIButton *loginBtn = [Helper button:@"qa_login_normal@2x" target:self action:@selector(loginBtn) tag:0];
    loginBtn.contentEdgeInsets = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
    [IV addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IV).offset(20);
        make.right.equalTo(IV);
        make.size.sizeOffset(CGSizeMake(44, 44));
    }];
}

-(void)createTableView
{
    _listTableView = [[UITableView alloc] init];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTableView addHeaderWithTarget:self action:@selector(loadData)];
    [_listTableView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self.view addSubview:_listTableView];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _topicArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TopicCell" owner:self options:nil] lastObject];
    }
    
    NSDictionary *dic = [_topicArr objectAtIndex:indexPath.row];
    ExpertModel *em = [ExpertModel objectWithKeyValues:dic];
    em.desc = [dic objectForKey:@"description"];
    [cell setExpertModel:em];
    height = cell.cellHeight;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TopicCell" owner:self options:nil] lastObject];
    NSDictionary *dic = [_topicArr objectAtIndex:indexPath.row];
    ExpertModel *em = [ExpertModel objectWithKeyValues:dic];
    em.desc = [dic objectForKey:@"description"];
    [cell setExpertModel:em];
    height = cell.cellHeight;
    return height;
}

-(void)searchBtn
{}

-(void)loginBtn
{}

@end
