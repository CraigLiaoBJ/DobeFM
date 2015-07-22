//
//  SpcAudioDetailModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/20.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpcAudioDetailModel : NSObject


//表视图上面音频信息
@property (nonatomic, copy) NSString *coverSmall;//头像
@property (nonatomic, retain) NSNumber *createdAt;//创建时间
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSNumber *durationTm;//时长
@property (nonatomic, retain) NSNumber *thisID;//音频id
@property (nonatomic, copy) NSString *nickname;//作者名
@property (nonatomic, retain) NSNumber *playsCounts;//播放次数
@property (nonatomic, copy) NSString *playPath32;//播放链接1
@property (nonatomic, copy) NSString *playPath64;//播放连接2

@end
