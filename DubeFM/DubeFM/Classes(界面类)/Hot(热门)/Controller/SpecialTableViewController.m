//
//  SpecialTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialTableViewController.h"
#import "SpecialCell.h"
#import "SpcDetailViewController.h"
#import "SpecialItem.h"
#define URLSTR @"http://mobile.ximalaya.com/m/subject_list?device=iPhone"

@interface SpecialTableViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray *dataArray;

@end

static  NSInteger n = 1;
@implementation SpecialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.title = @"专题";
    self.view.backgroundColor = CELLCOLOR;

    //加载tableview
    [self addTableView];
    //加载数据
    [self loadData];
    //数据刷新和加载
    [self refreshData];
}

#pragma mark --- addTableView
- (void)addTableView{
    self.tableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 170;
    self.tableView.backgroundColor = CELLCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark --- loadData
- (void)loadData{
        NSString *string = [URLSTR stringByAppendingFormat:@"&page=%ld&per_page=10", (long)n];
        __block typeof (self) aSelf = self;
        [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
            NSDictionary *dic = (NSDictionary *)object;
            NSArray *listArray = [dic valueForKey:@"list"];
            
            for (NSDictionary *tempDic in listArray) {
                SpecialItem *specialItem = [[SpecialItem alloc]init];
                [specialItem setValuesForKeysWithDictionary:tempDic];
                [aSelf.dataArray addObject: specialItem];
            }
            [self.tableView reloadData];
    }];
}


#pragma mark --- 刷新数据
- (void)refreshData{
    __block SpecialTableViewController *blockSelf = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (n == 1) {
                n = 1;
            } else {
                n --;
            }
            [blockSelf loadData];
            [blockSelf.tableView reloadData];
            [blockSelf.tableView.header endRefreshing];
        });
    }];
    blockSelf.tableView.header.autoChangeAlpha = YES;
    
    blockSelf.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            n ++;
            [blockSelf loadData];
            [blockSelf.tableView reloadData];
            [blockSelf.tableView.footer endRefreshing];
        });
    }];
    blockSelf.tableView.footer.autoChangeAlpha = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

//重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    //赋值
    cell.spcItem = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        SpcDetailViewController *spcDetail = [[SpcDetailViewController alloc]init];
        spcDetail.addID = [[self.dataArray[indexPath.row] specialId]stringValue];
        spcDetail.spcTypeID = [[self.dataArray[indexPath.row] ctntType] stringValue];
        [self.navigationController pushViewController:spcDetail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
