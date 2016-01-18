//
//  VideoViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"
#import "AudioModel.h"
#import "AudioSubModel.h"
#import "VideoTitleModel.h"
#import "VideoContentModel.h"
#import "VideoCell.h"
#import "AudioCell.h"
#import "CatergoryVideoViewController.h"

#define VIDEOSUBURL @"/nc/video/home/"
#define AUDIOSUBURL @"/nc/topicset/ios/radio/index.html"

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,AudioCellDelegate>

@property(nonatomic,strong) NSMutableArray *contentListArr;
@property(nonatomic,strong) NSMutableArray *titleListArr;
@property(nonatomic,strong) NSMutableArray *radioListArr;
@property(nonatomic,assign)BOOL update;

@end

@implementation VideoViewController
{
    NSInteger count;
}

-(NSMutableArray *)titleListArr
{
    if (_titleListArr == nil) {
        _titleListArr = [[NSMutableArray alloc] init];
    }
    return _titleListArr;
}

-(NSMutableArray *)contentListArr
{
    if (_contentListArr == nil) {
        _contentListArr = [[NSMutableArray alloc] init];
    }
    return _contentListArr;
}

-(NSMutableArray *)radioListArr
{
    if (_radioListArr == nil) {
        _radioListArr = [[NSMutableArray alloc] init];
    }
    return _radioListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView1 addHeaderWithTarget:self action:@selector(loadVideoData)];
    [self.tableView2 addFooterWithTarget:self action:@selector(loadMoreVideoData)];
    [self.tableView2 addHeaderWithTarget:self action:@selector(loadAudioData)];
    self.tableView2.tableHeaderView = [self createAudioTableViewHeaderView];
    self.update = YES;
    count = 10;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.update == YES) {
        [self.tableView1 headerBeginRefreshing];
        self.update = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----------------request------------
-(void)loadVideoData
{
    [self loadDataWithType:1 url:[NSString stringWithFormat:@"%@%d-10.html",VIDEOSUBURL,0] tableView:self.tableView1];
}

-(void)loadMoreVideoData
{
    [self loadDataWithType:2 url:[NSString stringWithFormat:@"%@%ld-10.html",VIDEOSUBURL,count] tableView:self.tableView1];
    count+=10;
}

-(void)loadAudioData
{
    [self loadDataWithType:1 url:AUDIOSUBURL tableView:self.tableView2];
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url tableView:(UITableView *)tableView
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        if (tableView == self.tableView1) {
            VideoModel *videoModel = [VideoModel objectWithKeyValues:responseObject];
            [self.titleListArr removeAllObjects];
            [self.titleListArr addObjectsFromArray:videoModel.videoSidList];
            self.tableView1.tableHeaderView = nil;
            self.tableView1.tableHeaderView = [self createVideoTableViewHeaderView];
            if (type == 1) {
                [self.contentListArr removeAllObjects];
                [self.contentListArr addObjectsFromArray:videoModel.videoList];
                [tableView headerEndRefreshing];
            }else if(type == 2){
                [self.contentListArr addObjectsFromArray:videoModel.videoList];
                [tableView footerEndRefreshing];
            }
        }
        else{
            [self.radioListArr removeAllObjects];
            NSArray *arr = [responseObject objectForKey:@"cList"];
            [self.radioListArr addObjectsFromArray:arr];
            [tableView headerEndRefreshing];
        }
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [tableView headerEndRefreshing];
    }] resume];
}

#pragma mark----------------UI------------
-(void)initData
{
    self.naviLeftBtn.hidden = YES;
    self.naviRightBtn.hidden = YES;
    [self setSegLStr:@"视频"];
    [self setSegRStr:@"电台"];
}

-(UIView *)createVideoTableViewHeaderView
{
    UIView *headerView = [Helper view:DAYBACKGROUNDCOLOR nightColor:NIGHTBACKGROUNDCOLOR];
    headerView.frame = CGRectMake(0, 0, [Helper screenWidth], 100);
    
    [self addContentForHeaderView:headerView index:0];
    [self addContentForHeaderView:headerView index:1];
    [self addContentForHeaderView:headerView index:2];
    [self addContentForHeaderView:headerView index:3];
    
    UIView *line = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
    line.layer.borderColor = [Helper isNightMode]?NIGHTGRAYCOLOR.CGColor:GRAYCOLOR.CGColor;
    line.layer.borderWidth = 1;
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(5);
        make.left.right.bottom.equalTo(headerView);
    }];
    
    return headerView;
}

-(void)addContentForHeaderView:(UIView *)superView index:(NSInteger)index
{
    CGFloat width = ([Helper screenWidth]-(_titleListArr.count-1))/_titleListArr.count;
    
    NSDictionary *dic = [_titleListArr objectAtIndex:index];
    VideoTitleModel *vtm = [VideoTitleModel objectWithKeyValues:dic];
    
    UILabel *lab = [Helper label:vtm.title font:[UIFont systemFontOfSize:13] textColor:[UIColor darkGrayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    [superView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView).offset(-13);
        make.height.offset(26);
        make.width.offset(width);
        make.left.equalTo(superView).offset((width+1)*index);
        
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [img sd_setImageWithURL:[NSURL URLWithString:vtm.imgsrc] placeholderImage:nil];
    [superView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset((width-40)/2+(width+1)*index);
        make.top.equalTo(superView).offset(17);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag = VIDEOTITLEVIEWBUTTON_TAG+index;
    [btn addTarget:self action:@selector(videoCatergory:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab.mas_left);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView).offset(-5);
        make.width.equalTo(lab.mas_width);
    }];
    
    UIView *line = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [superView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab.mas_right);
        make.width.offset(1);
        make.top.bottom.equalTo(superView);
    }];
}

