//
//  HotAnchorCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAnchorCell.h"

@implementation HotAnchorCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.picView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.picView];
        
        self.nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor cyanColor];
    
    self.picView.frame = CGRectMake(0, 0, kWW, kWW);
    self.picView.layer.cornerRadius = kWW / 2;
    self.picView.layer.masksToBounds = YES;
    
    self.nameLabel.frame = CGRectMake(0, kWW + 2.5, kWW, 20);
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = [UIColor blackColor];
    
    
}

@end
