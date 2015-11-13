//
//  HotNewsViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/24.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "HotNewsViewController.h"
#import "NewsTableViewController.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"
#import "PhotosetViewController.h"
#import "SepecialModel.h"
#import "SepecialViewController.h"
#import "PhotoSetModel.h"

#define UPDATE_URL @"/nc/article/list/T1429173683626/0-20.html"

@interface HotNewsViewController ()

@property (nonatomic, assign) BOOL isNightMode;
@property(nonatomic,assign)BOOL update;

@end

@implementation HotNewsViewController
{
    UIImageView *_headerImage;
    UIImageView *_headerTitle;
    UILabel *_headerSubTitle;
    UITableView *_todayNewsTableView;
    NSMutableArray *_todayNewsList;
    UITableView *_newsListTableView;
    NSMutableArray *_newsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _newsList = [[NSMutableArray alloc] init];
    [self createNavigation];
    [self createTableView];
    [_newsListTableView addHeaderWithTarget:self action:@selector(loadData)];
    self.update = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.update == YES) {
        [_newsListTableView headerBeginRefreshing];
        self.update = NO;
    }
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}

-(void)createNavigation
{
    _headerImage = [Helper imageView:@"todaynews_header_bg_day@2x.png" nightImage:@"todaynews_header_bg_night@2x.png" isNightMode:self.isNightMode];
    [self.view addSubview:_headerImage];
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.offset(130);
    }];
    
    _headerTitle = [Helper imageView:@"todaynews_title_bg@2x.png" nightImage:@"todaynews_title_bg@2x.png" isNightMode:self.isNightMode];
    [self.view addSubview:_headerTitle];
    [_headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(150);
        make.height.offset(35);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
    }];
    
    _headerSubTitle = [Helper label:@"———— 聚焦今日时事 浓缩新闻精华 ————" font:[UIFont systemFontOfSize:12] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter isNightMode:self.isNightMode];
    [self.view addSubview:_headerSubTitle];
    [_headerSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(14);
        make.right.equalTo(self.view).offset(-14);
        make.height.offset(40);
        make.top.equalTo(self.view).offset(75);
    }];
    
    UIButton *backBtn = [Helper button:@"weather_back@2x.png" highlightedImage:@"weather_back_highlight@2x.png" nightNormalImage:@"weather_back@2x.png" nightHighlightedImage:@"weather_back_highlight@2x.png" target:self action:@selector(todayNewsBack) tag:0 isNightMode:self.isNightMode];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.size.sizeOffset(CGSizeMake(44, 44));
        make.top.equalTo(self.view).offset(20);
    }];
}

-(void)createTableView
{
    _newsListTableView = [[UITableView alloc] init];
    _newsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _newsListTableView.delegate = self;
    _newsListTableView.dataSource = self;
    [self.view addSubview:_newsListTableView];
    
    [_newsListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(130);
        make.bottom.equalTo(self.view);
    }];
}

- (void)loadData
{
    [self loadDataWithURL:UPDATE_URL];
}

- (void)loadDataWithURL:(NSString *)allUrlstring
{
    [[[NetworkTools sharedNetworkTools] GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSLog(@"%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *temArray = responseObject[key];
        NSMutableArray *arrayM = [NewsModel objectArrayWithKeyValuesArray:temArray];
        _newsList = arrayM;
        [_newsListTableView headerEndRefreshing];
        [_newsListTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [_newsListTableView headerEndRefreshing];
    }] resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = _newsList[indexPath.row];
    static NSString *cellName = @"cell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    NSArray *nib;
    if (indexPath.row == 0) {
        nib = [[NSBundle mainBundle]loadNibNamed:@"HotBigCell" owner:self options:nil];
    }
    else{
        nib = [[NSBundle mainBundle]loadNibNamed:@"BasicCell" owner:self options:nil];
    }
    for(id oneObject in nib){
        if([oneObject isKindOfClass:[NewsCell class]]){
            cell = (NewsCell *)oneObject;
        }
    }
    cell.newsModel = newsModel;
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        cell.sortLab.hidden = NO;
        cell.sortLab.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.sortImg.hidden = NO;
    }
    else{
        cell.sortLab.hidden = YES;
        cell.sortImg.hidden = YES;
    }
    NSLog(@"%ld",indexPath.row);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = _newsList[indexPath.row];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 251.0f;
    }
    else
        return 90.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)todayNewsBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
