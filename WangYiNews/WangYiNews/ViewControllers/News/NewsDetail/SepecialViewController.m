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

@interface SepecialViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *moreStr;

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
}

-(void)setMoreStr:(NSString *)moreStr
{
    _moreStr = moreStr;
    _moreLab.text = _moreStr;
}

-(void)setSepecialModel:(SepecialModel *)sepecialModel
{
    _sepecialModel = sepecialModel;
    
    [self loadData];
    [self tableViewHeaderView];
    [self crateTableView];
    
    UILabel *titleLab = [Helper label:_sepecialModel.sname font:[UIFont systemFontOfSize:18] textColor:[UIColor whiteColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.height.offset(44);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self createNavigation];
    
    headerViewHeight = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNavigation
{
    UIView *navView = [Helper view:BASERED nightColor:BASERED_NIGHT];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.height.offset(64);
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

-(void)loadData
{
    _contentArr = [[NSMutableArray alloc] init];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [temp addObjectsFromArray:[self loadModel:self.sepecialModel.topics]];
    [temp addObjectsFromArray:[self loadModel:self.sepecialModel.topicslatest]];
    [temp addObjectsFromArray:[self loadModel:self.sepecialModel.topicspatch]];
    [temp addObjectsFromArray:[self loadModel:self.sepecialModel.topicsplus]];
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
            if (sm.docs.count%2 == 0) {
                count = sm.docs.count/2;
            }
            else{
                count = sm.docs.count/2 + 1;
            }
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
    headerView = [[UIView alloc] init];
    if (self.sepecialModel.banner) {
        UIImageView *banner = [[UIImageView alloc] init];
        [banner sd_setImageWithURL:[NSURL URLWithString:self.sepecialModel.banner]];
        [headerView addSubview:banner];
        [banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.mas_equalTo(headerView);
            make.height.offset(65);
        }];
        headerViewHeight = headerViewHeight + 65;
    }
    if (self.sepecialModel.headpics.count>0) {
        for (int i=0; i<self.sepecialModel.headpics.count; i++) {
            NSDictionary *dic = [self.sepecialModel.headpics objectAtIndex:i];
            NSString *imgsrc = [dic objectForKey:@"imgsrc"];
            NSString *tag = [dic objectForKey:@"tag"];
            NSString *title = [dic objectForKey:@"title"];
            UIImageView *img = [[UIImageView alloc] init];
            img.frame = CGRectMake(0, 216*i, [Helper screenWidth], 180);
            [img sd_setImageWithURL:[NSURL URLWithString:imgsrc]];
            [headerView addSubview:img];
            CGFloat X = 15;
            if ([tag isEqualToString:@"photoset"]) {
                UIImageView *photoset = [[UIImageView alloc] init];
                photoset.frame = CGRectMake(15, 190, 16, 16);
                photoset.image = [UIImage imageNamed:@"photoset_list_cell_icon@2x.png"];
                [headerView addSubview:photoset];
                
                X = X + 26;
            }
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(X, 180, [Helper screenWidth]-X-15, 36)];
            titleLab.text = title;
            titleLab.font = [UIFont systemFontOfSize:14];
            [headerView addSubview:titleLab];
            
            headerViewHeight = 216;
        }
    }
    if (self.sepecialModel.digest.length>0) {
        UILabel *digst = [[UILabel alloc] init];
        digst.text = self.sepecialModel.digest;
        digst.font = [UIFont systemFontOfSize:13];
        digst.textColor = [UIColor grayColor];
        CGSize digistSize = [digst.text boundingRectWithSize:CGSizeMake([Helper screenWidth]-35, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        digst.numberOfLines = 0;
        digst.lineBreakMode = NSLineBreakByWordWrapping;
        digst.frame = CGRectMake(25, headerViewHeight + 10, [Helper screenWidth]-35, digistSize.height);
        [headerView addSubview:digst];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, headerViewHeight + 7, 5, digistSize.height + 6)];
        line.backgroundColor = LINECOLOR;
        [headerView addSubview:line];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, headerViewHeight + digistSize.height + 21.5, [Helper screenWidth], 0.5)];
        line1.backgroundColor = LINECOLOR;
        [headerView addSubview:line1];
        
        headerViewHeight = headerViewHeight + digistSize.height + 22;
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
    _sepecialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _sepecialTableView.delegate = self;
    _sepecialTableView.dataSource = self;
    _sepecialTableView.tableHeaderView = headerView;
    [self.view addSubview:_sepecialTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _contentArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
        if (contentModel.imgType) {
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
        NSMutableArray *arr = [_videoArr objectAtIndex:indexPath.row];
        if ([sortModel.type isEqualToString:@"video"]) {
            cell.imgplay1.hidden = NO;
            cell.imgplay2.hidden = NO;
        }
        else{
            cell.imgplay1.hidden = NO;
            cell.imgplay2.hidden = NO;
        }
        cell.digst1.text = ((SepecialContentModel *) [arr objectAtIndex:0]).title;
        cell.digst2.text = ((SepecialContentModel *) [arr objectAtIndex:1]).title;
        [cell.imgsrc1 sd_setImageWithURL:[NSURL URLWithString:((SepecialContentModel *) [arr objectAtIndex:0]).cover]];
        [cell.imgsrc2 sd_setImageWithURL:[NSURL URLWithString:((SepecialContentModel *) [arr objectAtIndex:1]).cover]];
    }
    else if ([sortModel.type isEqualToString:@"timeline"]) {
        
    }
    for(id oneObject in nib){
        if([oneObject isKindOfClass:[SepecialCell class]]){
            cell = (SepecialCell *)oneObject;
        }
    }
    cell.contentModel = contentModel;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SepecialSortModel *sortModel = [_contentArr objectAtIndex:indexPath.section];
    NSDictionary *dic = [sortModel.docs objectAtIndex:indexPath.row];
    SepecialContentModel *contentModel = [SepecialContentModel objectWithKeyValues:dic];
    if ([sortModel.type isEqualToString:@"imgnews"]) {
        if (contentModel.imgType) {
            return 200;
        }
        else if (contentModel.imgextra.count>0){
            return 121;
        }
        else{
            return 90;
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

@end
