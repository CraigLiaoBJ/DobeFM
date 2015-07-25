//
//  ChoolNumView.m
//  Xmly
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#define WINWIDTH self.bounds.size.width
#import "ChoolNumView.h"
#import "MDownButton.h"

@implementation ChoolNumView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0,frame.size.width, 0 );
        self.backgroundColor = CELLCOLOR;
    }
    return self;

}


-(void)setNum:(int)num{
    _num = num;
    NSInteger labelNum = self.num / CHOOL_NEWLINE_NUM;
    self.frame = CGRectMake(0, 64,self.frame.size.width, 30 + labelNum/4*30 );
    for (NSInteger r = labelNum / 4 ; r >= 0 ; r --) {
//        float anum = 4*(labelNum / 4  - r) - labelNum%4 -1;
//        anum = anum < 0 ? 0 : anum;//计算结束时的
        float anum = 0;
        if (r == labelNum / 4) {
            anum = 0;
        }
        else {
            //anum = labelNum - (labelNum / 4 - r)*4 - 4;
           anum = labelNum - 4*r + 1 - 4;
        }
        
        
        for (NSInteger i = labelNum - 4*r + 1; i > anum ; i--) {
                        float startNum = r*CHOOL_NEWLINE_NUM*4 + CHOOL_NEWLINE_NUM * (labelNum - 4*r + 1 - i) +1;
                        float endNum = self.num - startNum < CHOOL_NEWLINE_NUM ? self.num  : startNum + CHOOL_NEWLINE_NUM - 1;
                        MDownButton *label = [MDownButton buttonWithType:UIButtonTypeCustom];
            label.layer.cornerRadius = 10.0f;
            label.layer.masksToBounds = YES;
                        label.backgroundColor = cellImageColor;
                        label.frame =  CGRectMake(
                            WINWIDTH - WINWIDTH*0.2*(i-anum) - (i-anum)*WINWIDTH*0.04
                            , 5 + r * 20 + 2 * r * 5,
                            WINWIDTH*0.2 ,
                            20);
                        [label setTitle:[NSString stringWithFormat:@"%.0f~%.0f",startNum,endNum] forState:UIControlStateNormal];
                        [label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        label.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                        [label addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
                        label.starNum = startNum;
                        label.endNum = endNum;
                        [self addSubview:label];
        }
    }
}

- (void)labelClick:(MDownButton*)sender{

    if (self.delegate && [self.delegate respondsToSelector:@selector(labelClick:)]) {
        [self.delegate labelClick:sender];
    }

}

@end
