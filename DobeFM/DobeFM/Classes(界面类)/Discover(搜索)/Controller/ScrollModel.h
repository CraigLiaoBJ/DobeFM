//
//  ScrollModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollModel : NSObject

@property (nonatomic, retain) NSNumber *albumId;//专辑id
@property (nonatomic, retain) NSNumber *scrollId;//轮播图Id
@property (nonatomic, assign) NSInteger thisType;//类型
@property (nonatomic, copy) NSString *pic;//图片
@property (nonatomic, retain) NSNumber *uid;//主播UID

@end
