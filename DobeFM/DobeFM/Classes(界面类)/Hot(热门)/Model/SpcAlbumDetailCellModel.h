//
//  SpcDetailCellModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpcAlbumDetailCellModel : NSObject

//专辑信息
@property (nonatomic, copy) NSString *albumCoverUrl290;//专辑图片
@property (nonatomic, copy) NSString *albumIntro;//专辑信息
@property (nonatomic, retain) NSNumber *lastUptrackAt;//最后更新
@property (nonatomic, retain) NSNumber *albumID;
@property (nonatomic, retain) NSNumber *playsCounts;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, retain) NSNumber *tracks;

@end
