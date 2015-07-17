//
//  SpcDetailCell.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialItem.h"
@interface SpcDetailCell : UITableViewCell

@property (nonatomic, retain)UIImageView *cellImageView;



//表视图上面音频信息
@property (nonatomic, retain) UIImageView *coverSmImage;
@property (nonatomic, retain) UILabel *audioTitleLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, assign) UILabel *playCountLabel;
@property (nonatomic, assign) UILabel *createdAtLabel;
@property (nonatomic, assign) UILabel *durationLabel;


@property(nonatomic, retain) SpecialItem *specialItem;

@end
