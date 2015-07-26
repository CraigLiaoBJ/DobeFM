//
//  DiscoverCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "DiscoverCell.h"

@implementation DiscoverCell

- (void)dealloc{
    [_picture release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        //初始化
        _picture = [[[UIImageView alloc]init]autorelease];
        [self.contentView addSubview:_picture];
        [_picture release];
    }
    return self;
}

- (void)layoutSubviews{
    //开始布局
    self.picture.frame = CGRectMake(0, 0, kWW, kHH);
    self.picture.userInteractionEnabled = YES;
    
}

@end
