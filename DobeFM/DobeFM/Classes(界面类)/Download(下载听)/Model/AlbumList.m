//
//  AlbumList.m
//  Xmly
//
//  Created by lanou3g on 15/6/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AlbumList.h"

@implementation AlbumList
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTime = value;
    }
    if ([key isEqualToString:@"title"]) {
        self.title1 = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.trackId = value;
    }
    if ([key isEqualToString:@"coverSmall"]) {
        self.albumImage = value;
    }
    if ([key isEqualToString:@"playPath32"]) {
        self.playUrl32 = value;
        self.downloadUrl = value;
    }
    if ([key isEqualToString:@"playPath64"]) {
        self.playPathAacv164 = value;
        self.downloadUrl = value;
    }


}


@end
