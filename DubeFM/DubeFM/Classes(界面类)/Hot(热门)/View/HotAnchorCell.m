//
//  HotAnchorCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAnchorCell.h"

@interface HotAnchorCell ()



@end

@implementation HotAnchorCell

- (void)dealloc{
    [_picView release];
    [_nameLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.picView = [[[UIImageView alloc]init]autorelease];
        [self.contentView addSubview:self.picView];
//        [_picView release];
        
        self.nameLabel = [[[UILabel alloc]init]autorelease];
        [self.contentView addSubview:self.nameLabel];
//        [_nameLabel release];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = cellImageColor;
    
    self.picView.frame = CGRectMake(0, 0, kWW, kWW);
    self.picView.layer.cornerRadius = kWW / 2;
    self.picView.layer.masksToBounds = YES;
    
    self.nameLabel.frame = CGRectMake(0, kWW + 2.5, kWW, 20);
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = [UIColor blackColor];
}

@end
