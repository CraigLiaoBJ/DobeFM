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
    self.coverImage.frame = CGRectMake(20, 100, kWW / 4, kWW / 4);
    
    //作者头像
    self.iconImage.frame = CGRectMake(kWW / 4 + 30, 30 + 64, kWW / 8, kWW / 8);
    self.iconImage.layer.cornerRadius = kWW / 16;
    self.iconImage.layer.masksToBounds = YES;
    
    //作者名称
    self.authorTitleLbl.frame = CGRectMake(kWW / 4 + 30 + kWW / 8 + 5, 30 + 64 + 15, kWW / 3, 20);
    self.authorTitleLbl.font = [UIFont boldSystemFontOfSize:16];

    //简介
    self.introLabel.frame = CGRectMake(20 + kWW / 4 + 10, 30 + kWW / 5 + 64, kWW / 2 - 20, 0);
    self.introLabel.font = [UIFont systemFontOfSize:13];
    self.introLabel.numberOfLines = 0;
    CGFloat height = [self getStringHeightBaseFont:13 width:kWW / 2  string:self.introLabel.text];
    self.introLabel.frame = CGRectMake(20 + kWW / 4 + 10, 30 + kWW / 5 + 64, kWW / 2 - 20, height);
}

- (CGFloat)getStringHeightBaseFont:(CGFloat)font width:(CGFloat)width string:(NSString *)string{
    //计算高度的方法
    CGRect contentRect = [string boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return contentRect.size.height;
}

- (void)setAlbumItem:(AlbumItem *)albumItem{
    NSURL *bgdUrl = [NSURL URLWithString:albumItem.coverLarge];
    [self.bgdImageView sd_setImageWithURL:bgdUrl];
    self.authorTitleLbl.text = albumItem.nickname;
    NSURL *coverUrl = [NSURL URLWithString:albumItem.coverOrigin];
    [self.coverImage sd_setImageWithURL:coverUrl];
    NSURL *iconUrl = [NSURL URLWithString:albumItem.avatarPath];
    [self.iconImage sd_setImageWithURL:iconUrl];
    self.introLabel.text = albumItem.intro;
    NSLog(@"coverimage ==== %@", coverUrl);
    NSLog(@"intro === %@", albumItem.introRich);
}
@end
