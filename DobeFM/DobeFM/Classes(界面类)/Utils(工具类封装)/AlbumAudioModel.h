//
//  AlbumModel.h
//  DobeFM
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumAudioModel : NSObject

//音频部分

@property (nonatomic, copy) NSString *title;//音频名
@property (nonatomic, copy) NSString *smallLogo;
@property (nonatomic, copy) NSString *coverSmall;//封面图片
@property (nonatomic, copy) NSString *coverLarge;//封面大图片
@property (nonatomic, copy) NSString *nickname;//作者名字
@property (nonatomic, retain) NSString *downloadSize;//下载大小
@property (nonatomic, retain) NSString *downloadUrl;//下载链接
@property (nonatomic, retain) NSNumber *durationTm;//时间跨度
@property (nonatomic, retain) NSNumber *playtimes;//播放次数

@property (nonatomic, retain) NSString *playUrl32;//播放连接
@property (nonatomic, retain) NSString *playUrl64;//播放连接

@property (nonatomic, retain) NSNumber *trackId;//音频ID
@property (nonatomic, retain) NSNumber *createdAt;//创建时间

@end
