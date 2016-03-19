//
//  ExpertViewController.m
//  WangYiNews
//
//  Created by lifangli on 16/1/6.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import "ExpertViewController.h"
#import "ExpertModel.h"
#import "QuestionCell.h"
#import "QuestionModel.h"
#import "AnswerModel.h"

@interface ExpertViewController ()

@property(strong, nonatomic)NSMutableArray *hotList;
@property(strong, nonatomic)NSMutableArray *latestList;
@property(nonatomic, assign, getter=isDetailShow) BOOL detailShow;

@end

@implementation ExpertViewController
{
    UITableView *_questionAndAnswerTableView;
    ExpertModel *_expertModel;
    UIButton *hotBtn;
    UIButton *latestBtn;
    CGFloat height;
    UIView *_tableHeaderView;
    UILabel *_alias;
    CGSize aliasSize;
    UIActivityIndicatorView *testActivityIndicator;
    UIActivityIndicatorView *activityIndicator;
    NSInteger count;
    UILabel *_loadingLabel;
    BOOL isHot;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _hotList = [[NSMutableArray alloc] init];
    _latestList = [[NSMutableArray alloc] init];
    height = 0;
    count = 0;
    isHot = YES;
    [self createNaviButton];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    NSString *url = [NSString stringWithFormat:@"/newstopic/qa/%@.html",self.expertId];
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        [testActivityIndicator stopAnimating];
        NSDictionary *tempDic = [responseObject objectForKey:@"data"];
        _expertModel = [ExpertModel objectWithKeyValues:[tempDic objectForKey:@"expert"]];
        _expertModel.desc = [[tempDic objectForKey:@"expert"] objectForKey:@"description"];
        [_hotList removeAllObjects];
        [_latestList removeAllObjects];
        [_hotList addObjectsFromArray:[tempDic objectForKey:@"hotList"]];
        [_latestList addObjectsFromArray:[tempDic objectForKey:@"latestLiat"]];
        [self createTableView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [testActivityIndicator stopAnimating];
        NSLog(@"%@",error);
    }] resume];
}

-(void)refreshData
{
    NSString *url = isHot?[NSString stringWithFormat:@"/newstopic/list/hotqa/%@/0-10.html",self.expertId]:[NSString stringWithFormat:@"/newstopic/list/latestqa/%@/0-10.html",self.expertId];
    [self loadDataWithType:1 url:url];
}

-(void)loadMoreQuestion
{
    count+=10;
    NSString *url = isHot?[NSString stringWithFormat:@"/newstopic/list/hotqa/%@/%ld-10.html",self.expertId,count]:[NSString stringWithFormat:@"/newstopic/list/latestqa/%@/%ld-10.html",self.expertId,count];
    [self loadDataWithType:2 url:url];
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        if (type == 1) {
            [activityIndicator stopAnimating];
            [_hotList removeAllObjects];
            [_hotList addObjectsFromArray:[responseObject objectForKey:@"data"]];
        }
        else{
            [_hotList addObjectsFromArray:[responseObject objectForKey:@"data"]];
            [_questionAndAnswerTableView footerEndRefreshing];
        }
        [_questionAndAnswerTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [_questionAndAnswerTableView footerEndRefreshing];
    }] resume];
}

-(void)createTableView
{
    [self createHeaderView];
    [self tableHeaderView];
    _questionAndAnswerTableView = [[UITableView alloc] init];
    _questionAndAnswerTableView.tableHeaderView = _tableHeaderView;
    _questionAndAnswerTableView.delegate = self;
    _questionAndAnswerTableView.dataSource = self;
    [_questionAndAnswerTableView addFooterWithTarget:self action:@selector(loadMoreQuestion)];
    _questionAndAnswerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_questionAndAnswerTableView];
    [_questionAndAnswerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidden = YES;
    [activityIndicator setHidesWhenStopped:YES];
    [self.view addSubview:activityIndicator];
    [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(240+_tableHeaderView.frame.size.height);
    }];
    [self addBootomView];
}

