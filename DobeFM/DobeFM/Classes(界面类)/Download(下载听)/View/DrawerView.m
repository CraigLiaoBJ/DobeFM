//
//  DrawerView.m
//  Xmly
//
//  Created by DobeFM on 15/7/3.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "DrawerView.h"
@implementation DrawerView

//初始化tableView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
        [self addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc]init];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    }
    return self;

}

- (void)setDic:(NSMutableDictionary *)dic{
    if (_dic != dic) {
        _dic = dic;
    }
    [self.tableView reloadData];
}

- (void)reloadData{
    [self.tableView reloadData];
}

//代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dic.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dic[[self.dic allKeys][indexPath.row]][3]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:10];
    cell.textLabel.numberOfLines = 0;
    
    NSURL *picurl = [NSURL URLWithString:self.dic[[self.dic allKeys][indexPath.row]][1]];
    [cell.imageView sd_setImageWithURL:picurl];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(DrawerTableView:)]) {
        [self.delegate DrawerTableView:self.dic[[self.dic allKeys][indexPath.row]]];
    }
}

@end
