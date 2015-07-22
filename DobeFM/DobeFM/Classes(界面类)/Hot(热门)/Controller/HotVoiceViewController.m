//
//  HotVoiceTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "HotVoiceViewController.h"
#import "HotVoiceCell.h"
#import "AlbumList.h"
#import "ReconmmendAlbumViewController.h"

#define URLSTR @"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=daily&device=iPhone&page="

@interface HotVoiceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;

@end

static NSInteger n = 1;

@implementation HotVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门声音";
    self.arr = [NSMutableArray array];
    [self loadData];
    [self addTableView];
}
#pragma mark --- 添加TableView
- (void)addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    [self refreshAndLoad];
    
    [self.tableView registerClass:[HotVoiceCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark --- 加载网络数据
- (void)loadData{
    NSString *string = [URLSTR stringByAppendingFormat:@"%ld&per_page=15&tag_name=", n ++];
    NSLog(@"%@", string);
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            AlbumList *voiceModel = [[AlbumList alloc]init];
            [voiceModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.arr addObject:voiceModel];
            NSLog(@"%ld", aSelf.arr.count);
        }
        [aSelf.tableView reloadData];
    }];
}

#pragma mark --- 刷新
- (void)refreshAndLoad{
    __block HotVoiceViewController *weakSelf = self;
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeFooterDefault refreshingBlock:^{
        [weakSelf loadData];
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.defaultFooter endRefreshing];
    }];
    
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeHeaderGif refreshingBlock:^{
        [weakSelf.arr removeAllObjects];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.gifHeader endRefreshing];
    }];
    [self.tableView.gifHeader setGifName:@"demo.gif"];
    
    self.tableView.defaultHeader.refreshLayoutType = LORefreshLayoutTypeTopIndicator;
    self.tableView.defaultFooter.refreshLayoutType = LORefreshLayoutTypeRightIndicator;
}

#pragma mark --- 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.albumList = self.arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//点击播放
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    [[SingleModel shareSingleModel].playC initWithAvplayer:indexPath.row albumList:[NSMutableArray arrayWithArray: self.dataArray] sAlbum:self.sAlbum];
    
    UIViewController *vc = [[UIViewController alloc]init];
    [self.navigationController pushViewController:vc  animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = CELLCOLOR;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
