//
//  NewsTableViewController.m
//  News
//
//  Created by lifangli on 15/9/19.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "NewsTableViewController.h"
#import "PhotoSetCell.h"
#import "BigPhotoCell.h"
#import "ArticleCell.h"
#import "NewsDetailViewController.h"

@interface NewsTableViewController ()

@property(nonatomic,strong)NSMutableArray *newsList;

@end

@implementation NewsTableViewController
{
    UIScrollView *_titleScro;
    NSMutableArray *_titleImageArr;
    NSMutableArray *_newsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self sentRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sentRequest
{
    _newsList = [[NSMutableArray alloc] init];
    [DownLoad requestURL:self.newsUrl parameters:nil withType:@"GET" format:@"json" complete:^(id result) {
        _newsList = [result objectForKey:self.key];
        //self.tableView.tableHeaderView = [self tableViewHeaderView];
        [self.tableView reloadData];
    }];
}

-(UIView *)tableViewHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Helper screenWidth], 200)];
    
    _titleScro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [Helper screenWidth], 170)];
    _titleScro.contentSize = CGSizeMake([Helper screenWidth]*_titleImageArr.count, 170);
    _titleScro.showsHorizontalScrollIndicator = NO;
    _titleScro.pagingEnabled = YES;
    for (int i=0; i<_titleImageArr.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake([Helper screenWidth]*i, 0, [Helper screenWidth], 170)];
        [img sd_setImageWithURL:[[_titleImageArr objectAtIndex:i] objectAtIndex:1] placeholderImage:[UIImage imageNamed:@"video_cell_content_bg@2x.png"]];
        [_titleScro addSubview:img];
    }
    [headerView addSubview:_titleScro];//photoset_list_cell_icon@2x.png
    
    return headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsList.count-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cell";
    NSDictionary *dic = [_newsList objectAtIndex:indexPath.row];
    NSArray *imageArr = [dic objectForKey:@"imgextra"];
    NSInteger replyCount = [[dic objectForKey:@"replyCount"] integerValue];
    NSString *reply = [[NSString alloc] init];
    if (replyCount>10000) {
        reply = [NSString stringWithFormat:@"%.1f万跟帖",replyCount/10000.0];
    }
    else{
        reply = [NSString stringWithFormat:@"%ld跟帖",replyCount];
    }
    CGSize replySize = [reply sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    if ([[dic objectForKey:@"skipType"] isEqualToString:@"photoset"] && imageArr.count>0) {
        BigPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BigPhotoCell" owner:self options:nil] lastObject];
        }
        cell.title.text = [dic objectForKey:@"title"];
        [cell.image1 sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@""]];
        [cell.image2 sd_setImageWithURL:[NSURL URLWithString:[imageArr.firstObject objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@""]];
        [cell.image3 sd_setImageWithURL:[NSURL URLWithString:[imageArr.lastObject objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@""]];
        [cell.contentView addSubview:[Helper imageView:CGRectMake([Helper screenWidth]-14-replySize.width, 7.5, replySize.width+4, 15) name:@"cola_bubble_gray@2x.png"]];
        [cell.contentView addSubview:[Helper label:reply frame:CGRectMake([Helper screenWidth]-12-replySize.width, 7.5, replySize.width, 15) font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter]];
        [cell.contentView addSubview:[Helper view:CGRectMake(0, 113.5, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
        return cell;
    }
    else if ([[dic objectForKey:@"imgType"] intValue] == 1) {
        PhotoSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoSetCell" owner:self options:nil] lastObject];
        }
        cell.title.text = [dic objectForKey:@"title"];
        cell.desc.text = [dic objectForKey:@"digest"];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@""]];
        [cell.contentView addSubview:[Helper imageView:CGRectMake([Helper screenWidth]-14-replySize.width, 155, replySize.width+4, 15) name:@"cola_bubble_gray@2x.png"]];
        [cell.contentView addSubview:[Helper label:reply frame:CGRectMake([Helper screenWidth]-12-replySize.width, 155, replySize.width, 15) font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter]];
        [cell.contentView addSubview:[Helper view:CGRectMake(0, 179.5, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
        return cell;
    }
    else{
        ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil] lastObject];
        }
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgsrc"]] placeholderImage:[UIImage imageNamed:@""]];
        cell.title.text = [dic objectForKey:@"title"];
        cell.desc.text = [dic objectForKey:@"digest"];
        [cell.contentView addSubview:[Helper imageView:CGRectMake([Helper screenWidth]-14-replySize.width, 55, replySize.width+4, 15) name:@"cola_bubble_gray@2x.png"]];
        [cell.contentView addSubview:[Helper label:reply frame:CGRectMake([Helper screenWidth]-12-replySize.width, 55, replySize.width, 15) font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter]];
        [cell.contentView addSubview:[Helper view:CGRectMake(0, 79.5, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_newsList objectAtIndex:indexPath.row];
    NSArray *imageArr = [dic objectForKey:@"imgextra"];
    if ([[dic objectForKey:@"skipType"] isEqualToString:@"photoset"] && imageArr.count>0){
        return 114.0f;
    }
    else if ([[dic objectForKey:@"skipType"] isEqualToString:@"photoset"] && [[dic objectForKey:@"imgType"] intValue] == 1){
        return 180.0f;
    }
    else{
        return 80.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_newsList objectAtIndex:indexPath.row];
    NewsDetailViewController  *dvc = [[NewsDetailViewController alloc] init];
    if ([[dic objectForKey:@"skipType"] isEqualToString:@"special"]) {
        dvc.isSpecial = YES;
        dvc.detailUrl = [NSString stringWithFormat:@"/nc/special/%@.html",[dic objectForKey:@"skipID"]];
        dvc.detailId = [dic objectForKey:@"skipID"];
        dvc.commentUrl = nil;
    }
    else{
        dvc.isSpecial = NO;
        dvc.detailUrl = [NSString stringWithFormat:@"/nc/article/%@/full.html",[dic objectForKey:@"docid"]];
        dvc.detailId = [dic objectForKey:@"docid"];
        dvc.commentUrl = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",[dic objectForKey:@"boardid"],[dic objectForKey:@"docid"]];
    }
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
