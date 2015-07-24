//
//  HotAlbumsModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/20.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotAlbumsModel : NSObject

@property (nonatomic, copy) NSString *coverSmall;//专辑图片
@property (nonatomic, copy) NSString *title;//专辑名称
@property (nonatomic, retain) NSNumber *albumId;//专辑ID

@end

