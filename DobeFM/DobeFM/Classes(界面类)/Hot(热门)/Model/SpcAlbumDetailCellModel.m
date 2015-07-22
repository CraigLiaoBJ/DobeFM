//
//  SpcDetailCellModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SpcAlbumDetailCellModel.h"

@implementation SpcAlbumDetailCellModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.albumID = value;
    }

}

@end
