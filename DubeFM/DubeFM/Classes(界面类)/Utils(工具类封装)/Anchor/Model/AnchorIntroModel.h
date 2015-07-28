//
//  AnchorIntroModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnchorIntroModel : NSObject

@property (nonatomic, copy) NSString *mobileMiddleLogo;//头像
@property (nonatomic, copy) NSString *nickname;//名字
@property (nonatomic, copy) NSString *personalSignature;//介绍
@property (nonatomic, copy) NSString *smallPic;
@property (nonatomic, retain) NSNumber *tracks_counts;
@property (nonatomic, retain) NSNumber *anchorUid;
@property (nonatomic, retain) NSString *intro;

@end
