//
//  AnchorAlumbCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AlbumCell.h"

@interface AlbumCell ()
@property (nonatomic, retain)UIImageView *cellImageView;
//
////表视图上面音频信息
@property (nonatomic, retain) UIImageView *coverSmImage;
@property (nonatomic, retain) UILabel *audioTitleLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, assign) UILabel *durationLabel;
//@property (nonatomic, retain) UIImageView *download;

@end

@implementation AlbumCell

- (void)dealloc{
//    [_searchAlbum release];
    [_coverSmImage release];
    [_audioTitleLabel release];
    [_authorLabel release];
    [_durationLabel release];
    [super dealloc];
}

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
    
    self.coverSmImage.frame = CGRectMake(5, 15, 60, 60);
    self.coverSmImage.backgroundColor  = [UIColor colorWithRed:0.359 green:0.672 blue:1.000 alpha:1.000];
    self.coverSmImage.layer.cornerRadius = 30.f;
    self.coverSmImage.layer.masksToBounds = YES;
    
    UIImageView *albumImage = [[UIImageView alloc]initWithFrame:CGRectMake(70, 15, 20, 20)];
    albumImage.image = [UIImage imageNamed:@"iconfont-zhuanji.png"];
    [self.cellImageView addSubview:albumImage];
    [albumImage release];
    
    self.audioTitleLabel.frame = CGRectMake(90, 20, kWW, 20);
    self.audioTitleLabel.font = [UIFont systemFontOfSize:15];
    //    CGFloat height = [self getStringHeightBaseFont:14 width:kWW / 2 string:self.audioTitleLabel.text];
    //    self.audioTitleLabel.frame = CGRectMake(90, 5, kWW - 90, height);
    self.audioTitleLabel.numberOfLines = 0;
    
    self.durationLabel.frame = CGRectMake(90, 50, 80, 20);
    self.durationLabel.textColor = [UIColor grayColor];
    self.durationLabel.font = [UIFont systemFontOfSize:15];
    self.durationLabel.alpha = 0.5;
    
}

- (void)setSearchAlbum:(SearchAlbum *)searchAlbum{
    if (_searchAlbum != searchAlbum) {
        [_searchAlbum release];
        [searchAlbum retain];
        _searchAlbum = searchAlbum;
    }
    NSURL *url = [NSURL URLWithString:searchAlbum.coverOrige];
    [self.coverSmImage sd_setImageWithURL:url];
    
    _audioTitleLabel.text = searchAlbum.title;
    _durationLabel.text = [NSString stringWithFormat:@"音频：%@" ,[searchAlbum.tracks stringValue]];
}

@end
