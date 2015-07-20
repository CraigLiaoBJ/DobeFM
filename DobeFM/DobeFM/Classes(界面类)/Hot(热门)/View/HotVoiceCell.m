//
//  HotVoiceCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotVoiceCell.h"

#define kORIGINX self.frame.origin.x
#define kORIGINY self.frame.origin.y
#define kWD self.frame.size.width
#define kHT self.frame.size.height

@interface HotVoiceCell ()


@end

@implementation HotVoiceCell

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
        
        self.playCountLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.playCountLabel];
        [_playCountLabel release];
        
        self.durationLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.durationLabel];
        [_durationLabel release];
        
        self.createdAtLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.createdAtLabel];
        [_createdAtLabel release];
        
        self.download = [[UIImageView alloc]init];
        [self.cellImageView addSubview:self.download];
        [_download release];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellImageView.frame = CGRectMake(0, 10, kWD, 90);
    self.cellImageView.backgroundColor = [UIColor whiteColor];
    
    self.coverSmImage.frame = CGRectMake(5, 15, 60, 60);
    self.coverSmImage.backgroundColor  = [UIColor colorWithRed:0.359 green:0.672 blue:1.000 alpha:1.000];
    self.coverSmImage.layer.cornerRadius = 30.f;
    self.coverSmImage.layer.masksToBounds = YES;
    
    self.audioTitleLabel.frame = CGRectMake(90, 5, kWW, 30);
    self.audioTitleLabel.font = [UIFont systemFontOfSize:13];
//    CGFloat height = [self getStringHeightBaseFont:14 width:kWW / 2 string:self.audioTitleLabel.text];
//    self.audioTitleLabel.frame = CGRectMake(90, 5, kWW - 90, height);
    self.audioTitleLabel.numberOfLines = 0;
    
    self.authorLabel.frame = CGRectMake(90, 30 + 5, kWW / 4 * 3 , 12);
    self.authorLabel.font = [UIFont systemFontOfSize:12];
    self.authorLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.alpha = 0.5;

    self.playCountLabel.frame = CGRectMake(90, 30 + 25, 80, 12);
    self.playCountLabel.font = [UIFont systemFontOfSize:12];
    self.playCountLabel.textColor = [UIColor lightGrayColor];
    self.playCountLabel.alpha = 0.5;
    
    self.durationLabel.frame = CGRectMake(200, 30 + 25, 80, 12);
    self.durationLabel.textColor = [UIColor lightGrayColor];
    self.durationLabel.font = [UIFont systemFontOfSize:12];
    self.durationLabel.alpha = 0.5;

    
    self.createdAtLabel.frame = CGRectMake(90, 30 + 45, kWW / 4 * 3, 12);
    self.createdAtLabel.textColor = [UIColor blackColor];
    self.createdAtLabel.font = [UIFont systemFontOfSize:12];
    self.createdAtLabel.alpha = 0.5;

    self.download.frame = CGRectMake(320, 30 + 25, 20, 20);
    self.download.image = [UIImage imageNamed:@"iconfont-xiazai.png"];

}
- (CGFloat)getStringHeightBaseFont:(CGFloat)font width:(CGFloat)width string:(NSString *)string{
    //计算高度的方法
    CGRect contentRect = [string boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return contentRect.size.height;
}


#pragma mark --- 重写setter方法
- (void)setVoiceModel:(HotVoiceModel *)voiceModel{
    if (_voiceModel != voiceModel) {
        [_voiceModel release];
        [voiceModel retain];
        _voiceModel = voiceModel;
    }
    NSURL *url = [NSURL URLWithString:voiceModel.coverSmall];
    [self.coverSmImage sd_setImageWithURL:url];
    
    _audioTitleLabel.text = voiceModel.title;
    _authorLabel.text = [NSString stringWithFormat:@"By%@" , voiceModel.nickname];
    _playCountLabel.text = [NSString stringWithFormat:@"播放次数：%@", [voiceModel.playsCounts stringValue]];
    _createdAtLabel.text = [NSString stringWithFormat:@"最后更新%@", [voiceModel.createdAt stringValue]];
    _durationLabel.text = [NSString stringWithFormat:@"时长：%@" ,[voiceModel.durationTM stringValue]];

    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
