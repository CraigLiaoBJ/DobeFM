//
//  HotModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject
//轮播图
@property (nonatomic, retain) NSNumber *clickID;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, assign) NSInteger typeId;
@property (nonatomic, retain) NSString *albumId;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *specialId;

@end
