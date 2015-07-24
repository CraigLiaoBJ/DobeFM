//
//  LoadingCell.h
//  Xmly
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"



@interface LoadingCell : UITableViewCell


@property(nonatomic, assign) int indexNum;//在那个cell
//下载
@property(nonatomic,copy)NSString *stringUrl;
//专辑
@property(nonatomic,strong)AlbumList *aAlbum;

//imageView
@property (nonatomic, strong) UIImageView *coverImage;
//label
@property (nonatomic, strong) UILabel *titleLabel;
//获取按钮
@property (strong, nonatomic) UIButton *btn;
//获取进度条
@property (strong, nonatomic) UIProgressView *progress;


@end
