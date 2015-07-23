//
//  Networking.m
//  异步加载图片
//
//  Created by lanou3g on 15/6/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Networking.h"

@implementation Networking

+ (void)recivedDataWithURLString:(NSString *)urlString method:(NSString *)method body:(NSString *)body block:(Block)block
{
//    1.转成url
    NSURL * url = [NSURL URLWithString:urlString];
//    2.准备request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
//    3.设置请求方式Method
    [request setHTTPMethod:method];
//    判断，请求方式（以Method传进来的值为判断依据）
    if ([method isEqualToString:@"POST"]) {
        NSData * data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
//    建立异步链接    ·
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
        
//        将json(文件)转化成对象
        id tempObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        使用block将此对象传回到视图控制器类里面
        block(tempObj);
            
        } else {
            
        }
        
    }];
    
}
@end
