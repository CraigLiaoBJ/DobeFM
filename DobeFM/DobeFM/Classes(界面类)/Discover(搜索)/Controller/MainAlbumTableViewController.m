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

- (void)dealloc{
    [_searchAlbum release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.hidesBottomBarWhenPushed = YES;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self loadData];
    [self refreshAndLoad];
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark --- 加载数据
- (void)loadData{
    self.moreAlbumArray = [NSMutableArray array];
    NSString *string = [URLStr stringByAppendingFormat:@"%@&condition=hot&device=iPhone&page=%ld&per_page=20&status=0&tag_name=", self.name, n];
    NSLog(@"%@", string);
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            aSelf.searchAlbum = [[SearchAlbum alloc]init];
            [aSelf.searchAlbum setValuesForKeysWithDictionary:tempDic];
            [aSelf.moreAlbumArray addObject:aSelf.searchAlbum];
            [_searchAlbum release];
        }
        [aSelf.tableView reloadData];
    }];
}

#pragma mark --- refresh and load
- (void)refreshAndLoad{
    __block MainAlbumTableViewController *weakSelf = self;
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeFooterDefault refreshingBlock:^{
        n ++;
        [weakSelf loadData];
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.defaultFooter endRefreshing];
    }];
    
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeHeaderGif refreshingBlock:^{
        if (n == 1) {
            n = 1;
        } else {
            n --;
        }
        [weakSelf.moreAlbumArray removeAllObjects];
        [weakSelf loadData];
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.gifHeader endRefreshing];
    }];
    [self.tableView.gifHeader setGifName:@"demo.gif"];
    
    self.tableView.defaultHeader.refreshLayoutType = LORefreshLayoutTypeTopIndicator;
    self.tableView.defaultFooter.refreshLayoutType = LORefreshLayoutTypeRightIndicator;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

@end
