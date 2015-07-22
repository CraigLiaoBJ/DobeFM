//
//  SpcAudioDetailModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/20.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SpcAudioDetailModel.h"

@implementation SpcAudioDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTm = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.thisID = value;
    }
}

@end
