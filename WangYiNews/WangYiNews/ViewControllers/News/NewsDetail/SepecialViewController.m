//
//  SepecialViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "SepecialViewController.h"
#import "SepecialSortModel.h"
#import "SepecialContentModel.h"
#import "SepecialCell.h"
#import "SepecialModel.h"

@interface SepecialViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *moreStr;
@property (nonatomic, strong) SepecialModel *sepcialModel;

@end

@implementation SepecialViewController
{
    UITableView *_sepecialTableView;
    NSMutableArray *_contentArr;
    NSMutableArray *_videoArr;
    UILabel *_moreLab;
    CGFloat headerViewHeight;
    CGFloat lastHeaderViewHeight;
    UIView *headerView;
    UILabel *nameLabel;
    UIImageView *tagImg;
    UILabel *_titleLabel;
}

-(void)setMoreStr:(NSString *)moreStr
{
    _moreStr = moreStr;
    _moreLab.text = _moreStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self createNavigation];
    [self crateTableView];
    [_sepecialTableView headerBeginRefreshing];
    headerViewHeight = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    NSString *url = [NSString stringWithFormat:@"/nc/special/%@.html",self.newsModel.skipID];
    [[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [_sepecialTableView headerEndRefreshing];
        NSDictionary *dic = [responseObject objectForKey:self.newsModel.skipID];
        _sepcialModel = [SepecialModel objectWithKeyValues:dic];
        _titleLabel.text = _sepcialModel.sname;
        [self loadArrData];
        [self tableViewHeaderView];
        _sepecialTableView.tableHeaderView = headerView;
        [_sepecialTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [_sepecialTableView headerEndRefreshing];
        NSLog(@"%@",error);
    }];
}

-(void)createNavigation
{
    UIView *navView = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.height.offset(64);
    }];
    
    _titleLabel = [Helper label:@"网易专题" font:[UIFont systemFontOfSize:18] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.height.offset(44);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *backBtn = [Helper button:@"top_navigation_back@2x" target:self action:@selector(backBtn) tag:0];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(54, 44));
    }];
    
    UIButton *shareBtn = [Helper button:@"top_navigation_shareicon@2x" target:self action:@selector(shareBtn) tag:0];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(54, 44));
    }];
}

-(void)loadArrData
{
    _contentArr = [[NSMutableArray alloc] init];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [temp addObjectsFromArray:[self loadModel:_sepcialModel.topics]];
    [temp addObjectsFromArray:[self loadModel:_sepcialModel.topicslatest]];
    [temp addObjectsFromArray:[self loadModel:_sepcialModel.topicspatch]];
    [temp addObjectsFromArray:[self loadModel:_sepcialModel.topicsplus]];
    for (int i=1; i<=temp.count; i++) {
        for (SepecialSortModel *sm in temp){
            if ([sm.index integerValue] == i) {
                [_contentArr addObject:sm];
                break;
            }
        }
    }
    _videoArr = [[NSMutableArray alloc] init];
    for (SepecialSortModel *sm in _contentArr){
        if ([sm.type isEqualToString:@"photoset"] || [sm.type isEqualToString:@"video"]) {
            NSInteger count = 0;
            count = sm.docs.count/2 + sm.docs.count%2;
            for (int i=0; i<count; i++) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                int x = 0;
                for (int j=0; j<x+2&&j<sm.docs.count; j++) {
                    NSDictionary *dic = [sm.docs objectAtIndex:j];
                    SepecialContentModel *cm = [SepecialContentModel objectWithKeyValues:dic];
                    [arr addObject:cm];
                }
                [_videoArr addObject:arr];
            }
        }
    }
}

-(NSMutableArray *)loadModel:(NSArray *)arr
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    if (arr.count>0) {
        for (NSDictionary *dic in arr){
            SepecialSortModel *sm = [SepecialSortModel objectWithKeyValues:dic];
            [tempArr addObject:sm];
        }
    }
    return tempArr;
}

