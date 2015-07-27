//
//  HotAnchorItem.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotAnchorItem : NSObject

@property (nonatomic, copy) NSString *largeLogo;//图片
@property (nonatomic, copy) NSString *nickname;//名称
@property (nonatomic, retain) NSNumber *uid;//主播ID

@end
