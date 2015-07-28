//
//  AlbumList.h
//  Xmly
//
//  Created by DobeFM on 15/6/29.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumList : NSObject

@property (nonatomic, copy) NSString *albumId;//专辑id
@property (nonatomic, copy) NSString *albumImage;//专辑图片
@property (nonatomic, copy) NSString *albumTitle;//专辑标题
@property (nonatomic, copy) NSString *title1;//声音标题
@property (nonatomic, copy) NSString *playPathAacv164;//播放url
@property (nonatomic, copy) NSString *trackId;//id
@property (nonatomic, retain) NSNumber *durationTime;//播放总时长

@property (nonatomic, copy) NSString *downloadAacUrl;//下载的URL
@property (nonatomic, copy) NSString *downloadAacSize;//下载的资源大小

@property (nonatomic, copy) NSString *downloadUrl;//第二下载的URL
@property (nonatomic, copy) NSString *downloadSize;//第二下载的资源大小

@property (nonatomic, copy) NSString *playUrl32;//第二播放url
@property (nonatomic, assign) bool isSelect;//是否被批量选中下载


//@property (nonatomic, copy) NSString *coverSmall;

@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *nickname;//作者名字
@property (nonatomic, retain) NSNumber *durationTm;//时间跨度
@property (nonatomic, retain) NSNumber *playtimes;//播放次数

@property (nonatomic, retain) NSString *playUrl64;//播放连接

@property (nonatomic, retain) NSNumber *createdAt;//创建时间

@end
