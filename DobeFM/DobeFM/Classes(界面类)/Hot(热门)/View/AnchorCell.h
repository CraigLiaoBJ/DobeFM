//
//  HotAnchorTableViewCell.h
//  iTing
//
//  Created by Craig Liao on 15/7/14.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol buttonForPushVC <NSObject>

- (void)doClickButton:(UIButton *)btn;

@end
@interface AnchorCell : UITableViewCell

@property (nonatomic, assign) id<buttonForPushVC> delegate;

@end
