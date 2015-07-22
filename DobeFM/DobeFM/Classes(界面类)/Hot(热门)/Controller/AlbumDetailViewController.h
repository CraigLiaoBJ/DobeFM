//
//  AlbumDetailViewController.h
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchAlbum.h"

@interface AlbumDetailViewController : UIViewController

@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) SearchAlbum *sAlbum;

//@property (nonatomic, retain) NSMutableArray *

@end
