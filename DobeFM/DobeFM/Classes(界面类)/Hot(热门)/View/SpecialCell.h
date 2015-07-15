//
//  SpecialCell.h
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialItem.h"
@interface SpecialCell : UITableViewCell

@property (nonatomic, retain) UIImageView *coverImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *releaseAtLabel;
@property (nonatomic, retain) UIImageView *hotImage;
@property (nonatomic, retain) SpecialItem *spcItem;

@end
