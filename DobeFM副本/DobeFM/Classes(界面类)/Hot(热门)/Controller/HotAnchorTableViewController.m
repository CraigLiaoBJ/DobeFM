//
//  HotAnchorTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "HotAnchorTableViewController.h"
#import "AnchorCell.h"
#import "MoreViewController.h"
#import "AnchorInfoTableViewController.h"
@interface HotAnchorTableViewController ()<UITableViewDataSource, UITableViewDelegate, buttonForPushVC>

@end

@implementation HotAnchorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 160;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[AnchorCell class] forCellReuseIdentifier:@"CELL"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnchorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *myHeader = [[UIView alloc]init];
    myHeader.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
    label.text = @"最热~~";
    label.font = [UIFont boldSystemFontOfSize:16];
    [myHeader addSubview:label];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(self.view.frame.size.width - 75, 0, 75, 30);
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, 50, 30)];
    titleLabel.text = @"更多";
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [moreBtn addSubview:titleLabel];

    [moreBtn setImage:[UIImage imageNamed:@"iconfont-gengduo-3.png"] forState:UIControlStateNormal];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    
    [moreBtn addTarget:self action:@selector(didClickmoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [myHeader addSubview:moreBtn];
    
    UILabel *sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, 1)];
    sepLabel.backgroundColor = [UIColor colorWithWhite:0.736 alpha:1.000];
    [myHeader addSubview:sepLabel];
    return myHeader;
}

- (void)doClickButton:(UIButton *)btn
{
    AnchorInfoTableViewController *an = [[AnchorInfoTableViewController alloc] initWithStyle:(UITableViewStylePlain)];
    an.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:an animated:YES];
}

- (void)didClickmoreBtn{
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *myFooter = [[UIView alloc]init];
    myFooter.backgroundColor = [UIColor whiteColor];
    return myFooter;
}

@end
