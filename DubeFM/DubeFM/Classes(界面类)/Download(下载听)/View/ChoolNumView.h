//
//  ChoolNumView.h
//  Xmly
//
//  Created by DobeFM on 15/7/10.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//
#import "MDownButton.h"
#import <UIKit/UIKit.h>

@protocol ChoolNumDelegate<NSObject>
@optional

- (void)labelClick:(MDownButton*)sender;

@end

@interface ChoolNumView : UIView

@property (nonatomic, assign) int num;

@property (nonatomic, retain) id<ChoolNumDelegate>delegate;

@end
