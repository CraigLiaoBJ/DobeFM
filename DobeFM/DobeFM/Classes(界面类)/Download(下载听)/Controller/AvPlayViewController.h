//
//  AvPlayViewController.h
//  Xmly
//
//  Created by lanou3g on 15/6/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AlbumList.h"
#import "SearchAlbum.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AvPlayViewController : UIViewController


@property (nonatomic, strong) NSMutableArray *albumList;//播放list

@property (nonatomic, strong) SearchAlbum *sAlbum;//

@property (nonatomic, assign) NSInteger playCurrent;//当前播放的地址

@property (nonatomic, assign) bool isPlay;//是否播放

- (void) replayMusic;

//albumList 声音list   sAlbum 专辑信息
- (void) initWithAvplayer:(NSInteger)playCurrent  albumList:(NSMutableArray*)albumList sAlbum:(SearchAlbum *)sAlbum;

@end
