//
//  AnchorAlbumModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnchorAlbumModel : NSObject

@property (nonatomic, retain) NSNumber *updateAt;

@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, retain) NSNumber *playTimes;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSNumber *tracks;
@property (nonatomic, retain) NSNumber *updatedAt;

@end
