//
//  VideoTableViewController.m
//  WangYiNews
//
//  Created by lifangli on 16/4/25.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "VideoTableViewController.h"
#import "VideoCell.h"
#import "VideoModel.h"

@interface VideoTableViewController ()

@property (nonatomic, strong) NSMutableArray *videosArr;

@end

@implementation VideoTableViewController
{
    NSInteger count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    count = 0;
    [self UI];
}

-(void)UI
{
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
    [self.tableView headerBeginRefreshing];
}

-(void)refreshData
{
    [self loadDataWithType:1 url:self.urlStr];
}

-(void)loadMoreData
{
    count += 10;
    NSString *str = [self.urlStr stringByReplacingOccurrencesOfString:@"0-10.html" withString:[NSString stringWithFormat:@"%ld-10.html",count]];
    [self loadDataWithType:2 url:str];
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *temArray = responseObject[key];
        if (type == 1) {
            [self.videosArr removeAllObjects];
        }
        [self.videosArr addObjectsFromArray:temArray];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videosArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:self options:nil] lastObject];
    }
    
    NSDictionary *dic = [self.videosArr objectAtIndex:indexPath.row];
    VideoModel *model = [VideoModel objectWithKeyValues:dic];
    model.desc = dic[@"description"];
    cell.model = model;
    
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 324.0f;
}

-(NSMutableArray *)videosArr
{
    if (_videosArr == nil) {
        _videosArr = [[NSMutableArray alloc] init];
    }
    return _videosArr;
}

@end
