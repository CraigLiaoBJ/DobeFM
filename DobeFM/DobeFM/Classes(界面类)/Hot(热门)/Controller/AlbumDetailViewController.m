//
//  AlbumDetailViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//
#import "AlbumDetailViewController.h"
#import "AudioCell.h"
#import "AlbumIntro.h"
#import "AlbumItem.h"
#import "AlbumList.h"
#import "MoreDownViewController.h"
#define URLSTR @"http://mobile.ximalaya.com/mobile/others/ca/album/track/"

@interface AlbumDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
//@property(nonatomic,strong)AvPlayViewController *playC;
@property (nonatomic, retain) AlbumIntro *albumView;

//@property (nonatomic, retain) NSMutableArray *albumIntroArray;
@property (nonatomic, retain) NSMutableArray *albumDataArray;

@property (nonatomic, retain) AlbumList *albumList;
@end
static NSInteger n = 1;
@implementation AlbumDetailViewController

//- (void)dealloc{
////    [_albumId release];
////    [_imageView release];
////    [_tableView release];
////    [_dataArray release];
////    [_albumView release];
////    [_albumList release];
//
//    [super dealloc];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专辑详情";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.albumDataArray = [NSMutableArray array];
    self.albumList = [[AlbumList alloc]init];
    self.view.backgroundColor = CELLCOLOR;
    [self loadData];
    [self addIntroImageView];
    [self addTableView];
    [self refreshData];
}

#pragma mark --- 介绍部分
- (void)addIntroImageView{
    self.albumView = [[AlbumIntro alloc]initWithFrame:self.view.bounds];
    [self batchButtons];
    [self.view addSubview:self.albumView];
//    [_albumView release];
}

#pragma mark --- 加载tableView
- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, kWIDTH, kHEIGHT - 65 - kWIDTH / 5 - 120) style:UITableViewStylePlain];
    self.tableView.backgroundColor = CELLCOLOR;
    
    UIVisualEffectView *bgdEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.tableView addSubview:bgdEffect];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.albumView addSubview:self.tableView];

    [self.tableView registerClass:[AudioCell class] forCellReuseIdentifier:@"CELL"];
//    [_tableView release];
}

#pragma mark --- 数据请求
- (void)loadData{
//    self.dataArray = [NSMutableArray array];
    __block typeof (self) aSelf = self;
    
    NSString *string = [URLSTR stringByAppendingFormat:@"%@/true/%ld/15", self.albumId, n];
    
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        
        AlbumItem *albumItem = [[AlbumItem alloc]init];
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *introDic = dic[@"album"];
        [albumItem setValuesForKeysWithDictionary:introDic];
        aSelf.albumView.albumItem = albumItem;
//        [albumItem release];
        
        NSDictionary *tracksDic = dic[@"tracks"];
        NSArray *listArray = tracksDic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            aSelf.albumList = [[AlbumList alloc]init];
            [aSelf.albumList setValuesForKeysWithDictionary:tempDic];
            [aSelf.albumDataArray addObject:aSelf.albumList];
//            [_albumList release];
        }
        [aSelf.tableView reloadData ];
    }];
}

#pragma mark --- 刷新数据
- (void)refreshData{
    __block AlbumDetailViewController *blockSelf = self;
    
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

#pragma mark --- 按钮
- (void)batchButtons{
    //批量下载按钮
    UIButton *batchDn = [UIButton buttonWithType:UIButtonTypeCustom];
    batchDn.frame = CGRectMake(kWIDTH / 3 * 2, 175, kWIDTH / 3, 25);
    [batchDn setImage:[UIImage imageNamed:@"iconfont-xiazai01"] forState:UIControlStateNormal];

    [batchDn setImageEdgeInsets:UIEdgeInsetsMake(0, - kWIDTH / 35, 0, 0)];
    
    [batchDn setTitle:@"批量下载" forState:UIControlStateNormal];
    batchDn.titleLabel.font = [UIFont systemFontOfSize:12];
    [batchDn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [batchDn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [batchDn addTarget:self action:@selector(doBatchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.albumView addSubview:batchDn];
}

#pragma mark --- 按钮点击事件
- (void)doBatchBtn:(UIButton *)button{
    MoreDownViewController *moreVC = [[MoreDownViewController alloc]init];
    moreVC.view.backgroundColor = [UIColor whiteColor];
    moreVC.audioArray =[NSMutableArray arrayWithArray:self.albumDataArray];
    [moreVC reloadView];
    [self.navigationController pushViewController:moreVC animated:YES];
//    [moreVC release];
}

#pragma mark --- 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.albumDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AudioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.albumList = self.albumDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[SingleModel shareSingleModel].playC initWithAvplayer:indexPath.row albumList:[NSMutableArray arrayWithArray: self.albumDataArray] sAlbum:self.sAlbum];
    self.navigationController.tabBarController.selectedIndex = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
