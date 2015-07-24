//
//  TbarSingleModel.m
//  DobeFM
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "TbarSingleModel.h"
static TbarSingleModel *manger = nil;
@implementation TbarSingleModel
+(TbarSingleModel*)shareSingleModel{
    @synchronized(self){
        
        if(manger == nil)
        {
            manger = [[TbarSingleModel alloc]init];
        }
        return  manger;
    }
    
}


- (id)init{
    if(self = [super init ]){
        self.tabBar = [[TabBarViewController alloc]init];
    }
    
    return self;
}
@end
