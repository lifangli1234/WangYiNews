//
//  DiscoveryViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "TopicModel.h"
#import "ExpertModel.h"
#import "ExpertViewController.h"
#import "LoginViewController.h"

@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController
{
    NSMutableArray *_topicArr;
    NSInteger count;
    CGFloat height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _topicArr = [[NSMutableArray alloc] init];
    count = 10;
    [self.tableView1 addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView1 addFooterWithTarget:self action:@selector(loadMoreData)];
    [self.tableView1 headerBeginRefreshing];
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
    count+=10;
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        TopicModel *topicModel= [TopicModel objectWithKeyValues:responseObject];
        if (type == 1) {
            [_topicArr removeAllObjects];
            [_topicArr addObjectsFromArray:[topicModel.data objectForKey:@"expertList"]];
            [self.tableView1 headerEndRefreshing];
        }else if(type == 2){
            [_topicArr addObjectsFromArray:[topicModel.data objectForKey:@"expertList"]];
            [self.tableView1 footerEndRefreshing];
        }
        [self.tableView1 reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView1 headerEndRefreshing];
    }] resume];
}

-(void)initData
{
    [self setIsNormal:YES];
    [self setTitleStr:@"问吧"];
}

-(void)loadNavigationBar
{
    SetButtonImage(self.naviLeftBtn, @"search_icon@2x");
    SetButtonImage(self.naviRightBtn, @"qa_login_normal@2x");
    self.naviLeftBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.naviRightBtn.contentEdgeInsets = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
    [self.naviLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(44, 44));
    }];
    [self.naviRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(44, 44));
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
    
    cell.delegate = self;
    NSDictionary *dic = [_topicArr objectAtIndex:indexPath.row];
    ExpertModel *em = [ExpertModel objectWithKeyValues:dic];
    em.desc = [dic objectForKey:@"description"];
    [cell setExpertModel:em];
    height = cell.cellHeight;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertViewController *exp = [[ExpertViewController alloc] init];
    NSDictionary *dic = [_topicArr objectAtIndex:indexPath.row];
    ExpertModel *em = [ExpertModel objectWithKeyValues:dic];
    exp.expertId = em.expertId;
    [self.navigationController pushViewController:exp animated:YES];
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

-(void)navigationLeftBtnClick
{}

-(void)navigationRightBtnClick
{
    [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}

-(void)topicCellAddOrRemoveToAttention:(TopicCell *)topicCell
{
    [self navigationRightBtnClick];
}

@end
