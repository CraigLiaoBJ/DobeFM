//
//  AlbumList.m
//  Xmly
//
//  Created by DobeFM on 15/6/29.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AlbumList.h"

@implementation AlbumList

- (void)dealloc{
    [_albumId release];//专辑id
    [_albumImage release];//专辑图片
    [_albumTitle release];//专辑标题
    [_title1 release];//声音标题
    [_playPathAacv164 release];//播放url
    [_trackId release];//id
    [_durationTime release];//播放总时长
    
    [_downloadAacUrl release];//下载的URL
    [_downloadAacSize release];//下载的资源大小
    
    [_downloadUrl release];//第二下载的URL
    [_downloadSize release];//第二下载的资源大小
    
    [_playUrl32 release];//第二播放url
    
    [_coverLarge release];
    [_nickname release];//作者名字
    [_durationTm release];//时间跨度
    [_playtimes release];//播放次数
    
    [_playUrl64 release];//播放连接
    
    [_createdAt release];//创建时间
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTime = value;
    }
    if ([key isEqualToString:@"title"]) {
        self.title1 = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.trackId = value;
    }
    if ([key isEqualToString:@"coverSmall"]||[key isEqualToString:@"coverLarge"]) {
        self.coverLarge = value;
    }
    if ([key isEqualToString:@"playPath32"]) {
        self.playUrl32 = value;
        self.downloadUrl = value;
    }
    if ([key isEqualToString:@"playPath64"]) {
        self.playPathAacv164 = value;
        self.downloadUrl = value;
    }
}

@end
