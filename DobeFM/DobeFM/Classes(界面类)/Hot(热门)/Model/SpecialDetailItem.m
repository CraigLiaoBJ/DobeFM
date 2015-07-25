//
//  SpecialDetailItem.m
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialDetailItem.h"

@implementation SpecialDetailItem

- (void)dealloc{
    [_contentType release];
    [_coverPathBig release];
    [_title release];
    [_intro release];
    [_nickname release];
    [_smallLogo release];
    [_personalSignature release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
