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
@property (nonatomic, strong) UITableView *loadedTableView;

@property (nonatomic, strong) UITableView *loadingTableView;

@property (nonatomic, assign) bool isLoading;

@property (nonatomic, assign) bool addLoadData;

-(void)continuDown;
@end
