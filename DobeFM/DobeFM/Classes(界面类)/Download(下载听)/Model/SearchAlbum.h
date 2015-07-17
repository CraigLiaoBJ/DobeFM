//
//  searchAlbum.h
//  Xmly
//
//  Created by lanou3g on 15/6/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchAlbum : NSObject
@property(nonatomic,strong)NSString *albumId;//专辑ID
@property(nonatomic,strong)NSString *avataPath;//图片路径
@property(nonatomic,strong)NSString *coverLarge;//大图
@property(nonatomic,strong)NSString *coverOrige;//中图
@property(nonatomic,strong)NSString *coverSmall;//小图
@property(nonatomic,strong)NSString *categoryId;//类型ID
@property(nonatomic,strong)NSString *categoryName;//类型名
@property(nonatomic,assign)int categoryAt;//创建时间

-(id)initWithSearchAlbum:(NSString*)albumId avataPath:(NSString*)avataPath coverLarge:(NSString*)coverLarge
                coverOrige:(NSString*)coverOrige coverSmall:(NSString*)coverSmall categoryId:(NSString*)categoryId categoryName:(NSString*)categoryName categoryAt:(int)categoryAt;




@end
