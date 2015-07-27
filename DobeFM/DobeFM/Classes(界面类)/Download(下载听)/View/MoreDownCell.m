//
//  MoreDownCell.m
//  Xmly
//
//  Created by DobeFM on 15/7/9.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "MoreDownCell.h"

@implementation MoreDownCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleStr = [[UILabel alloc]init];
        self.titleStr.font = [UIFont boldSystemFontOfSize:12];
        self.titleStr.numberOfLines = 0;
        [self addSubview:self.titleStr];
        
        self.checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect checkboxRect = CGRectMake(self.bounds.size.width*0.9,10,20,20);
        [self.checkbox  setFrame:checkboxRect];
        [self.checkbox  setImage:[UIImage imageNamed:@"iconfont-xuankuang.png"] forState:UIControlStateNormal];
        [self.checkbox  setImage:[UIImage imageNamed:@"iconfont-fuxuankuang.png"] forState:UIControlStateSelected];
        
        //[self.checkbox  addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.checkbox ];
    }
    return self;

}

- (void)layoutSubviews{
    self.titleStr.frame = CGRectMake(5, 0,kWW*0.85, 40);

    CGRect checkboxRect = CGRectMake(self.bounds.size.width*0.9,10,20,20);
    [self.checkbox  setFrame:checkboxRect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
