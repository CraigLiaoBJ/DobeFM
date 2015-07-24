//
//  AlbumIntro.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AlbumIntro.h"
#define kWW self.frame.size.width
#define kHH self.frame.size.height

@interface AlbumIntro ()
@property (nonatomic, retain) UIImageView *bgdImageView;
@property (nonatomic, retain) UIVisualEffectView *bgdEffect;
@property (nonatomic, retain) UIImageView *coverImage;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *authorTitleLbl;
@property (nonatomic, retain) UILabel *introLabel;

@end

@implementation AlbumIntro

//- (void)dealloc{
////    [_albumItem release];
//    [_bgdImageView release];
//    [_bgdEffect release];
//    [_coverImage release];
//    [_iconImage release];
//    [_authorTitleLbl release];
//    [_introLabel release];
//    [super dealloc];
//}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //大背景图片
        self.bgdImageView = [[UIImageView alloc]init];
        [self addSubview:self.bgdImageView];
        [_bgdImageView release];
        
        //毛玻璃
        self.bgdEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        [self.bgdImageView addSubview:self.bgdEffect];
        [_bgdEffect release];
        
        //专辑图片
        self.coverImage = [[UIImageView alloc]init];
//        self.coverImage.backgroundColor = [UIColor brownColor];
        [self.bgdEffect addSubview:self.coverImage];
        [_coverImage release];
        
        //作者头像
        self.iconImage = [[UIImageView alloc]init];
//        self.iconImage.backgroundColor = [UIColor brownColor];
        [self.bgdEffect addSubview:self.iconImage];
        [_iconImage release];
        
        //作者名称
        self.authorTitleLbl = [[UILabel alloc]init];
        [self.bgdEffect addSubview:self.authorTitleLbl];
        [_authorTitleLbl release];
        
        //简介
        self.introLabel = [[UILabel alloc]init];
//        self.introLabel.backgroundColor = [UIColor brownColor];
        [self.bgdEffect addSubview:self.introLabel];
        [_introLabel release];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //大背景图片
    self.bgdImageView.frame = self.frame;
    self.bgdImageView.userInteractionEnabled = YES;
    self.bgdImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //毛玻璃
    self.bgdEffect.frame = self.frame;

    //专辑图片
    self.coverImage.frame = CGRectMake(20, 74, kWW / 4, kWW / 4);
    
    //作者头像
    self.iconImage.frame = CGRectMake(kWW / 4 + 30, 74, kWW / 8, kWW / 8);
    self.iconImage.layer.cornerRadius = kWW / 16;
    self.iconImage.layer.masksToBounds = YES;
    
    //作者名称
    self.authorTitleLbl.frame = CGRectMake(kWW / 4 + 30 + kWW / 8 + 5, 74 + kWW / 16 - 10, kWW / 3, 20);
    self.authorTitleLbl.font = [UIFont boldSystemFontOfSize:16];

    //简介
    self.introLabel.frame = CGRectMake(30 + kWW / 4, 74 + kWW / 8, kWW  - kWW / 4 - 35, 50);
    self.introLabel.font = [UIFont systemFontOfSize:12];
    self.introLabel.numberOfLines = 0;

}


- (void)setAlbumItem:(AlbumItem *)albumItem{
    if (_albumItem != albumItem) {
        [_albumItem release];
        [albumItem retain];
        _albumItem = albumItem;
    }
    NSURL *bgdUrl = [NSURL URLWithString:albumItem.coverLarge];
    [self.bgdImageView sd_setImageWithURL:bgdUrl];
    self.authorTitleLbl.text = albumItem.nickname;
    NSURL *coverUrl = [NSURL URLWithString:albumItem.coverOrigin];
    [self.coverImage sd_setImageWithURL:coverUrl];
    NSURL *iconUrl = [NSURL URLWithString:albumItem.avatarPath];
    [self.iconImage sd_setImageWithURL:iconUrl];
    self.introLabel.text = albumItem.intro;
 }
@end
