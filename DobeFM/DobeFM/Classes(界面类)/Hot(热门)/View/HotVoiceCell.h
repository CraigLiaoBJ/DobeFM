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
@property (nonatomic, retain)UIImageView *cellImageView;

//表视图上面音频信息
@property (nonatomic, retain) UIImageView *coverSmImage;
@property (nonatomic, retain) UILabel *audioTitleLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, assign) UILabel *playCountLabel;
@property (nonatomic, assign) UILabel *createdAtLabel;
@property (nonatomic, assign) UILabel *durationLabel;
@property (nonatomic, retain) UIImageView *download;

@property (nonatomic, retain) HotVoiceModel *voiceModel;

@end
