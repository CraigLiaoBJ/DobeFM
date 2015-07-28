//
//  SingleModel.m
//  Xmly
//
//  Created by DobeFM on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SingleModel.h"




static SingleModel *manger = nil;
@implementation SingleModel

- (id)init{
    if(self = [super init ]){
        
        self.playC = [[AvPlayViewController alloc]init];
        self.loadingC = [[LoadingViewController alloc]init];
        //self.tabBar = [[TabBarViewController alloc]init];
    }

    return self;
}

+(SingleModel*)shareSingleModel{
    @synchronized(self){
       
        if(manger == nil)
        {
               manger = [[SingleModel alloc]init];
        }
        return  manger;
    }
    
}

//-(void)loadContinu{
//    if(manger == nil){
//        [SingleModel shareSingleModel];
//    }
//    [_loadingC continuDown];
//
//}

@end
