//
//  CellModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (nonatomic, retain) NSNumber *category_id;//类目id
@property (nonatomic, retain) NSString *cover_path;//图片
@property (nonatomic, retain) NSString *tname;//页面名称，中文

@end
