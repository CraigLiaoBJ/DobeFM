//
//  Networking.h
//  异步加载图片
//
//  Created by Craig Liao on 15/6/16.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Block)(id object);
@interface Networking : NSObject

//声明数据请求方法.将post和get请求写进一个方法里面，判断method（请求类型）
+ (void)recivedDataWithURLString:(NSString *)urlString method:(NSString *)method body:(NSString *)body block:(Block)block;
@end
