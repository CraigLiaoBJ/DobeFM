//
//  HotVoiceModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotVoiceModel.h"

@implementation HotVoiceModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTM = value;
    }
}
@end
