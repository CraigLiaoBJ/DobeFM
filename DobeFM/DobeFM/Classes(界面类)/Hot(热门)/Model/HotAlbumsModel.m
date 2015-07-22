//
//  HotAlbumsModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/20.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAlbumsModel.h"

@implementation HotAlbumsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.albumId = value;
    }
}

@end
