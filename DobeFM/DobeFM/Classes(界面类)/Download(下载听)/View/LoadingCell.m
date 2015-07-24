//
//  LoadingCell.m
//  Xmly
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoadingCell.h"

@implementation LoadingCell


- (void)awakeFromNib {
    // Initialization code
}

//- (void)initLayer {
//    // Do any additional setup after loading the view, typically from a nib.
//
//    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.btn.frame = CGRectMake(self.bounds.size.width - 40, self.bounds.size.height/2 - 10, 40, 20);
//    [self.btn addTarget:self action:@selector(star) forControlEvents:UIControlEventTouchUpInside];
//    [self.btn setTitle:@"star" forState:UIControlStateNormal];
//    [self addSubview:self.btn];
//    self.progress = [[UIProgressView alloc]initWithFrame:CGRectMake((self.bounds.size.width - 240)/2 + 40, self.bounds.size.height - 10, 240, 10)];
//    [self addSubview:self.progress];
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       //[self initLayer];
        self.backgroundColor = CELLCOLOR;
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
