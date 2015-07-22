//
//  MoreAlbumTableViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "MoreAlbumTableViewController.h"
#import "MoreAlbumCell.h"
#import "AlbumDetailViewController.h"
#define URLStr @"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=hot&device=iPhone&page="
#import "MoreAlbumsModel.h"
@interface MoreAlbumTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *moreAlbumArray;

@end

static NSInteger n = 0;
@implementation MoreAlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self loadData];
    [self refreshAndLoad];
    [self.tableView registerClass:[MoreAlbumCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark --- 加载数据
- (void)loadData{
    self.moreAlbumArray = [NSMutableArray array];
    NSString *string = [URLStr stringByAppendingFormat:@"%ld&per_page=0&status=0&tag_name=", n];
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            MoreAlbumsModel *moreAlbumsModel = [[MoreAlbumsModel alloc]init];
            [moreAlbumsModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.moreAlbumArray addObject:moreAlbumsModel];
            NSLog(@"%@deee", moreAlbumsModel.nickname);
        }
        [aSelf.tableView reloadData];
    }];
}

#pragma mark --- refresh and load
- (void)refreshAndLoad{
    __block MoreAlbumTableViewController *weakSelf = self;
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeFooterDefault refreshingBlock:^{
        n ++;
        [weakSelf loadData];
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.defaultFooter endRefreshing];
    }];
    
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeHeaderGif refreshingBlock:^{
        NSLog(@"asd");
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"shuzu wei %ld", self.moreAlbumArray.count);
    return self.moreAlbumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.moreAlbumsModel = self.moreAlbumArray [indexPath.row];
    NSLog(@"cell === %@", cell.moreAlbumsModel.nickname);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = CELLCOLOR;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailViewController *albumVC = [[AlbumDetailViewController alloc]init];
    albumVC.albumId = [self.moreAlbumArray[indexPath.row]albumId];
    [self.navigationController pushViewController:albumVC animated:YES];
}

@end
