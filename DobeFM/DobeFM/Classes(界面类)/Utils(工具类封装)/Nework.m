//
//  Nework.m
//  UI_Lesson_异步加载
//
//  Created by lanou3g on 15/6/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Nework.h"

@implementation Nework
+(void)recivedDataWithURLString:(NSString *)urlString method:(NSString *)method body:(NSString *)body Block:(Block)block{

//转成url
    NSURL *url=[NSURL URLWithString:urlString];
    //准备request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式method
    [request setHTTPMethod:method];
    //判断请求方式
    if ([method isEqualToString:@"POST"]) {
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id tempObj =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //用block回传
        block(tempObj);
    }];
}
@end
