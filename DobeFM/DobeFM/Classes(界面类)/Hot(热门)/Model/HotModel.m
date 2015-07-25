//
//  HotModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

- (void)dealloc{
    [_clickID release];
    [_pic release];
    [_albumId release];
    [_uid release];
    [_specialId release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.clickID = value;
    }
    if ([key isEqualToString:@"type"]) {
        self.typeId = [value intValue];
    }
 }

@end
