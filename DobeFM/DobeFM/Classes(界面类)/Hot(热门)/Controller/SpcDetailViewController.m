//
//  SpcDetailTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpcDetailViewController.h"
#import "AlbumCell.h"
#import "AudioCell.h"
#import "AlbumDetailViewController.h"
#import "SearchAlbum.h"
#import "AlbumList.h"
#define SPCLURL @"http://mobile.ximalaya.com/m/subject_detail?device=iPhone&id="
@interface SpcDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImageView *introCoverImage;//详情头部封面图片
@property (nonatomic, retain) UILabel *titleLabel;//专题名称
@property (nonatomic, retain) UILabel *introLabel;//内容简介
@property (nonatomic, retain) UILabel *nickNameLabel;//作者
@property (nonatomic, retain) UIImageView *icon;//作者头像
@property (nonatomic, retain) NSMutableArray *splDtlArray;//详情数据数组
@property (nonatomic, retain) NSMutableArray *spcAlbumArray;//cell上的数据
@property (nonatomic, retain) NSMutableArray *spcAudioArray;//cell上的音频数据

@end

@implementation SpcDetailViewController

- (void)dealloc{

    [_tableView release];
    [_headView release];
    [_spclDetlItem release];
    [_spcTypeID release];
    [_introCoverImage release];
    [_titleLabel release];
    [_introLabel release];
    [_nickNameLabel release];
    [_icon release];
    [super dealloc];
}

#pragma mark -- viewDidLoad方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题详情";
    self.dataArray = [NSMutableArray array];
    [self addTableView];

    [self loadNetData];
    [self loadAlbumData];
//    [self refreshAndLoad];
}

#pragma mark ---  加载介绍网络数据
- (void)loadNetData{
    self.splDtlArray = [NSMutableArray array];
    NSString *string = [SPCLURL stringByAppendingFormat:@"%@", self.addID];
    
    __block typeof(self) spcDtl = self;
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *introDic = dic[@"info"];
        spcDtl.spclDetlItem = [[SpecialDetailItem alloc]init];

        [spcDtl.spclDetlItem setValuesForKeysWithDictionary:introDic];
        [spcDtl addintroInfo];
        [_spclDetlItem release];
    }];
}

#pragma mark --- 加载Album网络数据
- (void)loadAlbumData{
    self.spcAlbumArray = [NSMutableArray array];
    self.spcAudioArray = [NSMutableArray array];

    NSString *string = [SPCLURL stringByAppendingFormat:@"%@", self.addID];
    __block typeof (self) aSelf = self;
    
    if ([self.spcTypeID isEqualToString:@"2"]) {

        [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
            NSDictionary *dic = (NSDictionary *)object;
            NSArray *listArray = [NSArray arrayWithArray: dic[@"list"]];
            for (NSDictionary *tempDic in listArray) {
                AlbumList *spcAudioModel = [[AlbumList alloc]init];
                [spcAudioModel setValuesForKeysWithDictionary:tempDic];
                [aSelf.spcAudioArray addObject:spcAudioModel];
                [spcAudioModel release];
            }
            [aSelf.tableView reloadData];
        }];
        
    } else {
        [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
            NSDictionary *dic = (NSDictionary *)object;
            NSArray *listArray = [NSArray arrayWithArray: dic[@"list"]];
            for (NSDictionary *tempDic in listArray) {
                SearchAlbum *spcDtlClModel = [[SearchAlbum alloc]init];
                [spcDtlClModel setValuesForKeysWithDictionary:tempDic];
                [aSelf.spcAlbumArray addObject:spcDtlClModel];
                [spcDtlClModel release];
            }
            [aSelf.tableView reloadData];
        }];
    }
}

#pragma mark --- refresh and load
//- (void)refreshAndLoad{
//    __block SpcDetailTableViewController *weakSelf = self;
//    
//    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeFooterDefault refreshingBlock:^{
//        [weakSelf loadAlbumData];
//        [weakSelf.tableView reloadData];
//        //结束刷新
//        [weakSelf.tableView.defaultFooter endRefreshing];
//    }];
//    
//    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeHeaderGif refreshingBlock:^{
//     
//        [weakSelf.spcAlbumArray removeAllObjects];
//        [weakSelf.spcAudioArray removeAllObjects];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.gifHeader endRefreshing];
//    }];
//    
//    [self.tableView.gifHeader setGifName:@"demo.gif"];
//    
//    self.tableView.defaultHeader.refreshLayoutType = LORefreshLayoutTypeTopIndicator;
//    self.tableView.defaultFooter.refreshLayoutType = LORefreshLayoutTypeRightIndicator;
//}


