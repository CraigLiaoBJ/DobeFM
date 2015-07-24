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
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20)];
        [self.contentView addSubview:self.imageView];
        //label
        self.titilelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-10, self.frame.size.width,10)];
        self.titilelabel.backgroundColor = [UIColor brownColor];
        self.titilelabel.textAlignment = NSTextAlignmentCenter;
        self.titilelabel.textColor = [UIColor blackColor];
        self.titilelabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.titilelabel];
    }
    return self;
}


@end
