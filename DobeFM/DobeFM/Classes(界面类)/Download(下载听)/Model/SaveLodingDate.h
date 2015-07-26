//
//  SaveLodingDate.h
//  DobeFM
//
//  Created by DobeFM on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveLodingDate : NSObject
@property(nonatomic, strong) NSString *traintId;
//文件数据
@property(nonatomic, strong) NSMutableData *fileData;
//文件句柄
@property(nonatomic, strong) NSFileHandle *writeHandle;
//当前获取到的数据长度
@property(nonatomic, assign) long long currentLength;
//完整数据长度
@property(nonatomic, assign) long long sumLength;
//是否正在下载
@property(nonatomic, assign,getter = isdownLoading)BOOL downLoading;
//请求对象
@property(nonatomic, strong) NSURLConnection *cnnt;

@property (strong, nonatomic) UIButton *btn;

@property (copy, nonatomic) NSString *stringUrl;

@property (strong, nonatomic) UIProgressView *progress;
@end
