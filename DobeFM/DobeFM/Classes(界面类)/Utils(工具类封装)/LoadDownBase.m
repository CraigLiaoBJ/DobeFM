//
//  LoadDownBase.m
//  Xmly
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoadDownBase.h"

@implementation LoadDownBase
//获取plist的歌曲列表 p
-(NSMutableDictionary*)getLoadDownPlish:(NSString*)plistName plistPath:(NSString*) plistPath{
    // NSString *plish = [[NSBundle mainBundle]pathForResource:plistName ofType:@"plist"];
    NSString *plish = [NSString stringWithFormat:@"%@/%@%@",plistPath,plistName,@".plist"];
    NSMutableDictionary *date = [[NSMutableDictionary alloc]initWithContentsOfFile:plish];
    if (nil == date) {//是否存在plish
        NSDictionary *dic = [[NSDictionary alloc]init];
        [dic writeToFile:plish atomically:YES];
    }
    return date;
}
//保存的数据 sender 歌曲ID plistName plist文件路径
-(void)setLoadData:(NSString *)sender plsitName:(NSString*) plistName albumName:(AlbumList *) album{
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPathFirst = [paths objectAtIndex:0];
    
    NSMutableDictionary *dataList =  [self getLoadDownPlish:plistName plistPath:plistPathFirst];
    //-------h获取专辑信息- 将地址转化成数据----
    NSMutableArray* obj = [[NSMutableArray alloc]init];
    
    [obj addObject:[album albumId] == nil ? @"": [album albumId]];
    [obj addObject:[album albumImage] == nil ? @"": [album albumImage]] ;
    [obj addObject:[album albumTitle] == nil ? @"": [album albumTitle]] ;
    [obj addObject:[album title1] == nil ? @"": [album title1]] ;
    [obj addObject:[album playPathAacv164] == nil ? @"": [album playPathAacv164]] ;
    [obj addObject:[album trackId] == nil ? @"":[album trackId]] ;
    [obj addObject:[album durationTime] == nil ? @"":[album durationTime]] ;
    [obj addObject:[album downloadAacUrl] == nil ? @"":[album downloadAacUrl]] ;
    [obj addObject:[album downloadAacSize] == nil ? @"":[album downloadAacSize]] ;
    [obj addObject:[album downloadUrl] == nil ? @"": [album downloadUrl]] ;
    [obj addObject:[album downloadSize] == nil ? @"": [album downloadSize]] ;
    [obj addObject:[album playUrl32] == nil ? @"": [album playUrl32]] ;
    
    [dataList setObject:obj forKey:[NSString stringWithFormat:@"%@", sender]];
    
    //得到完整的文件名
    
    NSString *filename=[NSString stringWithFormat:@"%@/%@%@",plistPathFirst,plistName,@".plist"];
    bool  suc = [dataList writeToFile:filename atomically:YES];
    //    if (suc) {
    //            NSLog(@"success");
    //    }
    //    else{
    //            NSLog(@"fail");
    //
    //    }
    
    //那怎么证明我的数据写入了呢？读出来看看
    //    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    //    NSLog(@"data1%@", data1);
}


//获取播放历史
-(NSMutableDictionary*)getListerHistoryList{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    return [self getLoadDownPlish:@"ListerHistory" plistPath:plistPath1];
    
}


//获下载
-(AlbumList*)getLoadingList{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSMutableDictionary *a = [self getLoadDownPlish:@"BeLoadList" plistPath:plistPath1];
    NSArray *arr = [a valueForKey:[NSString stringWithFormat:@"%@",[a.allKeys firstObject]]];
    return [self arrayToAlbumList:arr];
    
}
//获下载列表 是否为空
- (bool) isLoadingList{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSMutableDictionary *a = [self getLoadDownPlish:@"BeLoadList" plistPath:plistPath1];
    if(a.count <= 0)
        return NO;
    return YES;
}

//保存数据到沙盒  urlStr 下载路径  stype 下载格式  如。MP3 。png
-(void)loadAudioToLocation:(NSString *)urlStr styp:(NSString*)stype albumName:(AlbumList *) album{
    //解析下载地址
    NSString *urlString = @"";
    NSString *type = @"";
    if ([stype isEqualToString:@".jpg"]) {
        urlString = urlStr;
        type = stype;
    }
    else{
        
        if ([album downloadAacUrl] != nil && [[album downloadAacUrl] isEqualToString:@""]) {
            urlString = [album downloadAacUrl];
        }
        else {
            urlString = [album downloadUrl];
        }
        type = [@"."stringByAppendingString:[[urlString componentsSeparatedByString:@"."] lastObject]];
    }
    
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = filePath.firstObject;
    NSString *musicPath = [[documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[album trackId]]]stringByAppendingString:type];
    //下载

    NSURL *musicUrl=[NSURL URLWithString:urlString];
    NSData *mp3Data = [NSData dataWithContentsOfURL:musicUrl];
    [mp3Data writeToFile:musicPath atomically:YES];

    
}


//移除字典的对象
-(void)removeObjOfPlist:(NSString*) stractId splistName:(NSString*)plistName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPathFirst = [paths objectAtIndex:0];
    
    NSMutableDictionary *dataList =  [self getLoadDownPlish:plistName plistPath:plistPathFirst];
    [dataList removeObjectForKey:[NSString stringWithFormat:@"%@", stractId ]];
    NSString *filename=[NSString stringWithFormat:@"%@/%@%@",plistPathFirst,plistName,@".plist"];
    [dataList writeToFile:filename atomically:YES];
    
}



-(AlbumList*)arrayToAlbumList:(NSArray*)arr{
    
    AlbumList *alist = [[AlbumList alloc]init];
    alist.albumId = [NSString stringWithFormat:@"%@",arr[0]];
    alist.albumImage = [NSString stringWithFormat:@"%@",arr[1]];
    alist.albumTitle = [NSString stringWithFormat:@"%@",arr[2]];
    alist.title1 = [NSString stringWithFormat:@"%@",arr[3]];
    alist.playPathAacv164 = [NSString stringWithFormat:@"%@",arr[4]];
    alist.trackId = [NSString stringWithFormat:@"%@",arr[5]];
    alist.durationTime = [NSString stringWithFormat:@"%@",arr[6]];
    alist.downloadAacUrl = [NSString stringWithFormat:@"%@",arr[7]];
    alist.downloadAacSize = [NSString stringWithFormat:@"%@",arr[8]];
    alist.downloadUrl = [NSString stringWithFormat:@"%@",arr[9]];
    alist.downloadSize = [NSString stringWithFormat:@"%@",arr[10]];
    alist.playUrl32 = [NSString stringWithFormat:@"%@",arr[11]];
    return alist;
}

@end
