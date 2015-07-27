//
//  LoadingCell.m
//  Xmly
//
//  Created by DobeFM on 15/7/16.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "LoadingCell.h"

@implementation LoadingCell


- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       //[self initLayer];
        self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 50)];
        [self addSubview:self.coverImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame: CGRectMake(70, 10, kWW - 110, 25)];
        [self addSubview:self.titleLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
