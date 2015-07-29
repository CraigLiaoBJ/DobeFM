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
    if ([key isEqualToString:@"albumCoverUrl290"] ||[key isEqualToString:@"coverMiddle"]||[key isEqualToString:@"cover_path"] ) {
        self.coverOrige = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.albumId = value;
    }
    if (([key isEqualToString:@"tracksCounts"])||([key isEqualToString:@"tracks"])) {
        self.tracks = value;
    }
}

@end
