//
//  HotAnchorTableViewCell.m
//  iTing
//
//  Created by Craig Liao on 15/7/14.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "HotAnchorTableViewCell.h"

@interface HotAnchorTableViewCell ()

@end
@implementation HotAnchorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            for (int i = 0; i < 3; i ++) {
                UIButton *button = [[UIButton alloc]init];
                button.tag = i + 1000;
                
                UILabel *label = [[UILabel alloc]init];
                label.tag = i + 2000;

                [self addSubview:button];
                [self addSubview:label];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSLog(@"%f", self.frame.size.width );
    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:i + 1000];
        CGFloat WIDTH = [UIScreen mainScreen].bounds.size.width;
        button.frame = CGRectMake(10 + (WIDTH - 40)/3 *i + 10 *i, 10, (WIDTH - 40)/3, (WIDTH - 40)/3);
        [button setBackgroundColor:[UIColor cyanColor]];
        
        UILabel *label = (UILabel *)[self viewWithTag:i + 2000];
        label.frame = CGRectMake(10 + (WIDTH - 40)/3 * i + 10 *i, 10+5 + (WIDTH - 40)/3, (WIDTH - 40)/3, 30);
        [label setBackgroundColor:[UIColor orangeColor]];

    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
