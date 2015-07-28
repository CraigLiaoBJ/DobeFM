//
//  AnchorIntroModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AnchorIntroModel.h"

@implementation AnchorIntroModel

- (void)dealloc{
    [_mobileMiddleLogo release];
    [_nickname release];
    [_personalSignature release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"uid"]) {
        self.anchorUid = value;
    }
    
}

@end
