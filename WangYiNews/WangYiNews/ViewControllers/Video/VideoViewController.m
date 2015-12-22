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

#define VIDEOSUBURL @"/nc/video/home/"
#define AUDIOSUBURL @"/nc/topicset/ios/radio/index.html"

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *arrayList;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavigation];
    [self createContentScrollView];
    [self createVideoTableView];
    [self createAudioTableView];
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
        NSLog(@"%@",url);
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        NSMutableArray *arrayM;
        if (tableView == _videoTableView) {
            arrayM = [VideoModel objectArrayWithKeyValuesArray:temArray];
        }
        else{
            arrayM = [AudioModel objectArrayWithKeyValuesArray:temArray];
        }
        if (type == 1) {
            self.arrayList = arrayM;
            [tableView headerEndRefreshing];
            [tableView reloadData];
        }else if(type == 2){
            [self.arrayList addObjectsFromArray:arrayM];
            [tableView footerEndRefreshing];
            [tableView reloadData];
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

-(void)createVideoTableView
{
    _videoTableView = [[UITableView alloc] init];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
    _videoTableView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentScr addSubview:_videoTableView];
    [_videoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(_contentScr);
        make.width.offset([Helper screenWidth]);
    }];
}

-(void)createAudioTableView
{
    _audioTableView = [[UITableView alloc] init];
    _audioTableView.delegate = self;
    _audioTableView.dataSource = self;
    _audioTableView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _audioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentScr addSubview:_audioTableView];
    [_audioTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_contentScr);
        make.left.equalTo(_videoTableView.mas_right);
        make.width.offset([Helper screenWidth]);
    }];
}

-(void)createContentScrollView
{
    _contentScr= [[UIScrollView alloc] init];
    _contentScr.dk_backgroundColorPicker = DKColorWithColors(DAYBACKGROUNDCOLOR, NIGHTBACKGROUNDCOLOR);
    _contentScr.contentSize = CGSizeMake([Helper screenWidth]*2, [Helper screenHeight]-64);
    _contentScr.pagingEnabled = YES;
    _contentScr.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_contentScr];
    [_contentScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.bottom.left.right.equalTo(self.view);
    }];
}

#pragma mark----------------tableViewDelegate------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
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

@end
