//
//  DiscoverModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject

@property (nonatomic, copy) NSString *coverPath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSNumber *categoryId;
@property (nonatomic, copy) NSString *title;

@end
