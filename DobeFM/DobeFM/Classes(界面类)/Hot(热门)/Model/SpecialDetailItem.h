//
//  SpecialDetailItem.h
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialDetailItem : NSObject
//专题内容简介
@property (nonatomic, copy) NSString *contentType;
//封面图片
@property (nonatomic, copy) NSString *coverPathBig;//专题封面图片
@property (nonatomic, copy) NSString *title;//专题名字
@property (nonatomic, copy) NSString *intro;//内容介绍
@property (nonatomic, copy) NSString *nickname;//专题作者
@property (nonatomic, copy) NSString *smallLogo;//专题作者图片
@property (nonatomic, copy) NSString *personalSignature;//专辑签名

@end
