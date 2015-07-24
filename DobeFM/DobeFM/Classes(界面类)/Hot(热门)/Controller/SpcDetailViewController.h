//
//  SpcDetailTableViewController.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialDetailItem.h"
@interface SpcDetailViewController : UIViewController

@property (nonatomic, retain) UIView *headView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) SpecialDetailItem *spclDetlItem;
@property (nonatomic, copy) NSString *addID;
@property (nonatomic, retain) NSString *spcTypeID;

@end

