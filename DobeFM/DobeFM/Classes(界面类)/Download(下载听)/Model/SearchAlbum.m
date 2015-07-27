//
//  searchAlbum.m
//  Xmly
//
//  Created by DobeFM on 15/6/29.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SearchAlbum.h"

@implementation SearchAlbum


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTm = value;
    }
    if ([key isEqualToString:@"albumCoverUrl290"] ||[key isEqualToString:@"coverMiddle"] ) {
        self.coverOrige = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.albumId = value;
    }
}

@end
