//
//  MainAlbumTableViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/24.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "MainAlbumTableViewController.h"
#import "AlbumCell.h"
#import "AlbumDetailViewController.h"
#define URLStr @"http://mobile.ximalaya.com/m/explore_album_list?category_name="

@interface MainAlbumTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *moreAlbumArray;
@property (nonatomic, retain) SearchAlbum *searchAlbum;

@end

static NSInteger n = 0;
@implementation MainAlbumTableViewController

//- (void)dealloc{
//    [_name release];
//    [_tagName release];
//    [_searchAlbum release];
//    [super dealloc];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moreAlbumArray = [NSMutableArray array];
    self.view.backgroundColor = CELLCOLOR;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];

//    self.hidesBottomBarWhenPushed = YES;
    self.title = [NSString stringWithFormat:@"%@", self.tagName];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self loadData];
    [self refreshData];
    //注册cell
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark --- 加载数据
- (void)loadData{
    NSString *string = [URLStr stringByAppendingFormat:@"%@&condition=hot&device=iPhone&page=%ld&per_page=20&status=0&tag_name=%@", self.name, n, self.tagName];
    //把tagName的汉字转化成为UTF8字符
    NSString *str =  [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:str method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            aSelf.searchAlbum = [[SearchAlbum alloc]init];
            [aSelf.searchAlbum setValuesForKeysWithDictionary:tempDic];
            [aSelf.moreAlbumArray addObject:aSelf.searchAlbum];
//            [_searchAlbum release];
        }
        [aSelf.tableView reloadData];
    }];
}

#pragma mark --- 刷新数据
- (void)refreshData{
    __block MainAlbumTableViewController *blockSelf = self;
    
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
    self.tableView.header.autoChangeAlpha = YES;
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            n ++;
            [blockSelf loadData];
            [blockSelf.tableView reloadData];
            [blockSelf.tableView.footer endRefreshing];
        });
    }];
    self.tableView.footer.autoChangeAlpha = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moreAlbumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.searchAlbum = self.moreAlbumArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = CELLCOLOR;
}

//跳转到专辑详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailViewController *albumVC = [[AlbumDetailViewController alloc]init];
    albumVC.albumId = [self.moreAlbumArray[indexPath.row]albumId];
    NSLog(@"%@",albumVC.albumId);
    albumVC.sAlbum = self.moreAlbumArray[indexPath.row];
    [self.navigationController pushViewController:albumVC animated:YES];
//    [albumVC release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
