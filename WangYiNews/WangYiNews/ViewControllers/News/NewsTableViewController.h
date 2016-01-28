//
//  NewsTableViewController.h
//  News
//
//  Created by lifangli on 15/9/19.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSString *newsUrl;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;

@end
