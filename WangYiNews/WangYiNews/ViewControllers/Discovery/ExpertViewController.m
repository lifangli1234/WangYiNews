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

@end

@implementation ExpertViewController
{
    UIView *_headView;
    UITableView *_questionAndAnswerTableView;
    ExpertModel *_expertModel;
    UIButton *hotBtn;
    UIButton *latestBtn;
    CGFloat height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    _hotList = [[NSMutableArray alloc] init];
    _latestList = [[NSMutableArray alloc] init];
    height = 0;
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
        NSDictionary *tempDic = [responseObject objectForKey:@"data"];
        _expertModel = [ExpertModel objectWithKeyValues:[tempDic objectForKey:@"expert"]];
        [_hotList removeAllObjects];
        [_latestList removeAllObjects];
        [_hotList addObjectsFromArray:[tempDic objectForKey:@"hotList"]];
        [_latestList addObjectsFromArray:[tempDic objectForKey:@"latestLiat"]];
        [self createTableView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}

-(void)loadMoreQuestion
{
    
}

-(void)createTableView
{
    [self createHeaderView];
    _questionAndAnswerTableView = [[UITableView alloc] init];
    _questionAndAnswerTableView.delegate = self;
    _questionAndAnswerTableView.dataSource = self;
    [_questionAndAnswerTableView addFooterWithTarget:self action:@selector(loadMoreQuestion)];
    _questionAndAnswerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_questionAndAnswerTableView];
    [_questionAndAnswerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}


-(void)createHeaderView
{
    _headView = [Helper view:[UIColor clearColor] nightColor:[UIColor clearColor]];
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    [self addCotentForHeaderView];
}

-(void)addCotentForHeaderView
{
    UIImageView *img = [[UIImageView alloc] init];
    [img sd_setImageWithURL:[NSURL URLWithString:_expertModel.picurl] placeholderImage:nil];
    [_headView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headView);
    }];
    
    UIButton *backBtn = [Helper button:@"weather_back@2x" target:self action:@selector(backBtn) tag:0];
    [_headView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView);
        make.top.equalTo(_headView).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UIButton *shareBtn = [Helper button:@"qa_share_normal@2x" target:self action:@selector(shareBtn) tag:0];
    [_headView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headView);
        make.top.equalTo(_headView).offset(20);
        make.size.sizeOffset(CGSizeMake(45, 44));
    }];
    
    UILabel *title1 = [Helper label:_expertModel.alias font:[UIFont systemFontOfSize:15] textColor:[UIColor colorWithWhite:1 alpha:0] nightTextColor:[UIColor colorWithWhite:1 alpha:0] textAligment:NSTextAlignmentCenter];
    [_headView addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView).offset(20);
        make.left.equalTo(backBtn.mas_right);
        make.right.equalTo(shareBtn.mas_left);
        make.height.offset(44);
    }];
    
    UILabel *title2 = [Helper label:_expertModel.alias font:[UIFont boldSystemFontOfSize:16] textColor:[UIColor colorWithWhite:1 alpha:1] nightTextColor:[UIColor colorWithWhite:1 alpha:1] textAligment:NSTextAlignmentCenter];
    title2.lineBreakMode = NSLineBreakByWordWrapping;
    title2.numberOfLines = 2;
    [_headView addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.mas_bottom);
        make.left.equalTo(backBtn.mas_right);
        make.right.equalTo(shareBtn.mas_left);
        make.centerX.equalTo(_headView);
    }];
    
    UILabel *concernCountLab = [Helper label:[NSString stringWithFormat:@"--- %@关注 ---",_expertModel.concernCount] font:[UIFont systemFontOfSize:16] textColor:[UIColor colorWithWhite:1 alpha:1] nightTextColor:[UIColor colorWithWhite:1 alpha:1] textAligment:NSTextAlignmentCenter];
    [_headView addSubview:concernCountLab];
    [concernCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.mas_bottom).offset(10);
        make.centerX.equalTo(_headView);
    }];
    
    UIButton *addConcernBtn = [Helper button:@"qa_concern@2x" target:self action:@selector(addConcernBtn) tag:0];
    [_headView addSubview:addConcernBtn];
    [addConcernBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(concernCountLab.mas_bottom).offset(10);
        make.centerX.equalTo(_headView);
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
    if (answerSize.height > 51) {
        return 155.5+questSize.height+51;
    }
    else{
        return 155.5+questSize.height+answerSize.height;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [Helper view:LINECOLOR nightColor:NIGHTLINECOLOR];
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
    hotBtn.dk_backgroundColorPicker = DKColorWithColors(BASERED, BASERED_NIGHT);
    hotBtn.layer.cornerRadius = 3;
    [hotBtn setTitle:@"最热" forState:UIControlStateNormal];
    hotBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [hotBtn dk_setTitleColorPicker:DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]) forState:UIControlStateSelected];
    [hotBtn dk_setTitleColorPicker:DKColorWithColors(BASERED, BASERED_NIGHT) forState:UIControlStateNormal];
    hotBtn.selected = YES;
    [hotBtn addTarget:self action:@selector(hotBtn) forControlEvents:UIControlEventTouchUpInside];
    [segView addSubview:hotBtn];
    [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(segView);
        make.width.offset(40);
    }];
    
    latestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    latestBtn.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]);
    latestBtn.layer.cornerRadius = 3;
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

-(void)addConcernBtn
{}

-(void)hotBtn
{
    hotBtn.selected = YES;
    latestBtn.selected = NO;
    hotBtn.dk_backgroundColorPicker = DKColorWithColors(BASERED, BASERED_NIGHT);
    latestBtn.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]);
}

-(void)latestBtn
{
    hotBtn.selected = NO;
    latestBtn.selected = YES;
    latestBtn.dk_backgroundColorPicker = DKColorWithColors(BASERED, BASERED_NIGHT);
    hotBtn.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor whiteColor]);
}

@end
