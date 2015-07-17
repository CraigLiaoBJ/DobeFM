//
//  AlbumCell.m
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 375, 90)];
//        self.cellImageView.backgroundColor = [UIColor colorWithRed:0.777 green:0.996 blue:1.000 alpha:1.000];
//        [self addSubview:_cellImageView];
//        [_cellImageView release];
//        
//        self.coverSmImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
//        self.coverSmImage.backgroundColor  = [UIColor colorWithRed:0.359 green:0.672 blue:1.000 alpha:1.000];
//        self.coverSmImage.layer.cornerRadius = 50.f;
//        self.coverSmImage.layer.masksToBounds = YES;
//        [self.cellImageView addSubview:self.coverSmImage];
//        [_coverSmImage release];
//        
//        self.audioTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 200, 20)];
//        self.audioTitleLabel.text = @"这里是标题啦";
//        [self.cellImageView addSubview:self.audioTitleLabel];
//        [_audioTitleLabel release];
//        
//        self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, 100 , 20)];
//        NSString *string = @"yello";
//        self.authorLabel.text = [NSString stringWithFormat:@"By%@" , string];
//        self.authorLabel.font = [UIFont systemFontOfSize:15];
//        self.authorLabel.textColor = [UIColor lightGrayColor];
//        self.authorLabel.alpha = 0.5;
//        [self.cellImageView addSubview:self.authorLabel];
//        [_authorLabel release];
//        
//        self.playCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 60, 80, 20)];
//        self.playCountLabel.text = @"123万";
//        self.playCountLabel.font = [UIFont systemFontOfSize:15];
//        self.playCountLabel.textColor = [UIColor lightGrayColor];
//        self.playCountLabel.alpha = 0.5;
//        [self.cellImageView addSubview:self.playCountLabel];
//        [_playCountLabel release];
//        
//        self.durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 60, 80, 20)];
//        self.durationLabel.text = @"03:59";
//        self.durationLabel.textColor = [UIColor lightGrayColor];
//        self.durationLabel.font = [UIFont systemFontOfSize:15];
//        self.durationLabel.alpha = 0.5;
//        [self.cellImageView addSubview:self.durationLabel];
//        [_durationLabel release];
//        
//        self.createdAtLabel = [[UILabel alloc]initWithFrame: CGRectMake(300, 20, 80, 20)];
//        self.createdAtLabel.textColor = [UIColor blackColor];
//        self.createdAtLabel.text = @"三个月前";
//        self.createdAtLabel.font = [UIFont systemFontOfSize:15];
//        self.createdAtLabel.alpha = 0.5;
//        [self.cellImageView addSubview:self.createdAtLabel];
//        [_createdAtLabel release];
//        
//        UIImageView *download = [[UIImageView alloc]initWithFrame:CGRectMake(320, 50, 20, 20)];
//        download.image = [UIImage imageNamed:@"iconfont-ordinarydownload.png"];
//        [self.cellImageView addSubview:download];
//        [download release];
//        
//    }
//    return self;
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
