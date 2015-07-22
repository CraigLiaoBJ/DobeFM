//
//  LoadDownBase.h
//  Xmly
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlbumList.h"
@interface LoadDownBase : NSObject
- (void)setLoadData:(NSString *)sender plsitName:(NSString*) plistName albumName:(AlbumList *) album;//b保存数据

- (void)loadAudioToLocation:(NSString *)urlStr styp:(NSString*)stype albumName:(AlbumList *) album;//下载到本地

- (NSMutableDictionary*)getListerHistoryList;//获取播放历史

- (void)removeObjOfPlist:(NSString*) stractId splistName:(NSString*)plistName;//移除字典对象


- (AlbumList*)getLoadingList;//获下载列表

- (bool) isLoadingList;//获下载列表 是否为空

-(AlbumList*)arrayToAlbumList:(NSArray*)arr;//array 转化 AlbumList
//获取plist的歌曲列表 p
- (NSMutableDictionary*)getLoadDownPlish:(NSString*)plistName plistPath:(NSString*) plistPath;
@end
