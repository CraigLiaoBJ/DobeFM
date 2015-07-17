//
//  SpecialDetailItem.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialDetailItem : NSObject
//专题内容简介
@property (nonatomic, retain) NSString *introString;
@property (nonatomic, retain) NSString *nickNameString;
@property (nonatomic, retain) NSString *iconString;

//表视图上面音频信息
@property (nonatomic, retain) NSString *coverSmallString;
@property (nonatomic, retain) NSString *audioTitle;
@property (nonatomic, retain) NSString *authorString;
@property (nonatomic, assign) NSNumber *playCount;
@property (nonatomic, assign) NSNumber *createdAt;
@property (nonatomic, assign) NSNumber *duration;

- (id)initWithIntroString:(NSString *)introString
           nickNameString:(NSString *)nickNameString
               iconString:(NSString *)iconString;
+ (id)specialDetailIntroString:(NSString *)introString
                nickNameString:(NSString *)nickNameString
                    iconString:(NSString *)iconString;

- (id)initWithCoverSmallString:(NSString *)coverSmallString
                   audioString:(NSString *)audioString
                  authorString:(NSString *)authorString
               playCount:(NSNumber *)playCount
                 creatAt:(NSNumber *)creatAt
                duration:(NSNumber *)duration;

+ (id)specialAudioCoverSmallString:(NSString *)coverSmallString
                       audioString:(NSString *)audioString
                      authorString:(NSString *)authorString
                         playCount:(NSNumber *)playCount
                           creatAt:(NSNumber *)creatAt
                          duration:(NSNumber *)duration;

@end