#pragma mark-------------------TableView-------------
-(void)tableViewHeaderView
{
    headerViewHeight = 0.0;
    
    headerView = [[UIView alloc] init];
    if (_sepcialModel.banner!=nil && ![_sepcialModel.banner isEqualToString:@""]) {
        UIImageView *banner = [[UIImageView alloc] init];
        [banner sd_setImageWithURL:[NSURL URLWithString:_sepcialModel.banner]];
        [headerView addSubview:banner];
        [banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.mas_equalTo(headerView);
            make.height.offset(65);
        }];
        headerViewHeight = headerViewHeight + 65;
    }
    if (_sepcialModel.headpics.count>0) {
        UIScrollView *scr = [[UIScrollView alloc] init];
        scr.frame = CGRectMake(0, headerViewHeight, [Helper screenWidth], 216);
        scr.contentSize = CGSizeMake([Helper screenWidth]*_sepcialModel.headpics.count, 216);
        scr.showsHorizontalScrollIndicator = NO;
        scr.pagingEnabled = YES;
        scr.bounces = NO;
        [headerView addSubview:scr];
        for (int i=0; i<_sepcialModel.headpics.count; i++) {
            UIImageView *img = [[UIImageView alloc] init];
            img.frame = CGRectMake([Helper screenWidth]*i, 0, [Helper screenWidth], 216);
            [img sd_setImageWithURL:[NSURL URLWithString:[[_sepcialModel.headpics objectAtIndex:i] objectForKey:@"imgsrc"]]];
            [scr addSubview:img];
            UIView *titleView = [Helper view:[UIColor blackColor] nightColor:[UIColor blackColor]];
            titleView.alpha = 0.1;
            titleView.frame = CGRectMake([Helper screenWidth]*i, 186, [Helper screenWidth], 30);
            [scr addSubview:titleView];
            
            if ([[[_sepcialModel.headpics objectAtIndex:i] objectForKey:@"tag"] isEqualToString:@"photoset"]) {
                tagImg = [Helper imageView:@"night_photoset_list_cell_icon@2x"];
                [titleView addSubview:tagImg];
                [tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(headerView).offset(10);
                    make.bottom.equalTo(headerView).offset(-7);
                    make.size.sizeOffset(CGSizeMake(16, 16));
                }];
            }
            else if ([[[_sepcialModel.headpics objectAtIndex:i] objectForKey:@"tag"] isEqualToString:@"link"]) {
                UILabel *linkLabel = [Helper label:@"推广" font:[UIFont systemFontOfSize:11] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
                linkLabel.layer.cornerRadius = 3;
                linkLabel.layer.borderColor = [UIColor whiteColor].CGColor;
                linkLabel.layer.borderWidth = 0.3;
                [titleView addSubview:linkLabel];
                [linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(headerView).offset(10);
                    make.bottom.equalTo(headerView);
                    make.size.sizeOffset(CGSizeMake(35, 30));
                }];
            }
            nameLabel = [Helper label:[[_sepcialModel.headpics objectAtIndex:i] objectForKey:@"title"] font:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft];
            [titleView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if ([[[_sepcialModel.headpics objectAtIndex:0] objectForKey:@"tag"] isEqualToString:@"photoset"]){
                    make.left.equalTo(titleView).offset(31);
                }
                else if ([[[_sepcialModel.headpics objectAtIndex:0] objectForKey:@"tag"] isEqualToString:@"link"]) {
                    make.left.equalTo(titleView).offset(50);
                }
                else
                    make.left.equalTo(titleView).offset(10);
                make.bottom.equalTo(titleView);
                make.height.offset(30);
                make.right.equalTo(titleView).offset(-10);
            }];
        }
        
        headerViewHeight = 216+headerViewHeight;
    }
    if (_sepcialModel.digest.length>0) {
        UILabel *digst = [[UILabel alloc] init];
        digst.text = _sepcialModel.digest;
        digst.font = [UIFont systemFontOfSize:13];
        digst.textColor = [UIColor grayColor];
        CGSize digistSize = [digst.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-35, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        digst.numberOfLines = 0;
        digst.lineBreakMode = NSLineBreakByWordWrapping;
        digst.frame = CGRectMake(25, headerViewHeight + 10, [Helper screenWidth]-35, digistSize.height);
        [headerView addSubview:digst];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, headerViewHeight + 7, 5, digistSize.height + 6)];
        line.backgroundColor = GRAYCOLOR;
        [headerView addSubview:line];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, headerViewHeight + digistSize.height + 21.5, [Helper screenWidth], 0.5)];
        line1.backgroundColor = GRAYCOLOR;
        [headerView addSubview:line1];
        
        headerViewHeight = headerViewHeight + digistSize.height + 22;
    }
    if (_sepcialModel.webviews.count>0) {
        UIView *web = [Helper view:[UIColor whiteColor] nightColor:NIGHTBACKGROUNDCOLOR];
        web.frame = CGRectMake(0, headerViewHeight, [Helper screenWidth], 40);
        [headerView addSubview:web];
        
        for (int i =0; i<_sepcialModel.webviews.count; i++) {
            UIView *view = [self addWebCotent:[[_sepcialModel.webviews objectAtIndex:i] objectForKey:@"title"] image:[[_sepcialModel.webviews objectAtIndex:i] objectForKey:@"pic"] index:i count:_sepcialModel.webviews.count];
            [web addSubview:view];
        }
        for (int i=0; i<_sepcialModel.webviews.count-1; i++) {
            UIView *line = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
            [web addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.sizeOffset(CGSizeMake(0.5, 15));
                make.centerY.equalTo(web);
                make.left.equalTo(web).offset(([Helper screenWidth]-(0.5*(_sepcialModel.webviews.count-1)))/3*(i+1)+0.5*i);
            }];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, [Helper screenWidth], 0.5)];
        line.backgroundColor = GRAYCOLOR;
        [web addSubview:line];
        
        headerViewHeight = headerViewHeight + 40;
    }
    lastHeaderViewHeight = headerViewHeight;
    if (_contentArr.count>2) {
        if (_contentArr.count<=8) {
            for (int i=0; i<_contentArr.count; i++) {
                [self addShortNameButton:((SepecialSortModel *)[_contentArr objectAtIndex:i]).shortname index:i totalY:headerViewHeight];
            }
        }
        else {
            for (int i=0; i<7; i++) {
                [self addShortNameButton:((SepecialSortModel *)[_contentArr objectAtIndex:i]).shortname index:i totalY:headerViewHeight];
            }
            [self setMoreStr:@"更多"];
            [self addShortNameButton:_moreStr index:7 totalY:headerViewHeight];
        }
        if (_contentArr.count>4){
            headerViewHeight = headerViewHeight + 10 + 40*2;
        }
        else{
            headerViewHeight = headerViewHeight + 10 + 40*1;
        }
    }
    headerView.frame = CGRectMake(0, 0, [Helper screenWidth], headerViewHeight);
}

