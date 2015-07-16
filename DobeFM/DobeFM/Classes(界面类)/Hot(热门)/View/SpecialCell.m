//
//  SpecialCell.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialCell.h"
#import "SpecialItem.h"
@implementation SpecialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 150)];
        imageview.backgroundColor = [UIColor clearColor];
        [self addSubview:imageview];
        [imageview release];
        
        self.releaseAtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
        self.releaseAtLabel.backgroundColor = [UIColor lightGrayColor];
        self.releaseAtLabel.text = @"miaowuwo";
        self.releaseAtLabel.textAlignment = NSTextAlignmentCenter;
        [imageview addSubview:self.releaseAtLabel];
        
        self.coverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 375, 130)];
        self.coverImageView.backgroundColor = [UIColor yellowColor];
        [imageview addSubview:self.coverImageView];
        [_coverImageView release];
       
        self.hotImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//        self.hotImage.image = [UIImage imageNamed:@"iconfont-remenbiaoqian.png"];
        [_coverImageView addSubview:self.hotImage];
        [_hotImage release];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 375, 40)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel.alpha = 0.3;
        [self.coverImageView addSubview:self.titleLabel];
        [_titleLabel release];
    }
     return self;
}

- (void)setSpcItem:(SpecialItem *)spcItem{
    if (_spcItem != spcItem) {
        [_spcItem release];
        [spcItem retain];
        _spcItem = spcItem;
    }
    _titleLabel.text = spcItem.titleString;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHMMss"];
    NSString *relAt = [spcItem.releaseAt stringValue];
    _releaseAtLabel.text = relAt;
    [formatter dateFromString: _releaseAtLabel.text];
    
        NSString *coverString = spcItem.coverBig;
    NSURL *coverUrl = [NSURL URLWithString:coverString];
    NSData *coverData = [NSData dataWithContentsOfURL:coverUrl];
    _coverImageView.image = [UIImage imageWithData:coverData];
    
//        NSURL *cover = [NSURL URLWithString:coverString];
//        [_coverImageView sd_setImageWithURL:cover];
}

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
