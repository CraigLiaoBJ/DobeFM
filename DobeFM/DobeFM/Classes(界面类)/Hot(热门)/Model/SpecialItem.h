//
//  SpecialItem.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialItem : NSObject

@property (nonatomic, retain)NSString *coverBig;
@property (nonatomic, assign)NSNumber *releaseAt;
@property (nonatomic, assign)NSNumber *spcialID;
@property (nonatomic, retain)NSString *subTitle;
@property (nonatomic, retain)NSString *titleString;
@property (nonatomic, assign)BOOL hot;

- (id)initWithCoverBig:(NSString *)coverBig
               releaseAt:(NSNumber *)releaseAt
                spcialID:(NSNumber *)spcialID
                subTitle:(NSString *)subTitle
             titleString:(NSString *)titleString
                   hot:(BOOL)hot;

+ (id)specialCoverBig:(NSString *)coverBig
            releaseAt:(NSNumber *)releaseAt
             spcialID:(NSNumber *)spcialID
             subTitle:(NSString *)subTitle
          titleString:(NSString *)titleString
                  hot:(BOOL)hot;

@end
