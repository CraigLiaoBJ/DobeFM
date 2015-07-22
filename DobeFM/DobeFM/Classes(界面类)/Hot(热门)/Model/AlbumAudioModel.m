//
//  AlbumModel.m
//  DobeFM
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AlbumAudioModel.h"

@implementation AlbumAudioModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTm = value;
    }
}

@end
