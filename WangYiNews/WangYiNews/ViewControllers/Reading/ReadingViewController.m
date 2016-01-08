//
//  ReadingViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/20.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "ReadingViewController.h"

@interface ReadingViewController ()

@end

@implementation ReadingViewController
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView1 addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView1 headerBeginRefreshing];
}

-(void)initData
{
    self.naviLeftBtn.hidden = YES;
    SetButtonImage(self.naviRightBtn, @"top_navigation_readerplus@2x");
    [self setSegLStr:@"推荐阅读"];
    [self setSegRStr:@"我的订阅"];
}

-(void)loadNavigationBar
{
    [self.naviRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(27);
        make.size.sizeOffset(CGSizeMake(30, 30));
        make.right.equalTo(self.view).offset(-14);
    }];
}

-(void)loadData
{
    
}

-(void)loadDataWithType:(NSInteger)type url:(NSString *)url tableView:(UITableView *)tableView
{
    [[[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        if (tableView == self.tableView1) {
            
        }
        else{
            
        }
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [tableView headerEndRefreshing];
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        return 318;
    }
    else{
        return 133 + ([Helper screenWidth]-50)/3;
    }
}

#pragma mark----------------btnAction------------
-(void)navigationRightBtnClick
{}

@end
