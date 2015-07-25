//
//  ScrollModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "ScrollModel.h"

@implementation ScrollModel

- (void)dealloc{
    
    [_albumId release];
    [_scrollId release];
    [_pic release];
    [_uid release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.scrollId = value;
    }
    if ([key isEqualToString:@"type"]) {
        self.thisType = [value intValue];
    }
}

@end
