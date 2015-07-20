//
//  SpcDetailCellModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpcDetailCellModel : NSObject

//表视图上面音频信息
@property (nonatomic, copy) NSString *coverSmall;//头像
@property (nonatomic, retain) NSNumber *createdAt;//创建时间
@property (nonatomic, retain) NSNumber *durationTm;//时长
@property (nonatomic, retain) NSNumber *thisID;//音频id
@property (nonatomic, copy) NSString *authorName;//作者名
@property (nonatomic, retain) NSNumber *playsCounts;//播放次数
@property (nonatomic, copy) NSString *playPath32;//播放链接1
@property (nonatomic, copy) NSString *playPath64;//播放连接2


//专辑信息
@property (nonatomic, copy) NSString *albumCoverUrl290;//专辑图片
@property (nonatomic, copy) NSString *albumIntro;//专辑信息
@property (nonatomic, retain) NSNumber *lastUptrackAt;//最后更新


@end
