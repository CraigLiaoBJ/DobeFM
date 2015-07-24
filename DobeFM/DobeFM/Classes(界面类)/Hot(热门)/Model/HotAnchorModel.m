//
//  HotAnchorModel.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/19.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAnchorModel.h"
#import "HotAcrListModel.h"
@implementation HotAnchorModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.listArray = [NSMutableArray array];
        for (NSDictionary *tempDic in value) {
            HotAcrListModel *hotAcrListModel = [[HotAcrListModel alloc]init];
            [hotAcrListModel setValuesForKeysWithDictionary:tempDic];
            [self.listArray addObject:hotAcrListModel];
        }
    }
}

@end
