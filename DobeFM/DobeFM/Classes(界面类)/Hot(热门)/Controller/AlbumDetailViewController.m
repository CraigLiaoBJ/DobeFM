//
//  AlbumDetailViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//
#import "MoreDownViewController.h"
#import "AlbumDetailViewController.h"
#import "AudioCell.h"
//#import "AvPlayViewController.h"
#import "AlbumIntro.h"
#import "AlbumItem.h"
#import "AlbumList.h"
#import "ReconmmendAlbumViewController.h"
//#import "AlbumAudioModel.h"
#define URLSTR @"http://mobile.ximalaya.com/mobile/others/ca/album/track/"
@interface AlbumDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
//@property(nonatomic,strong)AvPlayViewController *playC;
@property (nonatomic, retain) AlbumIntro *albumView;
@property (nonatomic, retain) UIImageView *functionImageView;
@property (nonatomic, retain) UILabel *introLabel;
@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) NSMutableArray *albumIntroArray;
@property (nonatomic, retain) NSMutableArray *albumDataArray;

@property (nonatomic, retain) AlbumList *albumList;
@end
static NSInteger n = 1;
//static NSInteger count = 0;
@implementation AlbumDetailViewController

- (void)dealloc{
    [_albumId release];
    [_imageView release];
    [_tableView release];
    [_dataArray release];
    [_albumView release];
    [_functionImageView release];
    [_introLabel release];
    [_titleLabel release];

    [_sAlbum release];

    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专辑详情";
    self.dataArray = [NSMutableArray array];
    [self loadData];
    [self loadAudioData];
    [self addIntroImageView];
    [self addTableView];
    [self refreshAndLoad];
}

#pragma mark --- 介绍部分
- (void)addIntroImageView{
    self.albumView = [[AlbumIntro alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.albumView];
    [_albumView release];
}

#pragma mark --- 加载tableView
- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHEIGHT / 3, kWIDTH, kHEIGHT - 34 - kWIDTH / 5 - 120) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor cyanColor];
    UIVisualEffectView *bgdEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.tableView addSubview:bgdEffect];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.albumView addSubview:self.tableView];

    self.functionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    self.functionImageView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = self.functionImageView;
    self.functionImageView.userInteractionEnabled = YES;
    [self batchButtons];

    [self.tableView registerClass:[AudioCell class] forCellReuseIdentifier:@"CELL"];
    
    [_functionImageView release];
//    [_tableView release];
}

#pragma mark --- 数据请求
- (void)loadData{
    __block typeof (self) aSelf = self;
    NSString *string = [URLSTR stringByAppendingFormat:@"%@/true/1/15", self.albumId];
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        AlbumItem *albumItem = [[AlbumItem alloc]init];
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *introDic = dic[@"album"];
        [albumItem setValuesForKeysWithDictionary:introDic];
        aSelf.albumView.albumItem = albumItem;
        [albumItem release];
    }];
}

- (void)loadAudioData{
    self.albumDataArray = [NSMutableArray array];
    __block typeof (self) audioSelf = self;
    NSString *string = [URLSTR stringByAppendingFormat:@"%@/true/%ld/15", self.albumId, n];
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        
        NSDictionary *tracksDic = dic[@"tracks"];
        NSArray *listArray = tracksDic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            audioSelf.albumList = [[AlbumList alloc]init];
            [audioSelf.albumList setValuesForKeysWithDictionary:tempDic];
            [audioSelf.albumDataArray addObject:audioSelf.albumList];
            [_albumList release];
        }
        [audioSelf.tableView reloadData];
    }];

}
#pragma mark --- refresh and load
- (void)refreshAndLoad{
    __block AlbumDetailViewController *weakSelf = self;
    
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
        [weakSelf.albumDataArray removeAllObjects];
        [weakSelf loadData];
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.gifHeader endRefreshing];
    }];
    [self.tableView.gifHeader setGifName:@"demo.gif"];
    
    self.tableView.defaultHeader.refreshLayoutType = LORefreshLayoutTypeTopIndicator;
    self.tableView.defaultFooter.refreshLayoutType = LORefreshLayoutTypeRightIndicator;
}

#pragma mark --- 按钮
- (void)batchButtons{
    //批量下载按钮
    UIButton *batchDn = [UIButton buttonWithType:UIButtonTypeCustom];
    batchDn.frame = CGRectMake(20, 0, kWIDTH / 3, 44);
    [batchDn setImage:[UIImage imageNamed:@"album-download.png"] forState:UIControlStateNormal];
    [batchDn setImage:[UIImage imageNamed:@"album-download-2.png"] forState:UIControlStateSelected];
    [batchDn setImageEdgeInsets:UIEdgeInsetsMake(0, - kWIDTH / 20, 0, 0)];
    
    [batchDn setTitle:@"批量下载" forState:UIControlStateNormal];
    [batchDn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [batchDn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [batchDn setTitle:@"批量下载" forState:UIControlStateSelected];
    [batchDn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [batchDn addTarget:self action:@selector(doBatchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionImageView addSubview:batchDn];
    [batchDn release];
    //相关专辑按钮
    UIButton *relateDn = [UIButton buttonWithType:UIButtonTypeCustom];
    relateDn.frame = CGRectMake(kWIDTH / 2 + 20, 0, kWIDTH / 3, 44);
    [relateDn setImage:[UIImage imageNamed:@"album-relate.png"] forState:UIControlStateNormal];
    [relateDn setImage:[UIImage imageNamed:@"album-relate-2.png"] forState:UIControlStateSelected];
    [relateDn setImageEdgeInsets:UIEdgeInsetsMake(0, - kWIDTH / 20, 0, 0)];
    
    [relateDn setTitle:@"相关专辑" forState:UIControlStateNormal];
    [relateDn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [relateDn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [relateDn setTitle:@"相关专辑" forState:UIControlStateSelected];
    [relateDn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [relateDn addTarget:self action:@selector(doRelateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionImageView addSubview:relateDn];
    [relateDn release];
}

#pragma mark --- 按钮点击事件

- (void)doBatchBtn:(UIButton *)button{
    MoreDownViewController *moreVC = [[MoreDownViewController alloc]init];
    moreVC.view.backgroundColor = [UIColor whiteColor];
    moreVC.audioArray =[[NSMutableArray alloc]initWithArray: self.albumDataArray];
    [moreVC  reloadView];
    [self.navigationController pushViewController:moreVC animated:YES];
    [moreVC release];
}
- (void)doRelateBtn:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;
    } else {
        button.selected = YES;
    }
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
    
    [self.navigationController pushViewController:[SingleModel shareSingleModel].playC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