#pragma --- 添加表视图
- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT ) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.911 green:0.889 blue:0.948 alpha:1.000];
    
    self.headView = [[UIImageView alloc]init];
    self.headView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT / 3 * 2);
    
    [self.tableView addSubview:self.headView];
    self.tableView.tableHeaderView = self.headView;

    [self.view addSubview:self.tableView];

    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"CELL"];
    [self.tableView registerClass:[AudioCell class] forCellReuseIdentifier:@"identifier"];
    [_headView release];
//    [_tableView release];
}

#pragma mark --- 添加头部视图中的内容
- (void)addintroInfo{
    //封面图片
    self.introCoverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, kWIDTH, kHEIGHT / 4)];
    NSURL *bigUrl = [NSURL URLWithString:self.spclDetlItem.coverPathBig];
    [self.introCoverImage sd_setImageWithURL:bigUrl];

    [self.headView addSubview:self.introCoverImage];
    [_introCoverImage release];
    //标题
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHEIGHT / 4 + 10 + 5, kWIDTH, 20)];
    self.titleLabel.text = self.spclDetlItem.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.titleLabel];
    [_titleLabel release];
    
    //分割线
    UILabel *speLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHEIGHT / 4 + 35 + 5, kWIDTH, 1)];
    speLabel.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:speLabel];
    [speLabel release];
    
    //介绍内容
    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHEIGHT + 40, kWIDTH, kHEIGHT / 8)];
    self.introLabel.font = [UIFont systemFontOfSize:13];
    self.introLabel.text = self.spclDetlItem.intro;
    self.introLabel.numberOfLines = 0;
    CGFloat height = [self getStringHeightBaseFont:13 width:kWIDTH - 40 string:self.introLabel.text];
    self.introLabel.frame = CGRectMake(20, 50 + kHEIGHT / 4, kWIDTH - 40, height);
    [self.headView addSubview:self.introLabel];
    [_introLabel release];
    //专题作者
    UILabel *specialLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, height + 10 + kHEIGHT / 4 + 50, 70, 30)];
    specialLabel.text = @"专题作者";
    specialLabel.font = [UIFont systemFontOfSize:13];
    [self.headView addSubview:specialLabel];
    [specialLabel release];
    //作者图标
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(205, height + 5 + kHEIGHT / 4 + 50, 40 , 40)];
    self.icon.layer.cornerRadius = 20.f;
    self.icon.layer.masksToBounds = YES;
    NSURL *iconUrl = [NSURL URLWithString:self.spclDetlItem.smallLogo];
    [self.icon sd_setImageWithURL:iconUrl];
    [self.headView addSubview:self.icon];
    [_icon release];
    //专题作者
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(247.5, height + 10 + kHEIGHT / 4 + 50, 100, 30)];
    self.nickNameLabel.text = self.spclDetlItem.nickname;
    self.nickNameLabel.font = [UIFont systemFontOfSize: 13];
    [self.headView addSubview:self.nickNameLabel];
    [_nickNameLabel release];
    
}
#pragma mark --- 自适应高度方法
- (CGFloat)getStringHeightBaseFont:(CGFloat)font width:(CGFloat)width string:(NSString *)string{
    //计算高度的方法
    CGRect contentRect = [string boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return contentRect.size.height;
}

#pragma --- 表视图的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.spcTypeID isEqualToString:@"2"]) {
       
        return self.spcAudioArray.count;
    } else {
        return self.spcAlbumArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.spcTypeID isEqualToString:@"2"]) {
        AudioCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
        cell1.albumList = self.spcAudioArray[indexPath.row];
        return cell1;
    } else {
        AlbumCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell2.searchAlbum = self.spcAlbumArray[indexPath.row];
    return cell2;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.spcTypeID isEqualToString:@"2"]) {
        
        [[SingleModel shareSingleModel].playC initWithAvplayer:indexPath.row albumList:[NSMutableArray arrayWithArray: self.spcAudioArray] sAlbum:nil];
        
        [self.navigationController pushViewController:[SingleModel shareSingleModel].playC animated:YES];

    }
    if ([self.spcTypeID isEqualToString:@"1"]) {
        AlbumDetailViewController *albumDetail = [[AlbumDetailViewController alloc]init];
        albumDetail.albumId = [self.spcAlbumArray[indexPath.row] albumId];
        [self.navigationController pushViewController:albumDetail animated:YES];
        [albumDetail release];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
