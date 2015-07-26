//
//  searchAlbum.m
//  Xmly
//
//  Created by DobeFM on 15/6/29.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SearchAlbum.h"

@implementation SearchAlbum

- (void)dealloc{
    [_albumId release];
    [_avataPath release];
    [_coverLarge release];
    [_coverOrige release];
    [_coverSmall release];
    [_categoryId release];
    [_categoryName release];
    [_title release];
    [_smallLogo release];
    [_albumIntro release];
    [_lastUptrackAt release];
    [_createdAt release];
    [_durationTm release];
    [_playsCounts release];
    [_intro release];
    [_tracks release];
    [_nickname release];
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTm = value;
    }
    if ([key isEqualToString:@"albumCoverUrl290"] ||[key isEqualToString:@"coverMiddle"] ) {
        self.coverOrige = value;
    }
//    if ([key isEqualToString:@"id"]) {
//        self.albumId = value;
//    }
}

@end
