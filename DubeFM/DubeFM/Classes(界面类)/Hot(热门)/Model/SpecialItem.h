//
//  SpecialItem.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialItem : NSObject

@property (nonatomic, retain) NSNumber *ctntType;
@property (nonatomic, retain) NSString *coverPathBig;
@property (nonatomic, retain) NSNumber *releasedAt;
@property (nonatomic, retain) NSNumber *specialId;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) BOOL isHot;

@end
