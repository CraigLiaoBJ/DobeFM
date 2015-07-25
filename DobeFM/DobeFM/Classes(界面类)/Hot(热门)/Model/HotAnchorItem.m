//
//  HotAnchorItem.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAnchorItem.h"

@implementation HotAnchorItem

- (void)dealloc{
    [_largeLogo release];
    [_nickname release];
    [_uid release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
