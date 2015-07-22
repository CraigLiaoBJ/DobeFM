//
//  HotVoiceCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AudioCell.h"

@interface AudioCell ()


@end

@implementation AudioCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellImageView = [[UIImageView alloc]init];
        [self addSubview:_cellImageView];
        [_cellImageView release];
        
        self.coverSmImage = [[UIImageView alloc]init];
        [self.cellImageView addSubview:self.coverSmImage];
        [_coverSmImage release];
        
        self.audioTitleLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.audioTitleLabel];
        [_audioTitleLabel release];
        
        self.authorLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.authorLabel];
        [_authorLabel release];
        
        self.durationLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.durationLabel];
        [_durationLabel release];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellImageView.frame = CGRectMake(0, 10, kWW, 90);
    self.cellImageView.backgroundColor = cellImageColor;
    //音频图片
    self.coverSmImage.frame = CGRectMake(5, 15, 60, 60);
    self.coverSmImage.backgroundColor  = [UIColor colorWithRed:0.359 green:0.672 blue:1.000 alpha:1.000];
    self.coverSmImage.layer.cornerRadius = 30.f;
    self.coverSmImage.layer.masksToBounds = YES;
    //音频标题
    self.audioTitleLabel.frame = CGRectMake(90, 5, kWW - 90, 20);
    self.audioTitleLabel.font = [UIFont boldSystemFontOfSize:13];
    CGFloat height = [self getStringHeightBaseFont:13 width:kWW - 90 string:self.audioTitleLabel.text];
    self.audioTitleLabel.frame = CGRectMake(90, 15, kWW - 90, height);
    self.audioTitleLabel.numberOfLines = 0;
    //音频作者
    self.authorLabel.frame = CGRectMake(90, height + 20, kWW / 4 * 3 , 12);
    self.authorLabel.font = [UIFont systemFontOfSize:13];
    self.authorLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.alpha = 0.5;
    //时长
    self.durationLabel.frame = CGRectMake(90, height + 40, kWW - 90, 12);
    self.durationLabel.textColor = [UIColor lightGrayColor];
    self.durationLabel.font = [UIFont systemFontOfSize:13];
    self.durationLabel.alpha = 0.5;

}
#pragma mark --- 自适应高度的方法
- (CGFloat)getStringHeightBaseFont:(CGFloat)font width:(CGFloat)width string:(NSString *)string{
    //计算高度的方法
    CGRect contentRect = [string boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return contentRect.size.height;
}


#pragma mark --- 重写setter方法
- (void)setAlbumList:(AlbumList *)albumList{
    if (_albumList != albumList) {
        [_albumList release];
        [albumList retain];
        _albumList = albumList;
    }
    //音频图片
    NSURL *url = [NSURL URLWithString:albumList.coverSmall];
    [self.coverSmImage sd_setImageWithURL:url];
    //标题
    _audioTitleLabel.text = albumList.title1;
    //作者
    _authorLabel.text = [NSString stringWithFormat:@"By%@" , albumList.nickname];
    //时长
    _durationLabel.text = [NSString stringWithFormat:@"时长：%@" ,[albumList.durationTime stringValue]];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
