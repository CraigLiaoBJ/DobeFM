//
//  SingleModel.m
//  Xmly
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SingleModel.h"




static SingleModel *manger = nil;
@implementation SingleModel

- (id)init{
    if(self = [super init ]){
        
        self.playC = [[AvPlayViewController alloc]init];
        
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


@end
