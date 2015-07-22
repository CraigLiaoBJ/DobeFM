//
//  AlbumCell.m
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellImageView = [[UIImageView alloc]init];
        [self addSubview:_cellImageView];
        
        self.coverSmImage = [[UIImageView alloc]init];
        [self.cellImageView addSubview:self.coverSmImage];
        
        self.audioTitleLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.audioTitleLabel];
        
        self.authorLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.authorLabel];
        
        self.playCountLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.playCountLabel];
        
        self.durationLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.durationLabel];
        
        self.createdAtLabel = [[UILabel alloc]init];
        [self.cellImageView addSubview:self.createdAtLabel];
        
        self.download = [[UIImageView alloc]init];
        [self.cellImageView addSubview:self.download];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellImageView.frame = CGRectMake(0, 10, kWW, 90);
    self.cellImageView.backgroundColor = [UIColor colorWithRed:0.777 green:0.996 blue:1.000 alpha:1.000];
   
    self.coverSmImage.frame = CGRectMake(5, 15, 60, 60);
    self.coverSmImage.backgroundColor  = [UIColor colorWithRed:0.359 green:0.672 blue:1.000 alpha:1.000];
    self.coverSmImage.layer.cornerRadius = 30.f;
    self.coverSmImage.layer.masksToBounds = YES;
    
    self.audioTitleLabel.frame = CGRectMake(70, 20, kWW / 2, 20);
    
    self.authorLabel.frame = CGRectMake(70, 40, 100, 20);
    self.authorLabel.font = [UIFont systemFontOfSize:15];
    self.authorLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.alpha = 0.5;
    
//    self.playCountLabel.frame = CGRectMake(70, 60, 80, 20);
//    self.playCountLabel.font = [UIFont systemFontOfSize:15];
//    self.playCountLabel.textColor = [UIColor lightGrayColor];
//    self.playCountLabel.alpha = 0.5;
    
    self.durationLabel.frame = CGRectMake(160, 60, 80, 20);
    self.durationLabel.textColor = [UIColor lightGrayColor];
    self.durationLabel.font = [UIFont systemFontOfSize:15];
    self.durationLabel.alpha = 0.5;
 
    self.createdAtLabel.frame = CGRectMake(kWW - 75, 20, 80, 20);
    self.createdAtLabel.textColor = [UIColor blackColor];
    self.createdAtLabel.font = [UIFont systemFontOfSize:15];
    self.createdAtLabel.alpha = 0.5;
    
    self.download.frame = CGRectMake(kWW - 50, 50, 20, 20);
    self.download.image = [UIImage imageNamed:@"iconfont-ordinarydownload.png"];
}

- (void)setAlbumAudioModel:(AlbumAudioModel *)albumAudioModel{
    if (_albumAudioModel != albumAudioModel) {
        [_albumAudioModel release];
        [albumAudioModel retain];
        _albumAudioModel = albumAudioModel;
    }
    NSURL *coverUrl = [NSURL URLWithString:albumAudioModel.coverLarge];
    [self.coverSmImage sd_setImageWithURL:coverUrl];
    self.audioTitleLabel.text = albumAudioModel.title;
    self.authorLabel.text = [NSString stringWithFormat:@"By%@", albumAudioModel.nickname];
//    self.playCountLabel.text = [albumAudioModel.playtimes stringValue];
    self.createdAtLabel.text = [albumAudioModel.createdAt stringValue];
    self.durationLabel.text = [albumAudioModel.durationTm stringValue];
}

- (void)dealloc{
    [_cellImageView release];
    [_coverSmImage release];
    [_audioTitleLabel release];
    [_audioTitleLabel release];
//    [_playCountLabel release];
    [_durationLabel release];
    [_createdAtLabel release];
    [_download release];
    [super dealloc];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
