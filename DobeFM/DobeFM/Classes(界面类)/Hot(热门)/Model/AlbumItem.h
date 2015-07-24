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
@property (nonatomic, copy) NSString *avatarPath;//头像
@property (nonatomic, retain) NSNumber *
categoryId;//类ID
@property (nonatomic, copy) NSString *categoryName;//类名
@property (nonatomic, copy) NSString *coverLarge;//封面大图
@property (nonatomic, copy) NSString *coverOrigin;
@property (nonatomic, copy) NSString *coverSmall;//小图
@property (nonatomic, copy) NSString *coverWebLarge;//网络图片
@property (nonatomic, retain) NSNumber *createdAt;
@property (nonatomic, assign) BOOL hasNew;//布尔值
@property (nonatomic, copy) NSString *intro;//内容简介
@property (nonatomic, copy) NSString *introRich;//压缩版简介
@property (nonatomic, copy) NSString *nickname;//作者名字
@property (nonatomic, copy) NSString *playTimes;//播放次数
@property (nonatomic, copy) NSString *tags;//标签
@property (nonatomic, copy) NSString *title;//专辑名称
@property (nonatomic, retain) NSNumber *tracks;//音频数量


@end
