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
#import "FMGVideoPlayView.h"
#import "FullViewController.h"
#import "VideoPlayViewController.h"
#import "CFDanmakuView.h"

@interface VideoTableViewController ()<FMGVideoPlayViewDelegate, VideoCellDelegate>

@property (nonatomic, strong) NSMutableArray *videosArr;
@property (nonatomic, strong) FMGVideoPlayView *player;
@property (nonatomic, strong) FullViewController *fullVC;

@end

@implementation VideoTableViewController
{
    NSInteger count;
}

-(FullViewController *)fullVC{
    if (_fullVC == nil) {
        _fullVC = [[FullViewController alloc] init];
    }
    return _fullVC;
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
    _player = [FMGVideoPlayView videoPlayView];
    _player.delegate = self;
}

-(void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    if (isFull) {
        [self.navigationController presentViewController:self.fullVC animated:NO completion:^{
            [self.player removeFromSuperview];
            [self.fullVC.view addSubview:self.player];
            self.player.center = self.fullVC.view.center;
            self.player.fullScreenBtn.selected = YES;
            
            [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.fullVC.view);
            }];
            [self.player.danmakuView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.player);
                make.bottom.equalTo(self.player).offset(-40);
            }];
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                [self.player layoutIfNeeded];
                [self.player.danmakuView layoutIfNeeded];
            } completion:nil];
        }];
    } else {
        [self.fullVC dismissViewControllerAnimated:NO completion:^{
            [self.player removeFromSuperview];
            VideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:self.player.index]];
            [cell addSubview:self.player];
            [_player mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.cover);
            }];
            self.player.fullScreenBtn.selected = NO;
        }];
    }
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
    cell.delegate = self;
    cell.model = model;
    cell.playBtn.tag = indexPath.row;
    cell.shareBtn.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _player.index) {
        [_player.player pause];
        _player.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_player.player pause];
    _player.hidden = YES;
    VideoPlayViewController *videoController = [[VideoPlayViewController alloc] init];
    NSDictionary *dic = [self.videosArr objectAtIndex:indexPath.row];
    VideoModel *model = [VideoModel objectWithKeyValues:dic];
    videoController.model = model;
    [self.navigationController pushViewController:videoController animated:YES];
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

-(void)videoCell:(VideoCell *)videoCell playButton:(UIButton *)btn
{
    _player.index = btn.tag;
    NSDictionary *dic = [self.videosArr objectAtIndex:btn.tag];
    VideoModel *model = [VideoModel objectWithKeyValues:dic];
    [_player setUrlString:model.mp4_url];
    [videoCell addSubview:_player];
    [_player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(videoCell.cover);
    }];
    _player.contrainerViewController = self;
    [_player.player play];
    [_player showToolView:NO];
    _player.playOrPauseBtn.selected = YES;
    _player.hidden = NO;
}

-(void)videoCell:(VideoCell *)videoCell shareButton:(UIButton *)btn
{
    
}

@end
