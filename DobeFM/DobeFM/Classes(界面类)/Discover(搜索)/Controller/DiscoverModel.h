//
//  DiscoverModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject

@property (nonatomic, copy) NSString *coverPath;//类别图片
@property (nonatomic, copy) NSString *name;//类别名称，用于接口取数据
@property (nonatomic, retain) NSNumber *categoryId;//类别ID
@property (nonatomic, copy) NSString *title;//类别名称，汉字

@end
