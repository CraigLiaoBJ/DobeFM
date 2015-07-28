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
        
        self.imagecell = [[UIImageView alloc]init];
        [self addSubview:self.imagecell];
        
        self.coverImage = [[UIImageView alloc]init];
        [self.imagecell addSubview:self.coverImage];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.imagecell addSubview:self.titleLabel];

    }
    return self;
}

- (void)layoutSubviews{
    
    self.imagecell.frame = CGRectMake(0, 5, kWW, 50);
    self.imagecell.backgroundColor = cellImageColor;
    
    self.coverImage.frame = CGRectMake(10, 0, 50, 50);
    self.coverImage.backgroundColor = cellImageColor;
    
    self.titleLabel.frame = CGRectMake(70, 10, kWW - 120, 25);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
