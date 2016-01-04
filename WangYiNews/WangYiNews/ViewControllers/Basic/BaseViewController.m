//
//  BaseViewController.m
//  WangYiNews
//
//  Created by lifangli on 16/1/4.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)setIsNormal:(BOOL)isNormal
{
    _isNormal = isNormal;
}

-(void)setSegLStr:(NSString *)segLStr
{
    _segLStr = segLStr;
}

-(void)setSegRStr:(NSString *)segRStr
{
    _segRStr = segRStr;
}

-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    [self initData];
    [self createNavigationBar];
    [self loadNavigationBar];
    [self addContentScrllView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadNavigationBar
{
    
}

-(void)initData
{
    
}

-(void)createNavigationBar
{
    UIView *navView = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.height.offset(64);
    }];
    if (self.isNormal) {
        [self addLeftButton];
        [self addRightButton];
        [self addTitleLabel];
    }
    else{
        self.segmentView = [[SegmentView alloc] initSegmentView:self.segLStr secondName:self.segRStr];
        self.segmentView.delegate = self;
        self.segmentView.backgroundColor = [UIColor clearColor];
        self.segmentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.segmentView.layer.borderWidth = 0.5;
        self.segmentView.layer.cornerRadius = 15;
        [self.view addSubview:self.segmentView];
        [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(27);
            make.size.sizeOffset(CGSizeMake(240, 30));
            make.centerX.equalTo(self.view);
        }];
    }
}

-(void)addLeftButton
{
    self.naviLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviLeftBtn addTarget:self action:@selector(navigationLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.naviLeftBtn];
}

-(void)addRightButton
{
    self.naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviRightBtn addTarget:self action:@selector(navigationRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.naviRightBtn];
}

-(void)addTitleLabel
{
    UILabel *lab = [Helper label:self.titleStr font:[UIFont systemFontOfSize:18] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.offset(44);
    }];
}

-(void)addContentScrllView
{
    self.contentScr= [[UIScrollView alloc] init];
    self.contentScr.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    self.contentScr.contentSize = CGSizeMake([Helper screenWidth]*(self.isNormal?1:2), [Helper screenHeight]-64-49);
    self.contentScr.pagingEnabled = YES;
    self.contentScr.delegate = self;
    self.contentScr.showsHorizontalScrollIndicator = NO;
    self.contentScr.showsVerticalScrollIndicator = NO;
    self.contentScr.bounces = NO;
    [self.view addSubview:_contentScr];
    [self.contentScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    [self createTableView1];
    if (!self.isNormal) {
        [self createTableView2];
    }
}

-(void)createTableView1
{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [Helper screenWidth], [Helper screenHeight]-64-49)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentScr addSubview:self.tableView1];
}

-(void)createTableView2
{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake([Helper screenWidth], 0, [Helper screenWidth], [Helper screenHeight]-64-49)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentScr addSubview:self.tableView2];
}

-(void)navigationLeftBtnClick
{
    
}

-(void)navigationRightBtnClick
{
    
}

@end
