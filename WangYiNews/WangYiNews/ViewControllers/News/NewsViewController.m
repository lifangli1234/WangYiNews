//
//  NewsViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "NewsViewController.h"
#import "HotNewsViewController.h"
#import "NewsCategoryTitle.h"
#import "ChannelModel.h"
#import "NewsTableViewController.h"
#import "WeatherView.h"

#define WEATHERURL @"http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html"

@interface NewsViewController ()

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *titleAddedArray;
@property (nonatomic, strong) UIButton *squareBtn;
@property(nonatomic,assign,getter=isWeatherShow)BOOL weatherShow;

@end

@implementation NewsViewController
{
    NewsCategoryTitle *_categoryTitle;
    UIScrollView *_titleScr;
    UIScrollView *_contentScr;
    UIButton *_upAndDownBtn;
    WeatherView *_weatherView;
    UIImageView *_tran;
    WeatherModel *_weatherModel;
}

-(void)setTitleArray:(NSMutableArray *)titleArray
{
    _titleArray = titleArray;
}

-(void)setTitleAddedArray:(NSMutableArray *)titleAddedArray
{
    _titleAddedArray = titleAddedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    
    [self createNavigation];
    [self createScrollView];
    [self sendWeatherRequest];
}

#pragma mark -----------------navigation---------------
-(void)createNavigation
{
    UIView *navView = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.height.offset(64);
    }];
    
    UIButton *bellBtn = [Helper button:@"top_navi_bell@2x" target:self action:@selector(navigationBarItemClick:) tag:TOP_NAV_HOTNEWS_TAG];
    [self.view addSubview:bellBtn];
    [bellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(14);
        make.top.mas_equalTo(self.view).offset(30);
        make.size.sizeOffset(CGSizeMake(24, 24));
    }];
    
    _squareBtn = [Helper button:@"top_navigation_square@2x" target:self action:@selector(navigationBarItemClick:) tag:TOP_NAV_SQUARE_TAG];
    [self.view addSubview:_squareBtn];
    [_squareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-14);
        make.top.mas_equalTo(self.view).offset(30);
        make.size.sizeOffset(CGSizeMake(24, 24));
    }];
    
    UIImageView *topImg = [Helper imageView:@"navbar_netease@2x"];
    [self.view addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(45, 22));
        make.top.mas_equalTo(self.view).offset(31);
    }];
}

#pragma mark -----------------scrollView---------------
-(void)getTitleArray
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"topic_news" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSString *key = [jsonDic.keyEnumerator nextObject];
    NSArray *temArray = jsonDic[key];
    NSMutableArray *localArr = [ChannelModel objectArrayWithKeyValuesArray:temArray];
    [self seperatedArr:localArr];
    
    [[[NetworkTools sharedNetworkTools] GET:@"/nc/topicset/ios/subscribe/manage/listspecial.html" parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *temArray = responseObject[key];
        NSMutableArray *netArray = [ChannelModel objectArrayWithKeyValuesArray:temArray];
        if (![localArr isEqualToArray:netArray]) {
            [self seperatedArr:netArray];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}

-(void)seperatedArr:(NSMutableArray *)arr
{
    for(ChannelModel *model in arr){
        if (model.headLine) {
            ChannelModel *topicLineModel = model;
            [arr removeObject:model];
            [arr insertObject:topicLineModel atIndex:0];
            break;
        }
    }
    NSMutableArray *tArr = [[NSMutableArray alloc]init];
    NSMutableArray *aArr = [[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        ChannelModel *model = arr[i];
        if (i<23) {
            [tArr addObject:model];
        }
        else{
            [aArr addObject:model];
        }
    }
    [self setTitleArray:tArr];
    [self setTitleAddedArray:aArr];
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
    
    _upAndDownBtn = [Helper button:@"calendar_switch_down@2x" target:self action:@selector(showNewsCategory) tag:0];
    [titleView addSubview:_upAndDownBtn];
    [_upAndDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView);
        make.right.mas_equalTo(titleView).offset(-8);
        make.size.sizeOffset(CGSizeMake(35.5, 40));
    }];
    _upAndDownBtn.contentEdgeInsets = UIEdgeInsetsMake(32.5/2, 10, 32.5/2, 10);
    
    _titleScr = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, [Helper screenWidth]-45.5, 40)];
    _titleScr.showsHorizontalScrollIndicator = NO;
    _titleScr.showsVerticalScrollIndicator = NO;
    [self getTitleArray];
    [self addTitleWithArr:_titleArray];
    NewsCategoryTitle *currTitle = _titleScr.subviews.firstObject;
    currTitle.scale = 1.0;
    [titleView addSubview:_titleScr];
    
    _contentScr = [[UIScrollView alloc] init];
    _contentScr.frame = CGRectMake(0, 100, [Helper screenWidth], [Helper screenHeight]-149);
    _contentScr.contentSize = CGSizeMake([Helper screenWidth]*_titleArray.count, [Helper screenHeight]-149);
    _contentScr.showsHorizontalScrollIndicator = NO;
    _contentScr.delegate = self;
    _contentScr.bounces = NO;
    _contentScr.pagingEnabled = YES;
    [self.view addSubview:_contentScr];
    //[self.view addSubview:_newsCategoryView];
    
    [self addViewControllers];
    UIViewController *currVc = self.childViewControllers.firstObject;
    currVc.view.frame = _contentScr.bounds;
    [_contentScr addSubview:currVc.view];
}

