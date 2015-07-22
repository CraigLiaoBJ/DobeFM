//
//  SpcAVDetailCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SpcAVDetailCell.h"

@implementation SpcAVDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 375, 90)];
        self.cellImageView.backgroundColor = [UIColor colorWithRed:0.777 green:0.996 blue:1.000 alpha:1.000];
        [self addSubview:_cellImageView];
        [_cellImageView release];
        
        self.coverSmImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 60, 60)];
        self.coverSmImage.backgroundColor  = [UIColor colorWithRed:0.359 green:0.672 blue:1.000 alpha:1.000];
        self.coverSmImage.layer.cornerRadius = 30.f;
        self.coverSmImage.layer.masksToBounds = YES;
        [self.cellImageView addSubview:self.coverSmImage];
        [_coverSmImage release];
        
        self.audioTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 200, 20)];
        [self.cellImageView addSubview:self.audioTitleLabel];
        [_audioTitleLabel release];
        
        self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 100 , 20)];
        self.authorLabel.font = [UIFont systemFontOfSize:15];
        self.authorLabel.textColor = [UIColor lightGrayColor];
        self.authorLabel.alpha = 0.5;
        [self.cellImageView addSubview:self.authorLabel];
        [_authorLabel release];
        
        self.playCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, 80, 20)];
        self.playCountLabel.font = [UIFont systemFontOfSize:15];
        self.playCountLabel.textColor = [UIColor lightGrayColor];
        self.playCountLabel.alpha = 0.5;
        [self.cellImageView addSubview:self.playCountLabel];
        [_playCountLabel release];
        
        self.durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 50, 80, 20)];
        self.durationLabel.textColor = [UIColor lightGrayColor];
        self.durationLabel.font = [UIFont systemFontOfSize:15];
        self.durationLabel.alpha = 0.5;
        [self.cellImageView addSubview:self.durationLabel];
        [_durationLabel release];
        
        self.createdAtLabel = [[UILabel alloc]initWithFrame: CGRectMake(70, 70, 200, 20)];
        self.createdAtLabel.textColor = [UIColor blackColor];
        self.createdAtLabel.font = [UIFont systemFontOfSize:15];
        self.createdAtLabel.alpha = 0.5;
        [self.cellImageView addSubview:self.createdAtLabel];
        [_createdAtLabel release];
        
        UIImageView *favorite = [[UIImageView alloc]initWithFrame:CGRectMake(320, 50, 20, 20)];
        favorite.image = [UIImage imageNamed:@"iconfont-xiazai.png"];
        [self.cellImageView addSubview:favorite];
        [favorite release];
        
    }
    return self;
}

#pragma mark --- 重写setter方法
- (void)setSpcAudioDtlModel:(SpcAudioDetailModel *)spcAudioDtlModel{
    if (_spcAudioDtlModel != spcAudioDtlModel) {
        [_spcAudioDtlModel release];
        [spcAudioDtlModel retain];
        _spcAudioDtlModel = spcAudioDtlModel;
    }
    NSURL *url = [NSURL URLWithString:spcAudioDtlModel.coverSmall];
    [self.coverSmImage sd_setImageWithURL:url];
    self.audioTitleLabel.text = spcAudioDtlModel.title;
    self.authorLabel.text = [NSString stringWithFormat:@"By%@", spcAudioDtlModel.nickname];
    self.playCountLabel.text = [spcAudioDtlModel.playsCounts stringValue];
    self.createdAtLabel.text = [NSString stringWithFormat:@"最后更新：%@", [spcAudioDtlModel.createdAt stringValue]];
    self.durationLabel.text = [spcAudioDtlModel.durationTm stringValue];
}

@end
