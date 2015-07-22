//
//  HotAlbumCell.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/20.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAlbumCell.h"

@interface HotAlbumCell ()

@property (nonatomic, retain) UIImageView *cellImageView;
@property (nonatomic, retain) UILabel *hotAlbumLabel;
@property (nonatomic, retain) UIImageView *coverImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *nameLabel;

@end
@implementation HotAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.cellImageView = [[UIImageView alloc]init];
//        [self addSubview:self.cellImageView];
        
        //专题标题
        self.hotAlbumLabel = [[UILabel alloc]init];
        [self addSubview:self.hotAlbumLabel];
        
        //专题小图片
        self.coverImage = [[UIImageView alloc]init];
        [self addSubview:self.coverImage];
        
        //专题名字
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        
        //展开图标
//        UIImageView *moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH / 4 * 3, 12.5, 25, 25)];
//        moreImage.image = [UIImage imageNamed:@"hotView-more.png"];
//        [special addSubview:moreImage];

    }
    return self;
}

- (void)layoutSubviews{
    //专题小图片
    self.coverImage.frame = CGRectMake(20, 5, 30, 30);
//    self.coverImage.layer.cornerRadius = 15.f;
//    self.coverImage.layer.masksToBounds = YES;
    
    //专题名字
    self.titleLabel.frame = CGRectMake(60, 12, kWW / 3 * 2, 20);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setHotAlbumsModel:(HotAlbumsModel *)hotAlbumsModel{
    if (_hotAlbumsModel != hotAlbumsModel) {
        [_hotAlbumsModel release];
        [hotAlbumsModel retain];
        _hotAlbumsModel = hotAlbumsModel;
    }
    
    NSURL *url = [NSURL URLWithString:hotAlbumsModel.coverSmall];
    [self.coverImage sd_setImageWithURL:url];
    self.titleLabel.text = hotAlbumsModel.title;
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
