//
//  AnchorCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/27.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AnchorCell.h"

@interface AnchorCell ()
@property (nonatomic, retain)UIImageView *cellImageView;
////表视图上面音频信息
@property (nonatomic, retain) UIImageView *coverSmImage;
@property (nonatomic, retain) UILabel *audioCountLabel;
@property (nonatomic, retain) UILabel *anchorLabel;
@property (nonatomic, retain) UILabel *introLabel;
@end

@implementation AnchorCell

- (void)dealloc{
    [_cellImageView release];
    [_coverSmImage release];
    [_audioCountLabel release];
    [_anchorLabel release];
    [_introLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellImageView = [[[UIImageView alloc]init]autorelease];
        [self addSubview:_cellImageView];
        //        [_cellImageView release];
        
        self.coverSmImage = [[[UIImageView alloc]init]autorelease];
        [self.cellImageView addSubview:self.coverSmImage];
        //        [_coverSmImage release];
        
        self.audioCountLabel = [[[UILabel alloc]init]autorelease];
        [self.cellImageView addSubview:self.audioCountLabel];
        //        [_audioTitleLabel release];
        
        self.anchorLabel = [[[UILabel alloc]init]autorelease];
        [self.cellImageView addSubview:self.anchorLabel];
        //        [_authorLabel release];
        
        self.introLabel = [[[UILabel alloc]init]autorelease];
        [self.cellImageView addSubview:self.introLabel];
        //        [_durationLabel release];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellImageView.frame = CGRectMake(0, 10, kWW, 90);
    self.cellImageView.backgroundColor = cellImageColor;
    
    self.coverSmImage.frame = CGRectMake(5, 5, 80, 80);
    self.coverSmImage.backgroundColor  = [UIColor colorWithRed:0.359 green:0.672 blue:1.000 alpha:1.000];
    
    self.anchorLabel.frame = CGRectMake(90, 5, kWW - 120, 15);
    self.anchorLabel.font = [UIFont boldSystemFontOfSize:15];
    
    self.audioCountLabel.frame = CGRectMake(90, 30, kWW - 120, 13);
    self.audioCountLabel.font = [UIFont systemFontOfSize:13];
    self.audioCountLabel.numberOfLines = 0;
    
    self.introLabel.frame = CGRectMake(90, 50, kWW - 100, 40);
    self.introLabel.textColor = [UIColor grayColor];
    self.introLabel.font = [UIFont systemFontOfSize:13];
    self.introLabel.numberOfLines = 0;
    self.introLabel.alpha = 0.5;
}

- (void)setAnchorInfo:(AnchorIntroModel *)anchorInfo{
    if (_anchorInfo != anchorInfo) {
        [_anchorInfo release];
        [anchorInfo retain];
        _anchorInfo = anchorInfo;
    }
    NSURL *url = [NSURL URLWithString:anchorInfo.smallPic];
    [self.coverSmImage sd_setImageWithURL:url];
    
    _anchorLabel.text = anchorInfo.nickname;
    _audioCountLabel.text = [NSString stringWithFormat:@"音频：%@" ,[anchorInfo.tracks_counts stringValue]];
    
    _introLabel.text = anchorInfo.intro;
}

@end
