//
//  HotAcrListModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAcrListModel.h"

@implementation HotAcrListModel

- (void)dealloc{
    [_nickname release];
    [_smallLogo release];
    [_uid release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
