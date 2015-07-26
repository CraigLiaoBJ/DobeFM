//
//  SingleModel.h
//  Xmly
//
//  Created by DobeFM on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
#import "AvPlayViewController.h"
#import "LoadingViewController.h"
#import "TabBarViewController.h"
@interface SingleModel : NSObject

@property ( nonatomic, retain) AvPlayViewController *playC;

@property ( nonatomic, retain) LoadingViewController *loadingC;

@property ( nonatomic, retain) TabBarViewController *tabBar;

+(SingleModel*)shareSingleModel;

//-(void)loadContinu;
@end
