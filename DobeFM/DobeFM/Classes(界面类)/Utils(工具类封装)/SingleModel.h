//
//  SingleModel.h
//  Xmly
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
#import "AvPlayViewController.h"
@interface SingleModel : NSObject
@property ( nonatomic, strong) AvPlayViewController *playC;

+(SingleModel*)shareSingleModel;
@end
