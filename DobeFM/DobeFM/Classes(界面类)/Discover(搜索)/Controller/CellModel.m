//
//  CellModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

- (void)dealloc{
    
    [_category_id release];
    [_cover_path release];
    [_tname release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