-(void)addBootomView
{
    UIView *bootomView = [Helper view:[UIColor colorWithWhite:0.95 alpha:1.0] nightColor:[UIColor colorWithWhite:0.1 alpha:1.0]];
    [self.view addSubview:bootomView];
    [bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@49);
    }];
    UIView *topLine = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [bootomView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bootomView);
        make.height.equalTo(@0.5);
    }];
    UIView *textView = [Helper view:[UIColor whiteColor] nightColor:NIGHTBACKGROUNDCOLOR];
    textView.layer.borderColor = [Helper isNightMode]?NIGHTGRAYCOLOR.CGColor:GRAYCOLOR.CGColor;
    textView.layer.borderWidth = 0.8;
    textView.layer.cornerRadius = 39/2;
    [bootomView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bootomView).offset(10);
        make.right.equalTo(bootomView).offset(-10);
        make.top.equalTo(bootomView).offset(5);
        make.bottom.equalTo(bootomView).offset(-5);
    }];
    UIImageView *img = [Helper imageView:@"video_comment_pen@2x"];
    [textView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textView).offset(15);
        make.centerY.equalTo(textView);
        make.size.sizeOffset(CGSizeMake(15, 12));
    }];
    UILabel *alert = [Helper label:@"输入你的问题" font:[UIFont systemFontOfSize:14] textColor:[UIColor lightGrayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
    [textView addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(8);
        make.centerY.equalTo(textView);
        make.height.offset(39);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(addQuestion) forControlEvents:UIControlEventTouchUpInside];
    [bootomView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bootomView);
    }];
}

-(void)addQuestionView
{
    
}

-(void)tableHeaderView
{
    _tableHeaderView = [Helper view:[UIColor whiteColor] nightColor:NIGHTBACKGROUNDCOLOR];
    
    UIView *headView = [Helper view:[UIColor clearColor] nightColor:[UIColor clearColor]];
    headView.layer.borderColor = [Helper isNightMode]?NIGHTLINECOLOR.CGColor:LINECOLOR.CGColor;
    headView.layer.borderWidth = 0.5;
    headView.layer.cornerRadius = 21;
    [_tableHeaderView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tableHeaderView).offset(9);
        make.top.equalTo(_tableHeaderView).offset(15);
        make.size.sizeOffset(CGSizeMake(42, 42));
    }];
    UIImageView *headImg = [[UIImageView alloc] init];
    headImg.layer.cornerRadius = 20;
    headImg.layer.masksToBounds = YES;
    [headImg sd_setImageWithURL:[NSURL URLWithString:_expertModel.headpicurl] placeholderImage:[UIImage imageNamed:[Helper isNightMode]?@"night_covernewscell_editor_default@2x":@"covernewscell_editor_default@2x"]];
    [headView addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headView);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    
    UILabel *nickName = [Helper label:_expertModel.name font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
    [_tableHeaderView addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_right).offset(10);
        make.top.equalTo(headView);
        make.height.offset(25);
    }];
    
    UIView *midLine = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [_tableHeaderView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickName.mas_right).offset(8);
        make.centerY.equalTo(nickName);
        make.size.sizeOffset(CGSizeMake(0.5, 15));
    }];
    
    UILabel *classification = [Helper label:_expertModel.title font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
    [_tableHeaderView addSubview:classification];
    [classification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midLine.mas_right).offset(8);
        make.top.equalTo(nickName);
        make.height.offset(25);
    }];
    
    _alias = [Helper label:_expertModel.desc font:[UIFont systemFontOfSize:13] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
    _alias.numberOfLines = 0;
    _alias.lineBreakMode = NSLineBreakByTruncatingTail;
    aliasSize = [_alias.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-71, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_alias.font} context:nil].size;
    [_tableHeaderView addSubview:_alias];
    [_alias mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickName);
        make.right.equalTo(_tableHeaderView).offset(-10);
        make.top.equalTo(nickName.mas_bottom).offset(5);
        if (aliasSize.height>32) {
            make.height.offset(32);
        }
    }];
    if (aliasSize.height>32) {
        UIButton *detailBtn = [Helper button:@"detail_expand_arrow@2x" target:self action:@selector(showDetail) tag:0];
        detailBtn.contentMode = UIViewContentModeCenter;
        [_tableHeaderView addSubview:detailBtn];
        [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_alias.mas_bottom);
            make.centerX.equalTo(_tableHeaderView);
            make.size.sizeOffset(CGSizeMake(40, 38));
        }];
        _tableHeaderView.frame = CGRectMake(0, 0, [Helper screenWidth], 115);
    }
    else{
        _tableHeaderView.frame = CGRectMake(0, 0, [Helper screenWidth], 60+aliasSize.height);
    }
}

