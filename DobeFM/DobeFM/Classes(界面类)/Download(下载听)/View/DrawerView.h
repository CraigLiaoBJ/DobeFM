//
//  DrawerView.h
//  Xmly
//
//  Created by DobeFM on 15/7/3.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//
#import "AlbumList.h"
#import <UIKit/UIKit.h>
@protocol DrawerViewDelegate<NSObject>
@optional
-(void)DrawerTableView:(NSMutableArray *) horitoryAudio;

@end


@interface DrawerView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) id <DrawerViewDelegate> delegate;

@property(nonatomic,retain) NSMutableDictionary *dic;
@property(nonatomic,retain) UITableView* tableView;
-(void)reloadData;
@end
