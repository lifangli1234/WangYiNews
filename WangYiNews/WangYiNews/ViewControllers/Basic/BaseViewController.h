//
//  BaseViewController.h
//  WangYiNews
//
//  Created by lifangli on 16/1/4.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentView.h"

@interface BaseViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,SegmentViewDelegate>

@property(nonatomic, strong)UIScrollView *contentScr;
@property(nonatomic, strong)UITableView *tableView1;
@property(nonatomic, strong)UITableView *tableView2;
@property(nonatomic, strong)UIButton *naviLeftBtn;
@property(nonatomic, strong)UIButton *naviRightBtn;
@property(nonatomic, strong)NSString *titleStr;
@property(nonatomic, strong)NSString *segLStr;
@property(nonatomic, strong)NSString *segRStr;
@property(nonatomic, strong)SegmentView *segmentView;
@property(assign, nonatomic)BOOL isNormal;

-(void)initData;
-(void)loadNavigationBar;
-(void)navigationLeftBtnClick;
-(void)navigationRightBtnClick;

@end
