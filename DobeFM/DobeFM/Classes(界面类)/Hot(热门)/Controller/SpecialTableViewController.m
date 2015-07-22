//
//  SpecialTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialTableViewController.h"
#import "SpecialCell.h"
#import "SpcDetailTableViewController.h"
#import "SpecialItem.h"
#define URLSTR @"http://mobile.ximalaya.com/m/subject_list?device=iPhone"

@interface SpecialTableViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray *dataArray;

@end
static  NSInteger i = 1;
@implementation SpecialTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"专题";
    
    //加载tableview
    [self addTableView];
    //加载数据
    [self loadData];
    
    //数据刷新和加载
    [self refreshAndLoad];
   
}

#pragma mark --- addTableView
- (void)addTableView{
    self.tableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 170;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"CELL"];
    
//    [self.tableView release];
}

#pragma mark --- loadData
- (void)loadData{
 
        NSString *string = [URLSTR stringByAppendingFormat:@"&page=%ld&per_page=10", i ];
        self.dataArray = [NSMutableArray array];
        __block typeof (self) aSelf = self;
        [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
            NSDictionary *dic = (NSDictionary *)object;
            NSArray *listArray = [dic valueForKey:@"list"];
            
            for (NSDictionary *tempDic in listArray) {
                SpecialItem *specialItem = [[SpecialItem alloc]init];
                [specialItem setValuesForKeysWithDictionary:tempDic];
                [aSelf.dataArray addObject: specialItem];
//                NSLog(@"111%@" , specialItem.releasedAt);
                [specialItem release];
            }
            [self.tableView reloadData];
    }];
}

#pragma mark --- refresh and load
- (void)refreshAndLoad{
    __block SpecialTableViewController *weakSelf = self;
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeFooterDefault refreshingBlock:^{
        i ++;
        [weakSelf loadData];
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.defaultFooter endRefreshing];
    }];
    
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeHeaderGif refreshingBlock:^{
        NSLog(@"asd");
        if (i == 1) {
            i = 1;
        } else {
            i --;
        }
        [weakSelf.dataArray removeAllObjects];
        [weakSelf loadData];

        [weakSelf.tableView reloadData];
        [weakSelf.tableView.gifHeader endRefreshing];
    }];
    [self.tableView.gifHeader setGifName:@"demo.gif"];
    
    self.tableView.defaultHeader.refreshLayoutType = LORefreshLayoutTypeTopIndicator;
    self.tableView.defaultFooter.refreshLayoutType = LORefreshLayoutTypeRightIndicator;
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
   
        SpcDetailTableViewController *spcDetail = [[SpcDetailTableViewController alloc]init];
        spcDetail.addID = [[self.dataArray[indexPath.row] specialId]stringValue];
        spcDetail.spcTypeID = [[self.dataArray[indexPath.row] contentType] stringValue];
        [self.navigationController pushViewController:spcDetail animated:YES];
        [spcDetail release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
