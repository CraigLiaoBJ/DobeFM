//
//  Nework.h
//  UI_Lesson_异步加载
//
//  Created by lanou3g on 15/6/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Block) (id objeck);
@interface Nework : NSObject
//声明数据请求方法
+(void)recivedDataWithURLString:(NSString *)urlString method:(NSString *)method body:(NSString*)body Block:(Block)block;



@end
