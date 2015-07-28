//
//  CustomCell.m
//  UI--lesson22集合视图
//
//  Created by DobeFM on 15/6/22.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)dealloc{
    [_imageView release];
    [_titleLabel release];
    [super dealloc];
}

//初始化
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[[UIImageView alloc]init]autorelease];
        [self.contentView addSubview:_imageView];
//        [_imageView release];
        
        self.titleLabel = [[[UILabel alloc]init]autorelease];
        [self.contentView addSubview:self.titleLabel];
//        [_titleLabel release];
    }
    return self;
}

//开始布局
- (void)layoutSubviews{
    
    self.imageView.frame = CGRectMake(0, 0, kWW, kHH-20);
    
    self.titleLabel.frame = CGRectMake(0, kHH - 20, kWW, 20);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

@end
