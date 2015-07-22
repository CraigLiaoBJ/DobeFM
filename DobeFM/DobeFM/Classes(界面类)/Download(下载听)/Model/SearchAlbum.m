//
//  searchAlbum.m
//  Xmly
//
//  Created by lanou3g on 15/6/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SearchAlbum.h"

@implementation SearchAlbum


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"duration"]) {
        self.durationTm = value;
    }
    if ([key isEqualToString:@"albumCoverUrl290"]) {
        self.coverOrige = value;
    }
}


//-(id)initWithSearchAlbum:(NSString*)albumId avataPath:(NSString*)avataPath coverLarge:(NSString*)coverLarge
//                coverOrige:(NSString*)coverOrige coverSmall:(NSString*)coverSmall categoryId:(NSString*)categoryId categoryName:(NSString*)categoryName categoryAt:(int)categoryAt{
//    if (self = [super init]) {
//        self.albumId = albumId;
//        self.avataPath = avataPath;
//        self.coverLarge = coverLarge;
//        self.coverOrige = coverOrige;
//        self.coverSmall = coverSmall;
//        self.categoryId = categoryId;
//        self.categoryName = categoryName;
//        self.categoryAt = categoryAt;
//    }
//    return self;
//
//}
@end
