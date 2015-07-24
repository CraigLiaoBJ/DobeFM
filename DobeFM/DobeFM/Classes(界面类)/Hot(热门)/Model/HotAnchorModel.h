//
//  HotAnchorModel.h
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotAnchorModel : NSObject

@property (nonatomic, retain) NSNumber *listID;
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;

@end