//
//  HotVoiceCell.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotVoiceModel.h"
@interface HotVoiceCell : UITableViewCell
//cell图片
@property (nonatomic, retain)UIImageView *cellImageView;

//表视图上面音频信息
//音频图片
@property (nonatomic, retain) UIImageView *coverSmImage;
//音频标题
@property (nonatomic, retain) UILabel *audioTitleLabel;
//音频作者
@property (nonatomic, retain) UILabel *authorLabel;

//时长
@property (nonatomic, assign) UILabel *durationLabel;
//数据源
@property (nonatomic, retain) AlbumList *albumList;

@end
