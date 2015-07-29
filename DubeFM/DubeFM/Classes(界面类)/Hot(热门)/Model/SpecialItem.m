//
//  SpecialItem.m
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialItem.h"

@implementation SpecialItem

- (void)dealloc{
    
    [_ctntType release];
    [_coverPathBig release];
    [_releasedAt release];
    [_specialId release];
    [_subtitle release];
    [_title release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"contentType"]) {
        self.ctntType = value;
    }
}

@end
