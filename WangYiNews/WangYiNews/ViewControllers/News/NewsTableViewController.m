//
//  NewsTableViewController.m
//  News
//
//  Created by lifangli on 15/9/19.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"
#import "PhotosetViewController.h"
#import "SepecialModel.h"
#import "SepecialViewController.h"
#import "PhotoSetModel.h"
#import "WebViewViewController.h"

@interface NewsTableViewController ()

@property(nonatomic,strong) NSMutableArray *arrayList;
@property(nonatomic,assign)BOOL update;

@end

@implementation NewsTableViewController
{
    UILabel *nameLabel;
    UIPageControl *pageControl;
    UIView *lebelView;
    NSInteger count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayList = [[NSMutableArray alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    self.update = YES;
    count = 0;
}

- (void)setNewsUrl:(NSString *)newsUrl
{
    _newsUrl = newsUrl;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.update == YES) {
        [self.tableView headerBeginRefreshing];
        self.update = NO;
    }
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"contentStart" object:nil]];
}

// ------下拉刷新
- (void)loadData
{
    [self loadDataForType:1 withURL:self.newsUrl];
}

// ------上拉加载
- (void)loadMoreData
{
    NSString *oldUrl = [NSString stringWithFormat:@"/nc/article/headline/T1348647853363/0-20.html?from=toutiao&passport=&devId=4R70nVFo7N%2FjOGAl7Dql%2BgnhtyYRtyVIqBeGB12xtfEEIz0ZpgPoDMhS%2FpBn8zvR&size=20&version=5.5.0&spever=false&net=wifi&lat=&lon=&ts=1452523392&sign=x95ySVU9uSqwqFbt1Ubd3YUtCuLswI8YQmBBOEJwu2B48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"];
    NSMutableString *newUrl = [[NSMutableString alloc] init];
    if ([self.newsUrl isEqualToString:oldUrl]) {
        count = count + 10;
    }
    else
        count = count + 20;
    NSArray *arr = [self.newsUrl componentsSeparatedByString:@"0-20.html"];
    [newUrl appendString:arr[0]];
    [newUrl appendString:[NSString stringWithFormat:@"%ld-20.html",count]];
    [newUrl appendString:arr[1]];
    [self loadDataForType:2 withURL:newUrl];
}

- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    [[[NetworkTools sharedNetworkTools] GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        NSLog(@"%@",allUrlstring);
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        if (type == 1) {
            [self.arrayList removeAllObjects];
            [self.arrayList addObjectsFromArray:temArray];
            [self createHeaderView:_arrayList];
            NSString *prompt = [[_arrayList objectAtIndex:0] objectForKey:@"prompt"];
            if (prompt != nil && ![prompt isEqualToString:@""]) {
                [self addLabel:prompt];
                [self performSelector:@selector(showLableView) withObject:nil afterDelay:0.8];
            }
            [self.tableView headerEndRefreshing];
            [self.tableView reloadData];
        }else if(type == 2){
            [self.arrayList addObjectsFromArray:temArray];
            
            [self.tableView footerEndRefreshing];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }] resume];
}

-(void)showLableView
{
    [UIView animateWithDuration:0.8 animations:^{
        lebelView.hidden = NO;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideLableView) withObject:nil afterDelay:1];
    }];
}

-(void)hideLableView
{
    [UIView animateWithDuration:0.8 animations:^{
        lebelView.hidden = YES;
    } completion:^(BOOL finished) {
        nil;
    }];
}