-(UIView *)createAudioTableViewHeaderView
{
    UIView *headerView = [Helper view:DAYBACKGROUNDCOLOR nightColor:NIGHTBACKGROUNDCOLOR];
    headerView.frame = CGRectMake(0, 0, [Helper screenWidth], 49);
    
    [self addContentForAudioHeaderView:headerView index:0 text:@"我的下载" image:@"audionews_indexheader_download@2x"];
    [self addContentForAudioHeaderView:headerView index:1 text:@"最近播放" image:@"audionews_indexheader_recent@2x"];
    
    UIView *line = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
    line.layer.borderColor = [Helper isNightMode]?NIGHTGRAYCOLOR.CGColor:GRAYCOLOR.CGColor;
    line.layer.borderWidth = 1;
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(5);
        make.left.right.bottom.equalTo(headerView);
    }];
    
    return headerView;
}

-(void)addContentForAudioHeaderView:(UIView *)superView index:(NSInteger)index text:(NSString *)text image:(NSString *)image
{
    CGFloat width = ([Helper screenWidth]-1)/2;
    
    UIView *backView = [Helper view:DAYBACKGROUNDCOLOR nightColor:NIGHTBACKGROUNDCOLOR];
    [superView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.bottom.equalTo(superView).offset(-5);
        make.left.equalTo(superView).offset((width+1)*index);
        make.width.offset(width);
    }];
    
    UILabel *lab = [Helper label:text font:[UIFont systemFontOfSize:13] textColor:[UIColor darkGrayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    [backView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.centerX.equalTo(backView).offset(index==0?11:14);
    }];
    
    UIImageView *img = [Helper imageView:image];
    [backView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lab.mas_left).offset(-8);
        make.centerY.equalTo(backView);
        make.size.sizeOffset(index==0?CGSizeMake(14, 19):CGSizeMake(20, 20));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag = VIDEOTITLEVIEWBUTTON_TAG+index;
    [btn addTarget:self action:@selector(videoCatergory:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backView);
    }];
    
    UIView *line = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [superView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_right);
        make.width.offset(1);
        make.top.bottom.equalTo(superView);
    }];
}

#pragma mark----------------tableViewDelegate------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView1) {
        return _contentListArr.count;
    }
    else
        return _radioListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    
    if (tableView == self.tableView1) {
        VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:self options:nil] lastObject];
        }
        
        NSDictionary *dic = [_contentListArr objectAtIndex:indexPath.row];
        VideoContentModel *vcm = [VideoContentModel objectWithKeyValues:dic];
        vcm.desc = [dic objectForKey:@"description"];
        [cell setVideoContentModel:vcm];
        
        return cell;
    }
    else{
        AudioCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AudioCell" owner:self options:nil] lastObject];
        }
        
        NSDictionary *dic = [_radioListArr objectAtIndex:indexPath.row];
        AudioModel *acm = [AudioModel objectWithKeyValues:dic];
        [cell setAudioModel:acm];
        cell.delegate = self;
        cell.catergortBtn.tag = indexPath.row;
        cell.playBtn1.tag = indexPath.row;
        cell.playBtn2.tag = indexPath.row;
        cell.playBtn3.tag = indexPath.row;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        return 318;
    }
    else{
        return 133 + ([Helper screenWidth]-50)/3;
    }
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

#pragma mark----------------btnAction------------
//-(void)videoPageBtn:(UIButton *)btn
//{
//    if (btn.tag == VIDEO_TAG) {
//        btn.selected = YES;
//        _audioBtn.selected = NO;
//        _contentScr.contentOffset = CGPointMake(0, 0);
//        [_btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(segmentView);
//        }];
//        [_btnBackView layoutIfNeeded];
//    }
//    else if(btn.tag == RADIO_TAG){
//        btn.selected = YES;
//        _videoBtn.selected = NO;
//        _contentScr.contentOffset = CGPointMake([Helper screenWidth], 0);
//        [_btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(segmentView).offset(100);
//        }];
//        [_btnBackView layoutIfNeeded];
//        if (self.update == YES) {
//            [_videoTableView headerBeginRefreshing];
//            self.update = NO;
//        }
//    }
//    else{
//        
//    }
//}

-(void)segmentViewFirstBtnClick:(SegmentView *)segmentView
{
     self.contentScr.contentOffset = CGPointMake(0, 0);
}

-(void)segmentViewSecondBtnClick:(SegmentView *)segmentView
{
    self.contentScr.contentOffset = CGPointMake([Helper screenWidth], 0);
    [self.tableView2 headerBeginRefreshing];
}

-(void)videoCatergory:(UIButton *)btn
{
    NSDictionary *dic = [_titleListArr objectAtIndex:btn.tag-VIDEOTITLEVIEWBUTTON_TAG];
    VideoTitleModel *vtm = [VideoTitleModel objectWithKeyValues:dic];
    CatergoryVideoViewController *cvvc = [[CatergoryVideoViewController alloc] init];
    cvvc.cid = vtm.sid;
    cvvc.cname = vtm.title;
    cvvc.type = @"video";
    [self.navigationController pushViewController:cvvc animated:YES];
}

#pragma mark----------------audioCellDelegate------------
-(void)audioCellCatergoryBtnClick:(NSInteger)tag
{
    NSDictionary *dic = [_radioListArr objectAtIndex:tag];
    AudioModel *acm = [AudioModel objectWithKeyValues:dic];
    CatergoryVideoViewController *cvvc = [[CatergoryVideoViewController alloc] init];
    cvvc.cid = acm.cid;
    cvvc.cname = acm.cname;
    cvvc.type = @"radio";
    [self.navigationController pushViewController:cvvc animated:YES];
}

@end
