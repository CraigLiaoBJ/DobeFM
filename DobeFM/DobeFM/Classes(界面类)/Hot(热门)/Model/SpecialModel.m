//
//  SpecialModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SpecialModel.h"

@implementation SpecialModel

- (void)dealloc{
    [_coverPathSmall release];
    [_title release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
