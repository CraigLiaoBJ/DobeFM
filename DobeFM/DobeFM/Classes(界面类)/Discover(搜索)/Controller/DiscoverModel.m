//
//  DiscoverModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

- (void)dealloc{
    [_coverPath release];
    [_name release];
    [_categoryId release];
    [_title release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.categoryId = value;
    }
}

@end
