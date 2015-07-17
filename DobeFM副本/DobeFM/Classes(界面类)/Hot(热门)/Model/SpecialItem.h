//
//  SpecialItem.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialItem : NSObject

@property (nonatomic, retain) NSString *contentType;
@property (nonatomic, retain) NSString *coverPathBig;
@property (nonatomic, assign) NSNumber *releasedAt;
@property (nonatomic, assign) NSNumber *specialId;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) BOOL isHot;

//- (id)initWithCoverBig:(NSString *)coverBig
//               releaseAt:(NSNumber *)releaseAt
//                spcialID:(NSNumber *)spcialID
//                subTitle:(NSString *)subTitle
//             titleString:(NSString *)titleString
//                   hot:(BOOL)hot;
//
//+ (id)specialCoverBig:(NSString *)coverBig
//            releaseAt:(NSNumber *)releaseAt
//             spcialID:(NSNumber *)spcialID
//             subTitle:(NSString *)subTitle
//          titleString:(NSString *)titleString
//                  hot:(BOOL)hot;

@end
