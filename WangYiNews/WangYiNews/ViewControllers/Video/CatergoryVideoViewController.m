//
//  CatergoryVideoViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/12/25.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "CatergoryVideoViewController.h"
#import "CatergoryRadioCell.h"
#import "AudioSubModel.h"
#import "VideoContentModel.h"
#import "VideoCell.h"

@interface CatergoryVideoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation CatergoryVideoViewController
{
    UITableView *_radioListTableView;
    int count;
}

-(NSMutableArray *)listArr
{
    if (_listArr == nil) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    [self createNavigationView];
    [self createRadioTableView];
    [_radioListTableView headerBeginRefreshing];
    count = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----------------request------------
-(void)loadData
{
    NSString *url = [self.type isEqualToString:@"radio"]?[NSString stringWithFormat:@"/nc/topicset/ios/radio/%@/%d-20.html",self.cid,0]:[NSString stringWithFormat:@"/nc/video/list/%@/y/%d-10.html",self.cid,0];
    [self loadDataWithType:1 url:url];
}

-(void)loadMoreData
{
    NSString *url = [self.type isEqualToString:@"radio"]?[NSString stringWithFormat:@"/nc/topicset/ios/radio/%@/%d-20.html",self.cid,count]:[NSString stringWithFormat:@"/nc/video/list/%@/y/%d-10.html",self.cid,count];
    [self loadDataWithType:2 url:url];
    count+=10;
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        if (type == 1) {
            [self.listArr removeAllObjects];
            [self.listArr addObjectsFromArray:[responseObject objectForKey:[self.type isEqualToString:@"radio"]?@"tList":self.cid]];
            [_radioListTableView headerEndRefreshing];
        }
        else if (type == 2){
            [self.listArr addObjectsFromArray:[responseObject objectForKey:[self.type isEqualToString:@"radio"]?@"tList":self.cid]];
            [_radioListTableView footerEndRefreshing];
        }
        [_radioListTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [_radioListTableView headerEndRefreshing];
        [_radioListTableView footerEndRefreshing];
    }] resume];
}

-(void)createNavigationView
{
    UIView *view = [Helper createNavigationBarWithTitle:self.cname andTarget:self andSel:@selector(btnBack)];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.offset(64);
    }];
}

#pragma mark----------------UI------------
-(void)createRadioTableView
{
    _radioListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [Helper screenWidth], [Helper screenHeight]-64)];
    _radioListTableView.delegate = self;
    _radioListTableView.dataSource = self;
    _radioListTableView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _radioListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_radioListTableView addHeaderWithTarget:self action:@selector(loadData)];
    [_radioListTableView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self.view addSubview:_radioListTableView];
}

#pragma mark----------------tableViewDelegate------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    
    NSDictionary *dic = [self.listArr objectAtIndex:indexPath.row];
    if ([self.type isEqualToString:@"radio"]) {
        CatergoryRadioCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CatergoryRadioCell" owner:self options:nil] lastObject];
        }
        
        AudioSubModel *am = [AudioSubModel objectWithKeyValues:dic];
        [cell setAudioSubModle:am];
        
        return cell;
    }
    else{
        VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:self options:nil] lastObject];
        }
        
        VideoContentModel *vcm = [VideoContentModel objectWithKeyValues:dic];
        vcm.desc = [dic objectForKey:@"description"];
        [cell setVideoContentModel:vcm];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.type isEqualToString:@"radio"]?106.0f:318.0f;
}

#pragma mark----------------btnAction------------
-(void)btnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
