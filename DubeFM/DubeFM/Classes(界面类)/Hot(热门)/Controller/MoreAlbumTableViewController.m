//
//  MoreAlbumTableViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "MoreAlbumTableViewController.h"
#import "AlbumCell.h"
#import "AlbumDetailViewController.h"
#define URLStr @"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=hot&device=iPhone&page="
#import "SearchAlbum.h"
@interface MoreAlbumTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *moreAlbumArray;
@property (nonatomic, retain) SearchAlbum *searchAlbum;

@end

static NSInteger n = 0;
@implementation MoreAlbumTableViewController

- (void)dealloc{
    [_searchAlbum release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐专辑";
    self.moreAlbumArray = [NSMutableArray array];
    self.view.backgroundColor = CELLCOLOR;

//    self.hidesBottomBarWhenPushed = YES;

    self.tableView = [[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain]autorelease];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self loadData];
    [self refreshData];
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark --- 加载数据
- (void)loadData{
    NSString *string = [URLStr stringByAppendingFormat:@"%ld&per_page=0&status=0&tag_name=", n];
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
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
    __block MoreAlbumTableViewController *blockSelf = self;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailViewController *albumVC = [[AlbumDetailViewController alloc]init];
    albumVC.albumId = [self.moreAlbumArray[indexPath.row]albumId];
    albumVC.sAlbum = self.moreAlbumArray[indexPath.row];
    [self.navigationController pushViewController:albumVC animated:YES];
    [albumVC release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
