//
//  AlbumItem.h
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumItem : NSObject

//专题介绍部分
@property (nonatomic, retain) NSNumber *albumId;//专辑ID
@property (nonatomic, retain) NSString *avatarPath;//头像
@property (nonatomic, retain) NSNumber *
categoryId;//类ID
@property (nonatomic, retain) NSString *categoryName;//类名
@property (nonatomic, retain) NSString *coverLarge;//封面大图
@property (nonatomic, retain) NSString *coverOrigin;
@property (nonatomic, retain) NSString *coverSmall;//小图
@property (nonatomic, retain) NSString *coverWebLarge;//网络图片
@property (nonatomic, retain) NSNumber *createdAt;
@property (nonatomic, assign) BOOL hasNew;//布尔值
@property (nonatomic, retain) NSString *intro;//内容简介
@property (nonatomic, retain) NSString *introRich;//压缩版简介
@property (nonatomic, retain) NSString *nickname;//作者名字
@property (nonatomic, retain) NSString *playTimes;//播放次数
@property (nonatomic, retain) NSString *tags;//标签
@property (nonatomic, retain) NSString *title;//专辑名称
@property (nonatomic, retain) NSNumber *tracks;//音频数量

//音频部分

@property (nonatomic, retain) NSString *downloadSize;//下载大小
@property (nonatomic, retain) NSString *downloadUrl;//下载链接
@property (nonatomic, retain) NSString *durationTm;//时间跨度
@property (nonatomic, retain) NSString *playtimes;//播放次数

@property (nonatomic, retain) NSString *playUrl32;//播放连接
@property (nonatomic, retain) NSString *playUrl64;//播放连接

@property (nonatomic, retain) NSString *trackId;//音频ID

@end
