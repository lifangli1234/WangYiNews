//
//  VideoViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "VideoViewController.h"
#import "NewsCategoryTitle.h"
#import "VideoTableViewController.h"

#define VIDEOSUBURL @"/nc/video/home/"
#define AUDIOSUBURL @"/nc/topicset/ios/radio/index.html"

@interface VideoViewController ()

@property(nonatomic,strong) NSMutableArray *titleArr;
@property(nonatomic,assign)BOOL update;
@property(nonatomic,strong) UIView *navigationView;
@property (nonatomic, strong) NSMutableArray *urlsArr;
@property (nonatomic, strong) NSMutableArray *idArr;

@end

@implementation VideoViewController
{
    UIScrollView *_titleScr;
    UIScrollView *_contentScr;
}

-(NSMutableArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = [[NSMutableArray alloc] initWithObjects:@"推荐",@"搞笑",@"美女帅哥",@"新闻现场",@"宠物",@"八卦",@"猎奇",@"体育",@"黑科技",@"涨姿势",@"二次元",@"军武",@"全景", nil];
    }
    return _titleArr;
}

-(NSMutableArray *)idArr
{
    if (!_idArr) {
        _idArr = [[NSMutableArray alloc] initWithObjects:@"T1457069041911",@"T1457069080899",@"T1457069205071",@"T1457069232830",@"T1457069261743",@"T1457069319264",@"T1457069346235",@"T1457069387259",@"T1457069475980",@"T1457069446903",@"T1457069421892",@"T1461563165622", nil];
    }
    return _idArr;
}

-(NSMutableArray *)urlsArr
{
    if (_urlsArr == nil) {
        _urlsArr = [[NSMutableArray alloc] init];
        NSString *recommend = @"recommend/getChanListNews?channel=T1457068979049&passport=&devId=4R70nVFo7N%2FjOGAl7Dql%2BgnhtyYRtyVIqBeGB12xtfEEIz0ZpgPoDMhS%2FpBn8zvR&size=10&version=7.0&spever=false&net=wifi&lat=BrzwoNWShMXZeVmIF6z1EA%3D%3D&lon=rxIMPDa8YnQi22T5RLClZg%3D%3D&ts=1461562001&sign=l6CyWZzQ2P%2Bfw9QE0no9TlVjWJt8hh3hnP%2FcA3VG7eh48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore";
        [_urlsArr insertObject:recommend atIndex:0];
        for(NSString *str in self.idArr){
            [_urlsArr addObject:[NSString stringWithFormat:@"nc/video/Tlist/%@/0-10.html",str]];
        }
    }
    return _urlsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----------------UI------------
-(void)layoutSubviews
{
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(64);
    }];
    
    [self createScrollView];
}

-(void)createScrollView
{
    UIView *titleView = [Helper view:DAYBACKGROUNDCOLOR nightColor:NIGHTBACKGROUNDCOLOR];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.height.offset(40);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = GRAYCOLOR;
    [titleView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(titleView);
        make.height.equalTo(@0.8);
    }];
    _titleScr = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, [Helper screenWidth]-20, 40)];
    _titleScr.showsHorizontalScrollIndicator = NO;
    _titleScr.showsVerticalScrollIndicator = NO;
    [self addTitleWithArr:self.titleArr];
    NewsCategoryTitle *currTitle = _titleScr.subviews.firstObject;
    currTitle.scale = 1.0;
    [titleView addSubview:_titleScr];
    
    _contentScr = [[UIScrollView alloc] init];
    _contentScr.frame = CGRectMake(0, 104, [Helper screenWidth], [Helper screenHeight]-153);
    _contentScr.contentSize = CGSizeMake([Helper screenWidth]*self.titleArr.count, [Helper screenHeight]-149);
    _contentScr.showsHorizontalScrollIndicator = NO;
    _contentScr.delegate = self;
    _contentScr.bounces = NO;
    _contentScr.pagingEnabled = YES;
    [self.view addSubview:_contentScr];
    
    [self addViewControllers];
    UIViewController *currVc = self.childViewControllers.firstObject;
    currVc.view.frame = _contentScr.bounds;
    [_contentScr addSubview:currVc.view];
}

-(void)addViewControllers
{
    for (int i=0; i<self.titleArr.count; i++) {
        VideoTableViewController *vvc = [[VideoTableViewController alloc] init];
        vvc.urlStr = self.urlsArr[i];
        [self addChildViewController:vvc];
    }
}

-(void)addTitleWithArr:(NSMutableArray *)arr
{
    CGFloat X = 10;
    for (int i=0; i<arr.count; i++) {
        NewsCategoryTitle *categoryTitle = [[NewsCategoryTitle alloc] init];
        categoryTitle.userInteractionEnabled = YES;
        categoryTitle.text = arr[i];
        CGSize titleSize = [categoryTitle.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]}];
        CGFloat W = titleSize.width;
        CGFloat H = 40;
        CGFloat Y = 0;
        categoryTitle.frame = CGRectMake(X, Y, W, H);
        categoryTitle.font = [UIFont systemFontOfSize:21];
        categoryTitle.tag = i;
        [_titleScr addSubview:categoryTitle];
        X = X + titleSize.width +10;
        
        [categoryTitle addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)]];
    }
    
    _titleScr.contentSize = CGSizeMake(X, 40);
}

#pragma mark----------------scrollViewDelegate------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/_contentScr.frame.size.width;
    NewsCategoryTitle *currTitle = (NewsCategoryTitle *)[_titleScr.subviews objectAtIndex:index];
    CGFloat offsetX = currTitle.center.x - _titleScr.frame.size.width*0.5;
    CGFloat offsetMax = _titleScr.contentSize.width - _titleScr.frame.size.width;
    if (offsetX<0) {
        offsetX = 0;
    }
    else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    [_titleScr setContentOffset:CGPointMake(offsetX, _titleScr.contentOffset.y) animated:YES];
    
    VideoTableViewController *currVc = [self.childViewControllers objectAtIndex:index];
    [_titleScr.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            NewsCategoryTitle *label =(NewsCategoryTitle *) _titleScr.subviews[idx];
            label.scale = 0.0;
        }
    }];
    
    if (currVc.view.superview) return;
    
    currVc.view.frame = _contentScr.bounds;
    [_contentScr addSubview:currVc.view];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    NewsCategoryTitle *labelLeft = _titleScr.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    if (rightIndex < _titleScr.subviews.count) {
        NewsCategoryTitle *labelRight = _titleScr.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

#pragma mark----------------btnAction------------
-(void)titleLabelClick:(UITapGestureRecognizer *)gesture
{
    NewsCategoryTitle *title = (NewsCategoryTitle *)gesture.view;
    
    CGFloat offsetX = title.tag * _contentScr.frame.size.width;
    CGFloat offsetY = _contentScr.contentOffset.y;
    
    [_contentScr setContentOffset:CGPointMake(offsetX, offsetY) animated:YES];
}

-(UIView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [Helper view:BASERED nightColor:BASERED_NIGHT];
        
        UILabel *titleLabel = [Helper label:@"视频" font:[UIFont systemFontOfSize:18] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
        [_navigationView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_navigationView);
            make.top.equalTo(_navigationView).offset(20);
            make.height.offset(44);
        }];
    }
    return _navigationView;
}

@end
