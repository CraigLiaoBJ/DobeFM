//
//  AlbumItem.m
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "AlbumItem.h"

@implementation AlbumItem


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTm = value;
    }
}
@end