-(void)addViewControllers
{
    for (int i=0; i<_titleArray.count; i++) {
        NSMutableArray *urlArr = [Helper addUrlsWithArr:_titleArray];
        NewsTableViewController *newsTab = [[NewsTableViewController alloc] init];
        newsTab.newsUrl = urlArr[i];
        [self addChildViewController:newsTab];
    }
}

-(void)addTitleWithArr:(NSMutableArray *)arr
{
    CGFloat X = 10;
    for (int i=0; i<arr.count; i++) {
        NewsCategoryTitle *categoryTitle = [[NewsCategoryTitle alloc] init];
        categoryTitle.userInteractionEnabled = YES;
        categoryTitle.text = ((ChannelModel *)[arr objectAtIndex:i]).tname;
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

#pragma mark -----------------weather---------------
-(void)sendWeatherRequest
{
    [[[NetworkTools alloc] init] GET:WEATHERURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _weatherModel = [WeatherModel objectWithKeyValues:responseObject];
        _weatherModel.detailArray = [responseObject objectForKey:@"北京|北京"];
        [self addWeatherView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)addWeatherView
{
    _weatherView = [[WeatherView alloc] init];
    _weatherView.backgroundColor = [UIColor whiteColor];
    _weatherView.weatherModel = _weatherModel;
    _weatherView.hidden = YES;
    _weatherView.alpha = 0.95;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:_weatherView];
    [_weatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(window).offset(64);
        make.left.and.bottom.and.right.mas_equalTo(window);
    }];
    
    _tran = [[UIImageView alloc] init];
    _tran.image = [UIImage imageNamed:@"224.png"];
    _tran.hidden = YES;
    [window addSubview:_tran];
    [_tran mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(7, 7));
        make.top.mas_equalTo(window).offset(57);
        make.right.mas_equalTo(window).offset(-33);
    }];
}

#pragma mark -----------------scrollViewDelegate---------------
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
    
    NewsTableViewController *currVc = [self.childViewControllers objectAtIndex:index];
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

#pragma mark -----------------buttonClickAction---------------
-(void)navigationBarItemClick:(UIButton *)btn
{
    if (btn.tag == TOP_NAV_HOTNEWS_TAG) {
        HotNewsViewController *hvc = [[HotNewsViewController alloc] init];
        [self.navigationController pushViewController:hvc animated:YES];
    }
    else if (btn.tag == TOP_NAV_SQUARE_TAG){
        if (self.isWeatherShow) {
            _weatherView.hidden = YES;
            _tran.hidden = YES;
            [UIView animateWithDuration:0.1 animations:^{
                self.squareBtn.transform = CGAffineTransformRotate(self.squareBtn.transform, M_1_PI * 5);
            } completion:^(BOOL finished) {
                [self.squareBtn setImage:[UIImage imageNamed:@"top_navigation_square@2x.png"] forState:UIControlStateNormal];
            }];
        }
        else{
            [[[NetworkTools alloc] init] GET:WEATHERURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                _weatherModel = [WeatherModel objectWithKeyValues:responseObject];
                _weatherModel.detailArray = [responseObject objectForKey:@"北京|北京"];
                [_weatherView setWeatherModel:_weatherModel];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
            _weatherView.hidden = NO;
            _tran.hidden = NO;
            [self.squareBtn setImage:[UIImage imageNamed:@"223.png"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 animations:^{
                self.squareBtn.transform = CGAffineTransformRotate(self.squareBtn.transform, -M_1_PI * 6);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.squareBtn.transform = CGAffineTransformRotate(self.squareBtn.transform, M_1_PI );
                }];
            }];
        }
        self.weatherShow = !self.isWeatherShow;
    }
}

-(void)showNewsCategory
{
    
}

-(void)titleLabelClick:(UITapGestureRecognizer *)gesture
{
    NewsCategoryTitle *title = (NewsCategoryTitle *)gesture.view;
    
    CGFloat offsetX = title.tag * _contentScr.frame.size.width;
    CGFloat offsetY = _contentScr.contentOffset.y;
    
    [_contentScr setContentOffset:CGPointMake(offsetX, offsetY) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
