//
//  HotModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.clickID = value;
    }
}

@end