-(void)addLabel:(NSString *)str
{
    lebelView = nil;
    lebelView = [Helper view:[UIColor colorWithWhite:1 alpha:0.8] nightColor:[UIColor colorWithWhite:1 alpha:0.8]];
    [self.view addSubview:lebelView];
    lebelView.hidden = YES;
    lebelView.frame = CGRectMake(0, 0, [Helper screenWidth], 30);
    
    UILabel *label = [Helper label:str font:[UIFont systemFontOfSize:14] textColor:[UIColor colorWithRed:0.0 green:105.0/255.0 blue:210.0/255.0 alpha:1.0] nightTextColor:[UIColor colorWithRed:0.0 green:195.0/255.0 blue:255.0/255.0 alpha:1.0] textAligment:NSTextAlignmentCenter];
    [lebelView addSubview:label];
    label.frame = CGRectMake(10, 0, [Helper screenWidth]-20, 30);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createHeaderView:(NSMutableArray *)arr
{
    UIView *headerView = [Helper view:[UIColor clearColor] nightColor:[UIColor clearColor]];
    headerView.frame = CGRectMake(0, 0, [Helper screenWidth], 200);
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    NSDictionary *dic;
    if ([[_arrayList objectAtIndex:0] objectForKey:@"ads"]!=nil) {
        NSDictionary *tempDic = [_arrayList objectAtIndex:0];
        [tempArr addObjectsFromArray:[tempDic objectForKey:@"ads"]];
        dic = tempArr[0];
        UIScrollView *imgScr = [[UIScrollView alloc] init];
        imgScr.frame = headerView.bounds;
        imgScr.contentSize = CGSizeMake([Helper screenWidth]*tempArr.count, 200);
        imgScr.pagingEnabled = YES;
        imgScr.delegate = self;
        imgScr.showsHorizontalScrollIndicator = NO;
        imgScr.bounces = NO;
        [headerView addSubview:imgScr];
        
        for (int i=0; i<tempArr.count; i++) {
            NSDictionary *dic = tempArr[i];
            UIImageView *img = [[UIImageView alloc] init];
            img.frame = CGRectMake([Helper screenWidth]*i, 0, [Helper screenWidth], 200);
            [img sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgsrc"]] placeholderImage:nil];
            [imgScr addSubview:img];
        }
        
        pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = tempArr.count;
        pageControl.currentPageIndicatorTintColor = BASERED;
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [headerView addSubview:pageControl];
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(headerView).offset(-30);
            make.centerX.equalTo(headerView);
            make.size.sizeOffset(CGSizeMake(100, 30));
        }];
    }
    else{
        dic = [_arrayList objectAtIndex:0];
        UIImageView *img = [[UIImageView alloc] init];
        img.frame = CGRectMake(0, 0, [Helper screenWidth], 200);
        [img sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgsrc"]] placeholderImage:nil];
        [headerView addSubview:img];
    }
    
    UIView *titleView = [Helper view:[UIColor blackColor] nightColor:[UIColor blackColor]];
    titleView.alpha = 0.1;
    [headerView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headerView);
        make.height.offset(30);
    }];
    
    UIImageView *tagImg = [Helper imageView:@"night_photoset_list_cell_icon@2x"];
    [headerView addSubview:tagImg];
    [tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(10);
        make.bottom.equalTo(headerView).offset(-7);
        make.size.sizeOffset(CGSizeMake(16, 16));
    }];
    
    nameLabel = [Helper label:[dic objectForKey:@"title"] font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft];
    [headerView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagImg.mas_right).offset(5);
        make.centerY.equalTo(tagImg);
        make.height.offset(30);
        make.right.equalTo(headerView).offset(-10);
    }];
    
    self.tableView.tableHeaderView = nil;
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.arrayList[indexPath.row+1];
    NewsModel *newsModel = [NewsModel objectWithKeyValues:dic];
    
    static NSString *cellName = @"cell";
    
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    NSArray *nib;
    if ([newsModel.imgType integerValue]==1) {
        nib = [[NSBundle mainBundle]loadNibNamed:@"BigPhotoCell" owner:self options:nil];
    }
    else if (newsModel.imgextra){
        nib = [[NSBundle mainBundle]loadNibNamed:@"ImagesCell" owner:self options:nil];
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
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.arrayList[indexPath.row+1];
    NewsModel *newsModel = [NewsModel objectWithKeyValues:dic];
    CGSize titleSize = [newsModel.title boundingRectWithSize:CGSizeMake([Helper screenWidth]-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGSize descSize = [newsModel.digest boundingRectWithSize:CGSizeMake([Helper screenWidth]-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    if ([newsModel.imgType integerValue]==1) {
        if (newsModel.editor != nil && newsModel.editor.count>0){
            if ([newsModel.replyCount intValue]>0) {
                return 228.5+titleSize.height;
            }
            else{
                if (newsModel.TAG || [newsModel.skipType isEqualToString:@"photoset"] || [newsModel.skipType isEqualToString:@"special"]) {
                    return 216.5+descSize.height+titleSize.height;
                }
                return 198.5+descSize.height+titleSize.height;
            }
        }
        else{
            if ([newsModel.replyCount intValue]>0) {
                return 216.5+titleSize.height;
            }
            else{
                if (newsModel.TAG || [newsModel.skipType isEqualToString:@"photoset"] || [newsModel.skipType isEqualToString:@"special"]) {
                    return 204.5+descSize.height+titleSize.height;
                }
                return 186.5+descSize.height+titleSize.height;
            }
        }
    }
    else if (newsModel.imgextra){
        return 128.5+titleSize.height;
    }
    else{
        return 95.5;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    NSDictionary *dic = self.arrayList[indexPath.row+1];
    NewsModel *newsModel = [NewsModel objectWithKeyValues:dic];
    if (newsModel.skipType) {
        if ([newsModel.skipType isEqualToString:@"photoset"]) {
            PhotosetViewController *pvc = [[PhotosetViewController alloc] init];
            pvc.newsModel = newsModel;
            [self.navigationController pushViewController:pvc animated:YES];
        }
        else if ([newsModel.skipType isEqualToString:@"special"]) {
            SepecialViewController *svc = [[SepecialViewController alloc] init];
            svc.newsModel = newsModel;
            [self.navigationController pushViewController:svc animated:YES];
        }
    }
    else if (newsModel.TAG && [newsModel.TAG isEqualToString:@"独家"]){
        WebViewViewController *wvc = [[WebViewViewController alloc] init];
        wvc.newsModel = newsModel;
        [self.navigationController pushViewController:wvc animated:YES];
    }
    else {
        NewsDetailViewController *ndvc = [[NewsDetailViewController alloc] init];
        ndvc.newsModel = newsModel;
        [self.navigationController pushViewController:ndvc animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSDictionary *dic = [_arrayList objectAtIndex:0];
    int offset = scrollView.contentOffset.x/[Helper screenWidth];
    nameLabel.text = [[[dic objectForKey:@"ads"] objectAtIndex:offset] objectForKey:@"title"];
    pageControl.currentPage = offset;
}

@end
