//
//  AddSubscribeViewController.m
//  WangYiNews
//
//  Created by lifangli on 16/1/22.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "AddSubscribeViewController.h"
#import "NewsCategoryTitle.h"
#import "AddSubscribeCell.h"

@interface AddSubscribeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *catergoryList;
@property (nonatomic, strong) NSMutableArray *subscribeList;

@end

@implementation AddSubscribeViewController
{
    UIButton *navRight;
    UIActivityIndicatorView *testActivityIndicator;
    UITableView *_subscribeTableView;
    UIScrollView *_scrollView;
    UIImageView *_seachIcon;
    UILabel *_searchLabel;
}

-(NSMutableArray *)subscribeList
{
    if (_subscribeList == nil) {
        _subscribeList = [[NSMutableArray alloc] init];
    }
    return _subscribeList;
}

-(NSMutableArray *)catergoryList
{
    if (_catergoryList == nil) {
        _catergoryList = [[NSMutableArray alloc] init];
    }
    return _catergoryList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _catergoryList = [[NSMutableArray alloc] init];
    _subscribeList = [[NSMutableArray alloc] init];
    [self createNavigationBar];
    [self createBackGroundImg];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    NSString *url = @"/nc/topicset/ios/v4/subscribe/read/all.html";
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        [testActivityIndicator stopAnimating];
        [_catergoryList addObjectsFromArray:(NSArray *)responseObject];
        [self loadUI];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [testActivityIndicator stopAnimating];
        NSLog(@"%@",error);
    }] resume];
}

-(void)createNavigationBar
{
    UIView *nav = [Helper createNavigationBarWithTitle:@"添加订阅" andTarget:self andSel:@selector(back)];
    [self.view addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.offset(64);
    }];
    
    navRight = [Helper button:@"入驻" textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:15] tag:0 target:self action:@selector(navRightBtn)];
    navRight.hidden = YES;
    [nav addSubview:navRight];
}

-(void)createBackGroundImg
{
    UIImageView *img = [Helper imageView:@"photoview_image_default_white@2x"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(32);
        make.centerX.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(320, 70));
    }];
    
    testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [testActivityIndicator startAnimating];
    [testActivityIndicator setHidesWhenStopped:YES];
    [self.view addSubview:testActivityIndicator];
    [testActivityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img).offset(-70);
        make.centerY.equalTo(img).offset(-11);
    }];
}

-(void)loadUI
{
    navRight.hidden = NO;
    
    UIView *searchView = [Helper view:[UIColor colorWithWhite:0.9 alpha:1.0] nightColor:[UIColor colorWithWhite:0.1 alpha:1.0]];
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@45);
    }];
    
    UIImageView *img = [Helper imageView:@"searchBar_background@2x"];
    [searchView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(searchView);
        make.size.sizeOffset(CGSizeMake(355, 29));
    }];
    
    _searchLabel = [Helper label:@"搜索" font:[UIFont systemFontOfSize:14] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    [searchView addSubview:_searchLabel];
    [_searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchView);
        make.centerX.equalTo(searchView).offset(10);
    }];
    
    _seachIcon = [Helper imageView:@"searchBar_icon@2x"];
    [searchView addSubview:_seachIcon];
    [_seachIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_searchLabel);
        make.right.equalTo(_searchLabel.mas_left).offset(-5);
        make.size.sizeOffset(CGSizeMake(15, 15));
    }];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.frame = CGRectMake(0, 109, 80, [Helper screenHeight]-109);
    [self addTitleWithArr:_catergoryList];
    NewsCategoryTitle *currTitle = _scrollView.subviews.firstObject;
    currTitle.scale = 1.0;
    [self.view addSubview:_scrollView];
    
    [_subscribeList addObjectsFromArray:[[_catergoryList objectAtIndex:0] objectForKey:@"tList"]];
    
    UIView *line = [Helper view:[UIColor lightGrayColor] nightColor:[UIColor grayColor]];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(_scrollView.mas_right);
        make.top.equalTo(searchView.mas_bottom);
        make.width.offset(1);
    }];
    
    _subscribeTableView = [[UITableView alloc] init];
    _subscribeTableView.delegate = self;
    _subscribeTableView.dataSource = self;
    _subscribeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_subscribeTableView];
    [_subscribeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.left.equalTo(line.mas_right);
        make.top.equalTo(searchView.mas_bottom);
    }];
}

-(void)addTitleWithArr:(NSMutableArray *)arr
{
    for (int i=0; i<arr.count; i++) {
        NewsCategoryTitle *categoryTitle = [[NewsCategoryTitle alloc] init];
        categoryTitle.userInteractionEnabled = YES;
        categoryTitle.text = [arr[i] objectForKey:@"cName"];
        categoryTitle.frame = CGRectMake(0, 50*i, 80, 50);
        categoryTitle.font = [UIFont systemFontOfSize:18];
        categoryTitle.tag = i;
        [_scrollView addSubview:categoryTitle];
        
        [categoryTitle addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)]];
    }
    
    _scrollView.contentSize = CGSizeMake(80, 50*_catergoryList.count);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subscribeList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"cell";
    AddSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddSubscribeCell" owner:self options:nil] lastObject];
    }
    
    NSDictionary *dic = [_subscribeList objectAtIndex:indexPath.row];
    AddSubscribeModel *rm = [AddSubscribeModel objectWithKeyValues:dic];
    [cell setAm:rm];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navRightBtn
{
    
}

-(void)titleLabelClick:(UITapGestureRecognizer *)gesture
{
    NewsCategoryTitle *title = (NewsCategoryTitle *)gesture.view;
    title.scale = 1.0;
    [_scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != title.tag) {
            NewsCategoryTitle *label =(NewsCategoryTitle *) _scrollView.subviews[idx];
            label.scale = 0.0;
        }
    }];
    [_subscribeList removeAllObjects];
    [_subscribeList addObjectsFromArray:[[_catergoryList objectAtIndex:title.tag] objectForKey:@"tList"]];
    [_subscribeTableView reloadData];
}

@end

