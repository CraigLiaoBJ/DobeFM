//
//  HotVoiceModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotVoiceModel : NSObject
@property (nonatomic, retain) NSString *coverSmall;
@property (nonatomic, copy) NSString *albumTitle;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSNumber *playsCounts;
@property (nonatomic, retain) NSNumber *updatedAt;
@property (nonatomic, retain) NSNumber *durationTM;
@property (nonatomic, retain) NSNumber *createdAt;
@property (nonatomic, copy) NSString *playPath32;

@end
