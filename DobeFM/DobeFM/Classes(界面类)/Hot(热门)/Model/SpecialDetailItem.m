//
//  SpecialDetailItem.m
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialDetailItem.h"

@implementation SpecialDetailItem

- (id)initWithIntroString:(NSString *)introString nickNameString:(NSString *)nickNameString iconString:(NSString *)iconString{
    if (self = [super init]) {
        self.introString = introString;
        self.nickNameString = nickNameString;
        self.iconString = iconString;
    }
    return self;
}

+ (id)specialDetailIntroString:(NSString *)introString nickNameString:(NSString *)nickNameString iconString:(NSString *)iconString{
    SpecialDetailItem *detail = [[[SpecialDetailItem alloc]initWithIntroString:introString nickNameString:nickNameString iconString:iconString]autorelease];
    return detail;
}

- (id)initWithCoverSmallString:(NSString *)coverSmallString audioString:(NSString *)audioString authorString:(NSString *)authorString playCount:(NSNumber *)playCount creatAt:(NSNumber *)creatAt duration:(NSNumber *)duration{
    if (self = [super init]) {
        self.coverSmallString = coverSmallString;
        self.audioTitle = audioString;
        self.authorString = authorString;
        self.playCount = playCount;
        self.createdAt = creatAt;
        self.duration = duration;
    }
    return self;
}

+ (id)specialAudioCoverSmallString:(NSString *)coverSmallString audioString:(NSString *)audioString authorString:(NSString *)authorString playCount:(NSNumber *)playCount creatAt:(NSNumber *)creatAt duration:(NSNumber *)duration{
    SpecialDetailItem *audioItem = [[[SpecialDetailItem alloc]initWithCoverSmallString:coverSmallString audioString:authorString authorString:authorString playCount:playCount creatAt:creatAt duration:duration]autorelease];
    return audioItem;
}
@end