-(void)createNaviButton
{
    UIView *back = [Helper view:[UIColor colorWithWhite:0.9 alpha:1] nightColor:[UIColor colorWithWhite:0.02 alpha:1]];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIImageView *img = [Helper imageView:@"photoview_image_default_white@2x"];
    [back addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(320, 70));
    }];
    
    UIButton *backBtn = [Helper button:@"weather_back_highlight@2x" target:self action:@selector(backBtn) tag:0];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UIButton *shareBtn = [Helper button:@"weather_share_highlight@2x" target:self action:@selector(shareBtn) tag:0];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
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

-(void)createHeaderView
{
    UIImageView *img = [[UIImageView alloc] init];
    [img sd_setImageWithURL:[NSURL URLWithString:_expertModel.picurl] placeholderImage:nil];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.offset(200);
    }];
    
    UIButton *backBtn = [Helper button:@"weather_back_highlight@2x" target:self action:@selector(backBtn) tag:0];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UIButton *shareBtn = [Helper button:@"weather_share_highlight@2x" target:self action:@selector(shareBtn) tag:0];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UILabel *title1 = [Helper label:_expertModel.alias font:[UIFont systemFontOfSize:15] textColor:[UIColor colorWithWhite:1 alpha:0] nightTextColor:[UIColor colorWithWhite:1 alpha:0] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(45);
        make.right.equalTo(self.view).offset(-45);
        make.height.offset(44);
    }];
    
    UILabel *title2 = [Helper label:_expertModel.alias font:[UIFont boldSystemFontOfSize:16] textColor:[UIColor colorWithWhite:1 alpha:1] nightTextColor:[UIColor colorWithWhite:1 alpha:1] textAligment:NSTextAlignmentCenter];
    title2.lineBreakMode = NSLineBreakByWordWrapping;
    title2.numberOfLines = 2;
    [self.view addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.mas_bottom);
        make.left.equalTo(title1);
        make.right.equalTo(title1);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *concernCountLab = [Helper label:[NSString stringWithFormat:@"--- %@关注 ---",_expertModel.concernCount] font:[UIFont systemFontOfSize:16] textColor:[UIColor colorWithWhite:1 alpha:1] nightTextColor:[UIColor colorWithWhite:1 alpha:1] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:concernCountLab];
    [concernCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *addConcernBtn = [Helper button:@"qa_concern@2x" target:self action:@selector(addConcernBtn) tag:0];
    [self.view addSubview:addConcernBtn];
    [addConcernBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(concernCountLab.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(95, 30));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hotList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil] lastObject];
    }
    
    //cell.delegate = self;
    NSDictionary *dic = [_hotList objectAtIndex:indexPath.row];
    QuestionModel *qm = [QuestionModel objectWithKeyValues:[dic objectForKey:@"question"]];
    AnswerModel *am = [AnswerModel objectWithKeyValues:[dic objectForKey:@"answer"]];
    [cell setAnswerModel:am];
    [cell setQuestionModel:qm];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_hotList objectAtIndex:indexPath.row];
    QuestionModel *qm = [QuestionModel objectWithKeyValues:[dic objectForKey:@"question"]];
    AnswerModel *am = [AnswerModel objectWithKeyValues:[dic objectForKey:@"answer"]];
    CGSize questSize = [qm.content boundingRectWithSize:CGSizeMake([Helper screenWidth]-58, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CGSize answerSize = [am.content boundingRectWithSize:CGSizeMake([Helper screenWidth]-58, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return 155.5+questSize.height+answerSize.height;
}

-(UIView *)sectionHeaderView
{
    UIView *view;
    if (view == nil) {
        view = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
        view.frame = CGRectMake(0, 0, [Helper screenWidth], 30);
        
        UILabel *countLab = [Helper label:[NSString stringWithFormat:@"%@提问 . %@回复",_expertModel.questionCount,_expertModel.answerCount] font:[UIFont systemFontOfSize:13] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
        [view addSubview:countLab];
        [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(10);
            make.top.bottom.equalTo(view);
        }];
        
        UIView *segView = [Helper view:[UIColor clearColor] nightColor:[UIColor clearColor]];
        segView.layer.cornerRadius = 4;
        segView.layer.borderWidth = 0.8;
        segView.layer.borderColor = [Helper isNightMode]?BASERED_NIGHT.CGColor:BASERED.CGColor;
        [view addSubview:segView];
        [segView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(-10);
            make.top.equalTo(view).offset(4);
            make.bottom.equalTo(view).offset(-4);
            make.width.offset(80);
        }];
        
        hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hotBtn.dk_backgroundColorPicker = isHot?DKColorWithColors(BASERED, BASERED_NIGHT):DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]);
        hotBtn.layer.cornerRadius = 3;
        [hotBtn setTitle:@"最热" forState:UIControlStateNormal];
        hotBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [hotBtn dk_setTitleColorPicker:DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]) forState:UIControlStateSelected];
        [hotBtn dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateNormal];
        hotBtn.selected = isHot;
        [hotBtn addTarget:self action:@selector(hotBtn) forControlEvents:UIControlEventTouchUpInside];
        [segView addSubview:hotBtn];
        [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(segView);
            make.width.offset(40);
        }];
        
        latestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        latestBtn.dk_backgroundColorPicker = isHot?DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]):DKColorWithColors(BASERED, BASERED_NIGHT);
        latestBtn.layer.cornerRadius = 3;
        latestBtn.selected = !isHot;
        [latestBtn setTitle:@"最新" forState:UIControlStateNormal];
        latestBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [latestBtn dk_setTitleColorPicker:DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]) forState:UIControlStateSelected];
        [latestBtn dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateNormal];
        [latestBtn addTarget:self action:@selector(latestBtn) forControlEvents:UIControlEventTouchUpInside];
        [segView addSubview:latestBtn];
        [latestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(segView);
            make.width.offset(40);
        }];
    }
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)showDetail
{
    if (self.isDetailShow) {
        [_alias mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(32);
        }];
        [_alias layoutIfNeeded];
        _tableHeaderView.frame = CGRectMake(0, 0, [Helper screenWidth], 115);
    }
    else{
        [_alias mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(aliasSize.height+2);
        }];
        [_alias layoutIfNeeded];
        _tableHeaderView.frame = CGRectMake(0, 0, [Helper screenWidth], 83+aliasSize.height);
    }
    _questionAndAnswerTableView.tableHeaderView = nil;
    _questionAndAnswerTableView.tableHeaderView = _tableHeaderView;
    [_questionAndAnswerTableView reloadData];
    self.detailShow = !self.isDetailShow;
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareBtn
{
    
}

-(void)addConcernBtn
{}

-(void)hotBtn
{
    isHot = YES;
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    [self refreshData];
}

-(void)latestBtn
{
    isHot = NO;
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    [self refreshData];
}

-(void)addQuestion
{
    
}

@end