-(UIView *)addWebCotent:(NSString *)name image:(NSString *)img index:(NSInteger)index count:(NSInteger)count
{
    UIView *view = [Helper view:[UIColor whiteColor] nightColor:NIGHTBACKGROUNDCOLOR];
    view.frame = CGRectMake([Helper screenWidth]/count*index, 0, [Helper screenWidth]/count, 40);
    
    UILabel *label = [Helper label:name font:[UIFont systemFontOfSize:11] textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentLeft];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view).offset(9);
        make.centerY.equalTo(view);
    }];
    
    UIImageView *image = [[UIImageView alloc] init];
    [image sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil];
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label.mas_left).offset(-2);
        make.centerY.equalTo(label);
        make.size.sizeOffset(CGSizeMake(18, 18));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.bounds;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(loadWebView:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = index;
    [view addSubview:btn];
    
    return view;
}

-(void)addShortNameButton:(NSString *)shortName index:(NSInteger)index totalY:(CGFloat)totalY
{
    CGFloat X = 10+index%4*(([Helper screenWidth]-300)/3+70);
    CGFloat Y = index/4*40+10 + totalY;
    CGFloat Width = 70;
    CGFloat Height = 30;
    if (_contentArr.count > 8 && index == 7) {
        _moreLab = [Helper label:shortName font:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
        _moreLab.frame = CGRectMake(X, Y, Width, Height);
        [headerView addSubview:_moreLab];
    }
    else {
        UILabel *shortNameLab = [Helper label:shortName font:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
        shortNameLab.frame = CGRectMake(X, Y, Width, Height);
        [headerView addSubview:shortNameLab];
    }
    UIButton *shortNameBtn = [Helper button:@"specialcell_nav_btn@2x" target:self action:@selector(shortNameBtnClick:) tag:index];
    shortNameBtn.frame = CGRectMake(X, Y, Width, Height);
    [headerView addSubview:shortNameBtn];
}

-(void)crateTableView
{
    _sepecialTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [Helper screenWidth], [Helper screenHeight]-64) style:UITableViewStylePlain];
    [_sepecialTableView addHeaderWithTarget:self action:@selector(loadData)];
    _sepecialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _sepecialTableView.delegate = self;
    _sepecialTableView.dataSource = self;
    [self.view addSubview:_sepecialTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _contentArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SepecialSortModel *sortModel = [_contentArr objectAtIndex:section];
    if ([sortModel.type isEqualToString:@"video"] || [sortModel.type isEqualToString:@"photoset"]) {
        return _videoArr.count;
    }
    return ((SepecialSortModel *)[_contentArr objectAtIndex:section]).docs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SepecialSortModel *sortModel = [_contentArr objectAtIndex:indexPath.section];
    NSDictionary *dic = [sortModel.docs objectAtIndex:indexPath.row];
    SepecialContentModel *contentModel = [SepecialContentModel objectWithKeyValues:dic];
    static NSString *cellName = @"cell";
    SepecialCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    NSArray *nib;
    if ([sortModel.type isEqualToString:@"imgnews"]) {
        if ([contentModel.imgType integerValue] == 1) {
            nib = [[NSBundle mainBundle]loadNibNamed:@"SepecialBigPhoto" owner:self options:nil];
        }
        else if (contentModel.imgextra.count>0){
            nib = [[NSBundle mainBundle]loadNibNamed:@"SepecialImages" owner:self options:nil];
        }
        else{
            nib = [[NSBundle mainBundle]loadNibNamed:@"SepecialBasic" owner:self options:nil];
        }
    }
    else if ([sortModel.type isEqualToString:@"vote"]) {
        
    }
    else if ([sortModel.type isEqualToString:@"video"] || [sortModel.type isEqualToString:@"photoset"]) {
        nib = [[NSBundle mainBundle]loadNibNamed:@"SepecialVideo" owner:self options:nil];
    }
    else if ([sortModel.type isEqualToString:@"timeline"]) {
        
    }
    for(id oneObject in nib){
        if([oneObject isKindOfClass:[SepecialCell class]]){
            cell = (SepecialCell *)oneObject;
        }
    }
    if ([sortModel.type isEqualToString:@"video"] || [sortModel.type isEqualToString:@"photoset"]) {
        NSMutableArray *arr = [_videoArr objectAtIndex:indexPath.row];
        if ([sortModel.type isEqualToString:@"video"]) {
            cell.imgplay1.hidden = NO;
            cell.imgplay2.hidden = NO;
        }
        else{
            cell.imgplay1.hidden = YES;
            cell.imgplay2.hidden = YES;
        }
        cell.digst1.text = ((SepecialContentModel *) [arr objectAtIndex:0]).title;
        cell.digst2.text = ((SepecialContentModel *) [arr objectAtIndex:1]).title;
        [cell.imgsrc1 sd_setImageWithURL:[NSURL URLWithString:((SepecialContentModel *) [arr objectAtIndex:0]).cover]];
        [cell.imgsrc2 sd_setImageWithURL:[NSURL URLWithString:((SepecialContentModel *) [arr objectAtIndex:1]).cover]];
    }
    cell.contentModel = contentModel;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SepecialSortModel *sortModel = [_contentArr objectAtIndex:indexPath.section];
    NSDictionary *dic = [sortModel.docs objectAtIndex:indexPath.row];
    SepecialContentModel *contentModel = [SepecialContentModel objectWithKeyValues:dic];
    CGSize titleSize = [contentModel.title boundingRectWithSize:CGSizeMake([Helper screenWidth]-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGSize descSize = [contentModel.digest boundingRectWithSize:CGSizeMake([Helper screenWidth]-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    if ([sortModel.type isEqualToString:@"imgnews"]) {
        if ([contentModel.imgType integerValue] == 1) {
            if ([contentModel.replyCount intValue]>0) {
                return 216.5+titleSize.height;
            }
            else{
                return 186.5+descSize.height+titleSize.height;
            }
        }
        else if (contentModel.imgextra.count>0){
            return 128.5+titleSize.height;
        }
        else{
            return 95.5;
        }
    }
    else if ([sortModel.type isEqualToString:@"video"] || [sortModel.type isEqualToString:@"photoset"]) {
        return ([Helper screenWidth]-30)/2+45;
    }
    else
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Helper screenWidth], 30)];
    view.backgroundColor = LINECOLOR;
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, 0, 20, 30);
    lab.text = [NSString stringWithFormat:@"%ld",section+1];
    lab.textAlignment = NSTextAlignmentRight;
    lab.textColor = BASERED;
    lab.font = [UIFont systemFontOfSize:12];
    [view addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.frame = CGRectMake(20, 0, [Helper screenWidth]-40, 30);
    lab1.text = [NSString stringWithFormat:@"/%ld %@",_contentArr.count,((SepecialSortModel *)_contentArr[section]).tname];
    lab1.font = [UIFont systemFontOfSize:12];
    [view addSubview:lab1];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareBtn
{
    
}

-(void)shortNameBtnClick:(UIButton *)btn
{
    if (_contentArr.count<=8) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:btn.tag];
        [_sepecialTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else{
        SepecialSortModel *sm = [_contentArr objectAtIndex:btn.tag];
        if (btn.tag == 7) {
            [self setMoreStr:sm.shortname];
            for (int i=8; i<_contentArr.count; i++) {
                [self addShortNameButton:((SepecialSortModel *)[_contentArr objectAtIndex:i]).shortname index:i totalY:lastHeaderViewHeight];
            }
            NSInteger count = _contentArr.count-8;
            if (count%4==0) {
                headerViewHeight = headerViewHeight + 40*(count/4);
            }
            else{
                headerViewHeight = headerViewHeight + 40*(count/4 + 1);
            }
            [UIView animateWithDuration:0.1 animations:^{
                headerView.frame = CGRectMake(0, 0, [Helper screenWidth], headerViewHeight);
            } completion:^(BOOL finished) {
                _sepecialTableView.tableHeaderView = headerView;
                [_sepecialTableView reloadData];
            }];
        }
        else{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:btn.tag];
            [_sepecialTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

-(void)loadWebView:(UIButton *)btn
{
    
}

@end
