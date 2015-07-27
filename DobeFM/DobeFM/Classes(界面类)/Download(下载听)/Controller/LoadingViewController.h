//
//  LoadingViewController.h
//  Xmly
//
//  Created by DobeFM on 15/7/8.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//
#import "SaveLodingDate.h"
#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController
@property (nonatomic, strong) UITableView *loadedTableView;//下载完

@property (nonatomic, strong) UITableView *loadingTableView;//未下载

@property (nonatomic, assign) bool isLoading;//是否下载

@property (nonatomic, assign) bool addLoadData;//是否有添加数据


@end
