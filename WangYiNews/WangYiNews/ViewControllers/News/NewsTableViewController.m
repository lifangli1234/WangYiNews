//
//  NewsTableViewController.m
//  News
//
//  Created by lifangli on 15/9/19.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"
#import "PhotosetViewController.h"
#import "SepecialModel.h"
#import "SepecialViewController.h"
#import "PhotoSetModel.h"

@interface NewsTableViewController ()

@property(nonatomic,strong) NSMutableArray *arrayList;
@property(nonatomic,assign)BOOL update;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    self.update = YES;
}

- (void)setNewsUrl:(NSString *)newsUrl
{
    _newsUrl = newsUrl;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.update == YES) {
        [self.tableView headerBeginRefreshing];
        self.update = NO;
    }
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}

// ------下拉刷新
- (void)loadData
{
    [self loadDataForType:1 withURL:self.newsUrl];
}

// ------上拉加载
//- (void)loadMoreData
//{
    //NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
    //    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,self.arrayList.count];
    //[self loadDataForType:2 withURL:allUrlstring];
//}

- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    [[[NetworkTools sharedNetworkTools] GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSLog(@"%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        NSMutableArray *arrayM = [NewsModel objectArrayWithKeyValuesArray:temArray];
    
        if (type == 1) {
            self.arrayList = arrayM;
            [self.tableView headerEndRefreshing];
            [self.tableView reloadData];
        }else if(type == 2){
            [self.arrayList addObjectsFromArray:arrayM];
            
            [self.tableView footerEndRefreshing];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView headerEndRefreshing];
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = self.arrayList[indexPath.row];
    
    NSString *ID = [NewsCell idForRow:newsModel];
    
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        ID = @"BasicCell";
    }
    
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSArray *nib;
    if ([ID isEqualToString:@"BasicCell"]) {
        nib = [[NSBundle mainBundle]loadNibNamed:@"BasicCell" owner:self options:nil];
    }
    else if ([ID isEqualToString:@"ImagesCell"]){
        nib = [[NSBundle mainBundle]loadNibNamed:@"ImagesCell" owner:self options:nil];
    }
    else{
        nib = [[NSBundle mainBundle]loadNibNamed:@"BigPhotoCell" owner:self options:nil];
    }
    for(id oneObject in nib){
        if([oneObject isKindOfClass:[NewsCell class]]){
            cell = (NewsCell *)oneObject;
        }
    }
    cell.newsModel = newsModel;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = self.arrayList[indexPath.row];
    
    NSString *ID = [NewsCell idForRow:newsModel];
    if ([ID isEqualToString:@"BasicCell"]) {
        return 90;
    }
    else if ([ID isEqualToString:@"ImagesCell"]){
        return 121;
    }
    else{
        return 200;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    NewsModel *newsModel = self.arrayList[indexPath.row];
    if (newsModel.skipType) {
        if ([newsModel.skipType isEqualToString:@"photoset"]) {
            PhotosetViewController *pvc = [[PhotosetViewController alloc] init];
            NSArray *idArr = [newsModel.skipID componentsSeparatedByString:@"|"];
            NSString *url = [NSString stringWithFormat:@"/photo/api/set/%@/%@.json",idArr[0],idArr[1]];
            pvc.replyCount = [NSString stringWithFormat:@"%@",newsModel.replyCount];
            [[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                PhotoSetModel *model = [PhotoSetModel objectWithKeyValues:responseObject];
                [pvc setPhotoSetModel:model];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
            [self.navigationController pushViewController:pvc animated:YES];
        }
        else if ([newsModel.skipType isEqualToString:@"special"]) {
            SepecialViewController *svc = [[SepecialViewController alloc] init];
            NSString *url = [NSString stringWithFormat:@"/nc/special/%@.html",newsModel.skipID];
            [[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dic = [responseObject objectForKey:newsModel.skipID];
                SepecialModel *model = [SepecialModel objectWithKeyValues:dic];
                [svc setSepecialModel:model];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
            [self.navigationController pushViewController:svc animated:YES];
        }
    }
    else {
        NewsDetailViewController *ndvc = [[NewsDetailViewController alloc] init];
        ndvc.newsModel = newsModel;
        [self.navigationController pushViewController:ndvc animated:YES];
    }
}

@end
