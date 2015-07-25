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
@property (nonatomic, copy) NSString *title;//音频名
@property (nonatomic, copy) NSString *smallLogo;


//@property (nonatomic, copy) NSString *albumCoverUrl290;//专辑图片
@property (nonatomic, copy) NSString *albumIntro;//专辑信息
@property (nonatomic, retain) NSNumber *lastUptrackAt;//最后更新
@property (nonatomic, retain) NSNumber *createdAt;
@property (nonatomic, retain) NSNumber *durationTm;
@property (nonatomic, retain) NSNumber *playsCounts;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, retain) NSNumber *tracks;
@property (nonatomic, copy) NSString *nickname;

@end
