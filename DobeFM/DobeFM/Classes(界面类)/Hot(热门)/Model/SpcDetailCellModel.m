//
//  SpcDetailCellModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SpcDetailCellModel.h"

@implementation SpcDetailCellModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTm = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.thisID = value;
    }
    if ([key isEqualToString:@"nickname"]) {
        self.authorName = value;
    }
    if ([key isEqualToString:@"intro"]) {
        self.albumIntro = value;
    }
}

@end
