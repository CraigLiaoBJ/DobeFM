//
//  ScrollModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollModel : NSObject

@property (nonatomic, retain) NSNumber *albumId;
@property (nonatomic, retain) NSNumber *scrollId;
@property (nonatomic, assign) NSInteger thisType;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, retain) NSNumber *uid;

@end
