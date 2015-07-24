//
//  CustomCell.m
//  UI--lesson22集合视图
//
//  Created by lanou3g on 15/6/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
//开始布局
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //开始布局
        self.imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];

    }
    return self;
}

- (void)layoutSubviews{
    
    self.imageView.frame = CGRectMake(0, 0, kWW, kHH-20);
    
    self.titleLabel.frame = CGRectMake(0, kHH - 20, kWW, 20);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];

}

@end
