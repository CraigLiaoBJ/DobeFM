//
//  HotVoiceCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AudioCell.h"

@interface AudioCell ()

//cell图片
@property (nonatomic, retain)UIImageView *cellImageView;

//表视图上面音频信息
//音频图片
@property (nonatomic, retain) UIImageView *coverSmImage;
//音频标题
@property (nonatomic, retain) UILabel *audioTitleLabel;
//音频作者
@property (nonatomic, retain) UILabel *authorLabel;
//时长
@property (nonatomic, retain) UILabel *durationLabel;

@end

@implementation AudioCell

- (void)dealloc{
    [_cellImageView release];
    [_coverSmImage release];
    [_audioTitleLabel release];
    [_authorLabel release];
    [_durationLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellImageView = [[[UIImageView alloc]init]autorelease];
//        self.cellImageView = [[UIImageView alloc]init];

        [self addSubview:self.cellImageView];
//        [_cellImageView release];
        
        self.coverSmImage = [[[UIImageView alloc]init]autorelease];
        [self.cellImageView addSubview:self.coverSmImage];
//        [_coverSmImage release];
        
        self.audioTitleLabel = [[[UILabel alloc]init]autorelease];
        [self.cellImageView addSubview:self.audioTitleLabel];
//        [_audioTitleLabel release];
        
        self.authorLabel = [[[UILabel alloc]init]autorelease];
        [self.cellImageView addSubview:self.authorLabel];
//        [_authorLabel release];
        
        self.durationLabel = [[[UILabel alloc]init]autorelease];
        [self.cellImageView addSubview:self.durationLabel];
//        [_durationLabel release];
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
    self.audioTitleLabel.frame = CGRectMake(90, 5, kWW - 90, 30);
    self.audioTitleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.audioTitleLabel.numberOfLines = 0;
    //音频作者
    self.authorLabel.frame = CGRectMake(90, 40, kWW / 4 * 3 , 12);
    self.authorLabel.font = [UIFont systemFontOfSize:13];
    self.authorLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.alpha = 0.5;
    //时长
    self.durationLabel.frame = CGRectMake(90, 62, kWW - 90, 12);
    self.durationLabel.textColor = [UIColor lightGrayColor];
    self.durationLabel.font = [UIFont systemFontOfSize:13];
    self.durationLabel.alpha = 0.5;

}

#pragma mark --- 重写setter方法
- (void)setAlbumList:(AlbumList *)albumList{
    if (_albumList != albumList) {
        [_albumList release];
        [albumList retain];
        _albumList = albumList;
    }
    //音频图片
    NSURL *url = [NSURL URLWithString:albumList.coverLarge];
    [self.coverSmImage sd_setImageWithURL:url];
    //标题
    _audioTitleLabel.text = albumList.title1;
    //作者
    _authorLabel.text = [NSString stringWithFormat:@"By%@" , albumList.nickname];
    //时长
    [albumList.durationTime floatValue];
    _durationLabel.text = [NSString stringWithFormat:@"时长：%@" ,[self convertTime:[albumList.durationTime floatValue]]];
}

//数值转化成时间格式
- (NSString *)convertTime:(CGFloat)second{    
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"mm:ss"];
    NSString *showtimeNew;
    if (second/3600 >= 1) {
        showtimeNew = [NSString stringWithFormat:@"%d:%@",(int)second/3600 ,[formatter stringFromDate:d]] ;
    } else {
        showtimeNew = [formatter stringFromDate:d];
    }
    return showtimeNew;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
