//
//  LoadingCell.h
//  Xmly
//
//  Created by DobeFM on 15/7/8.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadedCell : UITableViewCell


//@property (nonatomic, assign) int indexNum;//在那个cell

@property (nonatomic, strong) UIImageView *imagecell;


////下载
//@property (nonatomic, copy) NSString *stringUrl;
////专辑
//@property (nonatomic, strong) AlbumList *aAlbum;
//
////imageView
@property (nonatomic, strong) UIImageView *coverImage;
//label
@property (nonatomic, strong) UILabel *titleLabel;
////获取按钮
//@property (strong, nonatomic) UIButton *btn;
////获取进度条
//@property (strong, nonatomic) UIProgressView *progress;


@end
