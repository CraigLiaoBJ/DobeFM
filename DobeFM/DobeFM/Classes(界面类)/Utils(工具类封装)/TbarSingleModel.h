//
//  TbarSingleModel.h
//  DobeFM
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TbarSingleModel : NSObject

@property ( nonatomic, retain) TabBarViewController *tabBar;
+(TbarSingleModel*)shareSingleModel;
@end
