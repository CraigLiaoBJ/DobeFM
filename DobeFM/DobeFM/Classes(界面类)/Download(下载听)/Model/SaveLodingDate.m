//
//  SaveLodingDate.m
//  DobeFM
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SaveLodingDate.h"

@implementation SaveLodingDate
-(instancetype)init{
    if (self = [super init]) {
        _fileData = [[NSMutableData alloc]init];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        [self.btn setTitle:@"开始" forState:UIControlStateNormal];
        self.btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        
        [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.progress = [[UIProgressView alloc]init];
        
        self.writeHandle = [[NSFileHandle alloc]init];
        
        self.cnnt = [[NSURLConnection alloc]init];
        
    
        //self.progress.frame = CGRectMake((self.bounds.size.width - 240)/2 + 40, self.bounds.size.height - 10, 240, 10);

    }
    return self;
}
@end
