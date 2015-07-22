//
//  SpcDetailCell.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchAlbum.h"
@interface SpcAbmDetailCell : UITableViewCell

@property (nonatomic, retain)UIImageView *cellImageView;

//表视图上面音频信息
@property (nonatomic, retain) UIImageView *coverSmImage;
@property (nonatomic, retain) UILabel *albumTitleLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, assign) UILabel *playCountLabel;
@property (nonatomic, assign) UILabel *createdAtLabel;
@property (nonatomic, assign) UILabel *durationLabel;

@property(nonatomic, retain) SearchAlbum *spcAbmDtlModel;

@end
