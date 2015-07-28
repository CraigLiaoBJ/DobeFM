//
//  HotVoiceCell.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"
@interface AudioCell : UITableViewCell

//数据源
@property (nonatomic, retain) AlbumList *albumList;

@end
