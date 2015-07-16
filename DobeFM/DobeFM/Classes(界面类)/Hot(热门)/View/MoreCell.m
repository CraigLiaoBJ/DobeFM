//
//  MoreCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/15.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "MoreCell.h"
#define kORIGINX self.frame.origin.x
#define kORIGINY self.frame.origin.y
#define kWD self.frame.size.width
#define kHT self.frame.size.height

@interface MoreCell ()

@property (nonatomic, retain) UIImageView *coverImage;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *subTitleLabel;
@property (nonatomic, retain) UILabel *albumLabel;
@property (nonatomic, retain) UILabel *likeLabel;
@property (nonatomic, retain) UIButton *lsnButton;

@end

@implementation MoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //cell图片
//        self.coverImage = [[UIImageView alloc]init];
//        [self addSubview:self.coverImage];
        //主播头像
        self.iconImage = [[UIImageView alloc]init];
        [self addSubview:self.iconImage];
        //次标题名称
        self.subTitleLabel = [[UILabel alloc]init];
        [self addSubview:self.subTitleLabel];
        //专辑名称
        self.albumLabel = [[UILabel alloc]init];
        [self addSubview:self.albumLabel];
        //浏览量
        self.likeLabel = [[UILabel alloc]init];
        [self addSubview:self.likeLabel];
        //试听按钮
        self.lsnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.lsnButton];

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.coverImage.frame = CGRectMake(kORIGINX, kORIGINY - 5, kWD, kHT - 10);
//    self.coverImage.backgroundColor = [UIColor colorWithRed:1.000 green:0.534 blue:0.346 alpha:1.000];
    
    self.iconImage.frame = CGRectMake(kORIGINX, 5, kHT, kHT - 10);
    self.iconImage.backgroundColor = [UIColor greenColor];
    
    self.albumLabel.frame = CGRectMake(kWD - kHT - 15, 5, kHT, 20);
    self.albumLabel.text = @"albumtext";
    self.albumLabel.backgroundColor = [UIColor greenColor];
    
    self.subTitleLabel.frame = CGRectMake(kWD - kHT - 15, 30, kHT, 20);
    self.subTitleLabel.text = @"subTitle";
    self.subTitleLabel.backgroundColor = [UIColor greenColor];
    
    self.likeLabel.frame = CGRectMake(kWD - kHT - 15, 55, kHT, 20);
    self.likeLabel.text = @"likeLabel";
    self.likeLabel.backgroundColor = [UIColor greenColor];
    
    self.lsnButton.frame = CGRectMake(kWD - kHT + 30, 80, kHT/4, kHT/4);
    [self.lsnButton setTitle:@"lsn" forState:UIControlStateNormal];
    self.lsnButton.backgroundColor = [UIColor greenColor];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
