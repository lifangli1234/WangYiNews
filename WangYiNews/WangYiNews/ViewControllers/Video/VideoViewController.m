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

#define VIDEOSUBURL @"/nc/video/home/"
#define AUDIOSUBURL @"/nc/topicset/ios/radio/index.html"

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *contentListArr;
@property(nonatomic,strong) NSMutableArray *titleListArr;
@property(nonatomic,assign)BOOL update;

@end

@implementation VideoViewController
{
    UIButton *_videoBtn;
    UIButton *_audioBtn;
    UIView *_btnBackView;
    UIView *segmentView;
    UIScrollView *_contentScr;
    UITableView *_videoTableView;
    UITableView *_audioTableView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavigation];
    [self createContentScrollView];
    [_videoTableView addHeaderWithTarget:self action:@selector(loadVideoData)];
    [_videoTableView addFooterWithTarget:self action:@selector(loadMoreVideoData)];
    [_audioTableView addHeaderWithTarget:self action:@selector(loadAudioData)];
    [_audioTableView addFooterWithTarget:self action:@selector(loadMoreAudioData)];
    
    self.update = YES;
    count = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.update == YES) {
        [_videoTableView headerBeginRefreshing];
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
    [self loadDataWithType:1 url:[NSString stringWithFormat:@"%@%d-10.html",VIDEOSUBURL,0] tableView:_videoTableView];
}

-(void)loadMoreVideoData
{
    [self loadDataWithType:2 url:[NSString stringWithFormat:@"%@%ld-10.html",VIDEOSUBURL,count] tableView:_videoTableView];
    count++;
}

-(void)loadAudioData
{
    [self loadDataWithType:1 url:AUDIOSUBURL tableView:_audioTableView];
}

-(void)loadMoreAudioData
{
    [self loadDataWithType:2 url:AUDIOSUBURL tableView:_audioTableView];
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url tableView:(UITableView *)tableView
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        if (tableView == _videoTableView) {
            VideoModel *videoModel = [VideoModel objectWithKeyValues:responseObject];
            [self.titleListArr removeAllObjects];
            self.titleListArr = videoModel.videoSidList;
            _videoTableView.tableHeaderView = nil;
            _videoTableView.tableHeaderView = [self createVideoTableViewHeaderView];
            if (type == 1) {
                [self.contentListArr removeAllObjects];
                self.contentListArr = videoModel.videoList;
                [tableView headerEndRefreshing];
            }else if(type == 2){
                [self.contentListArr addObjectsFromArray:videoModel.videoList];
                [tableView footerEndRefreshing];
            }
            [tableView reloadData];
        }
        else{
            //AudioModel *audioModel = [AudioModel objectWithKeyValues:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [tableView headerEndRefreshing];
    }] resume];
}

#pragma mark----------------UI------------
-(void)createNavigation
{
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    
    UIView *navView = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.offset(64);
    }];
    
    segmentView = [Helper view:[UIColor clearColor] nightColor:[UIColor clearColor]];
    segmentView.layer.borderColor = [UIColor whiteColor].CGColor;
    segmentView.layer.borderWidth = 0.5;
    segmentView.layer.cornerRadius = 15;
    [navView addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView).offset(27);
        make.size.sizeOffset(CGSizeMake(200, 30));
        make.centerX.equalTo(navView);
    }];
    
    _btnBackView = [Helper view:[UIColor whiteColor] nightColor:[UIColor whiteColor]];
    _btnBackView.layer.cornerRadius = 15;
    [segmentView addSubview:_btnBackView];
    [_btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(segmentView);
        make.width.offset(100);
    }];
    
    _videoBtn = [Helper button:@"视频" textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:17] tag:VIDEO_TAG target:self action:@selector(videoPageBtn:)];
    _videoBtn.layer.cornerRadius = 15;
    _videoBtn.selected = YES;
    [_videoBtn dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateSelected];
    [segmentView addSubview: _videoBtn];
    [_videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(segmentView);
        make.width.offset(100);
    }];
    
    _audioBtn = [Helper button:@"电台" textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:17] tag:RADIO_TAG target:self action:@selector(videoPageBtn:)];
    _audioBtn.layer.cornerRadius = 15;
    [_audioBtn dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateSelected];
    [segmentView addSubview: _audioBtn];
    [_audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(segmentView);
        make.width.offset(100);
    }];
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
    [btn addTarget:self action:@selector(videoCatergory) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
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

-(void)createVideoTableView
{
    _videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [Helper screenWidth], [Helper screenHeight]-64)];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
    _videoTableView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentScr addSubview:_videoTableView];
}

-(void)createAudioTableView
{
    _audioTableView = [[UITableView alloc] initWithFrame:CGRectMake([Helper screenWidth], 0, [Helper screenWidth], [Helper screenHeight]-64)];
    _audioTableView.delegate = self;
    _audioTableView.dataSource = self;
    _audioTableView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _audioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentScr addSubview:_audioTableView];
}

-(void)createContentScrollView
{
    _contentScr= [[UIScrollView alloc] init];
    _contentScr.dk_backgroundColorPicker = DKColorWithColors([UIColor grayColor], NIGHTBACKGROUNDCOLOR);
    _contentScr.contentSize = CGSizeMake([Helper screenWidth]*2, [Helper screenHeight]-64);
    _contentScr.pagingEnabled = YES;
    _contentScr.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_contentScr];
    [_contentScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.bottom.left.right.equalTo(self.view);
    }];
    
    [self createVideoTableView];
    [self createAudioTableView];
}

#pragma mark----------------tableViewDelegate------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentListArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 318;
}

#pragma mark----------------scrollViewDelegate------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

#pragma mark----------------btnAction------------
-(void)videoPageBtn:(UIButton *)btn
{
    if (btn.tag == VIDEO_TAG) {
        btn.selected = YES;
        _audioBtn.selected = NO;
        _contentScr.contentOffset = CGPointMake(0, 0);
        [_btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(segmentView);
        }];
        [_btnBackView layoutIfNeeded];
    }
    else if(btn.tag == RADIO_TAG){
        btn.selected = YES;
        _videoBtn.selected = NO;
        _contentScr.contentOffset = CGPointMake([Helper screenWidth], 0);
        [_btnBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(segmentView).offset(100);
        }];
        [_btnBackView layoutIfNeeded];
        if (self.update == YES) {
            [_videoTableView headerBeginRefreshing];
            self.update = NO;
        }
    }
    else{
        
    }
}

-(void)videoCatergory
{}

@end
