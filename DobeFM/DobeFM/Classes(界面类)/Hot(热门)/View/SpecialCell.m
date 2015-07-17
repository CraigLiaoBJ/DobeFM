//
//  SpecialCell.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialCell.h"
#import "SpecialItem.h"
//cell的长宽宏定义
#define kW self.frame.size.width
#define kH self.frame.size.height
@implementation SpecialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //cell铺的图片
        self.imageview = [[UIImageView alloc]init];
        [self addSubview:self.imageview];
        [_imageview release];
        //cell上直接加的时间标签
        self.releaseAtLabel = [[UILabel alloc]init];
        [self.imageview addSubview:self.releaseAtLabel];
        [_releaseAtLabel release];
        //cell上直接加的时间图片
        self.timeImage = [[UIImageView alloc]init];
        [self.imageview addSubview:self.timeImage];
        [_timeImage release];
        
        //imageView上加的专题封面图片
        self.coverImageView = [[UIImageView alloc]init];
        [self.imageview addSubview:self.coverImageView];
        [_coverImageView release];
        //专题封面图片上的热门图标
        self.hotImage = [[UIImageView alloc]init];
        [self.coverImageView addSubview:self.hotImage];
        [_hotImage release];
        //专题封面上的专题名称
        self.titleLabel = [[UILabel alloc]init];
        [self.coverImageView addSubview:self.titleLabel];
        [_titleLabel release];
    }
     return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //cell图片设置
    self.imageview.frame = CGRectMake(0, 0, kW, 150);
    self.imageview.backgroundColor = [UIColor colorWithRed:1.000 green:0.945 blue:0.975 alpha:1.000];
    //时间图片设置
    self.timeImage.frame = CGRectMake(5, 5, 20, 20);
    self.timeImage.image = [UIImage imageNamed:@"special-time.png"];
    //时间标签设置
    self.releaseAtLabel.frame = CGRectMake(30, 0, kW / 2, 30);
    self.releaseAtLabel.font = [UIFont systemFontOfSize:15];
    self.releaseAtLabel.textAlignment = NSTextAlignmentLeft;
    //专题图片设置
    self.coverImageView.frame = CGRectMake(0, 30, kW, 140);
    self.coverImageView.backgroundColor = [UIColor yellowColor];
    //热门图标设置
    self.hotImage.frame = CGRectMake(0, 0, 40, 40);
    //专题名称设置
    self.titleLabel.frame = CGRectMake(0, 100, kW, 40);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.alpha = 0.9;
}

//重写setter方法
- (void)setSpcItem:(SpecialItem *)spcItem{
    if (_spcItem != spcItem) {
        [_spcItem release];
        [spcItem retain];
        _spcItem = spcItem;
    }
    //专题名称赋值
    _titleLabel.text = spcItem.title;
    
    //时间戳转换
    NSString *relAt = [spcItem.releasedAt stringValue];
    NSInteger num = [relAt integerValue] / 1000;
    NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confirmTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    NSString *time = [formatter stringFromDate:confirmTimesp];
    //时间赋值
    _releaseAtLabel.text = time;
    
    //封面图片赋值
    NSString *coverString = spcItem.coverPathBig;
    NSURL *coverUrl = [NSURL URLWithString:coverString];
    NSData *coverData = [NSData dataWithContentsOfURL:coverUrl];
    _coverImageView.image = [UIImage imageWithData:coverData];

}

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
