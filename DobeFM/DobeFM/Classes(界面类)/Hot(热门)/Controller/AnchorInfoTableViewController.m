//
//  AnchorInfoTableViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/15.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AnchorInfoTableViewController.h"
#import "SearchAlbum.h"
#import "AlbumList.h"
#import "AnchorIntroModel.h"
#import "AlbumCell.h"
#import "AudioCell.h"

#define URLIntro @"http://mobile.ximalaya.com/mobile/others/ca/homePage?device=iPhone&toUid="
#define URLAlbum @"http://mobile.ximalaya.com/mobile/others/ca/album/"
#define URLAudio @"http://mobile.ximalaya.com/mobile/others/ca/track/"

@interface AnchorInfoTableViewController ()
@property (nonatomic, retain) AnchorIntroModel *anchorIntroModel;
@property (nonatomic, retain) NSMutableArray *introArray;//介绍
@property (nonatomic, retain) NSMutableArray *albumArray;//专辑
@property (nonatomic, retain) NSMutableArray *audioArray;//声音

@end
static NSInteger n = 1;
static NSInteger i = 1;
@implementation AnchorInfoTableViewController

- (void)dealloc{
    [_anchorId release];
    [_anchorIntroModel release];

    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主播详情";
    self.introArray = [NSMutableArray array];
    self.albumArray = [NSMutableArray array];
    self.audioArray = [NSMutableArray array];

    self.view.backgroundColor = CELLCOLOR;
    [self loadData];
    [self refreshData];
//    [self refreshAndLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self addHeaderImage];
    self.tableView.rowHeight = 100;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"CELL"];
    [self.tableView registerClass:[AudioCell class] forCellReuseIdentifier:@"identifier"];
}

- (void)refreshData{
    __block typeof(self) blockSelf = self;
    
    blockSelf.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (n == 1){
                n = 1;
                i = 1;
            } else {
                n --;
                i --;
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
            i ++;
            [blockSelf.tableView reloadData];
            [blockSelf.tableView.footer endRefreshing];
        });
    }];
    blockSelf.tableView.footer.autoChangeAlpha = YES;
}

#pragma mark --- 加载数据
- (void)loadData{
    NSString *introString = [URLIntro stringByAppendingFormat:@"%@", self.anchorId];
    NSString *albumString = [URLAlbum stringByAppendingFormat:@"%@/%ld/%ld", self.anchorId, i, i * 2];
    NSString *audioString = [URLAudio stringByAppendingFormat:@"%@/%ld/%ld", self.anchorId, n, n * 30];
    __block typeof(self) aSelf = self;
    [Networking recivedDataWithURLString:introString method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        aSelf.anchorIntroModel = [[AnchorIntroModel alloc]init];
        [aSelf.anchorIntroModel setValuesForKeysWithDictionary:dic];
        [aSelf addHeaderImage];
        [_anchorIntroModel release];
    }];
    
    [Networking recivedDataWithURLString:albumString method:@"GET" body:nil block:^(id object) {
        NSDictionary *albumDic = (NSDictionary *)object;
        NSArray *listArray = albumDic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            SearchAlbum *anchorAlbumModel = [[SearchAlbum alloc]init];
            [anchorAlbumModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.albumArray addObject:anchorAlbumModel];
            [anchorAlbumModel release];
        }
        [aSelf.tableView reloadData];
    }];

    [Networking recivedDataWithURLString:audioString method:@"GET" body:nil block:^(id object) {
        NSDictionary *audioDic = (NSDictionary *)object;
        NSArray *audioArray = audioDic[@"list"];
        for (NSDictionary *adDic in audioArray) {
            AlbumList *anchorAudioModel = [[AlbumList alloc]init];
            [anchorAudioModel setValuesForKeysWithDictionary:adDic];
            [aSelf.audioArray addObject:anchorAudioModel];
            [anchorAudioModel release];
        }
        [aSelf.tableView reloadData];
    }];
}

#pragma mark --- 头视图
- (void)addHeaderImage{
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 160)];
    self.tableView.tableHeaderView = headerImageView;
    
    UIImageView *bgdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 160)];
    bgdImageView.backgroundColor = [UIColor colorWithRed:0.654 green:0.487 blue:0.596 alpha:0.500];

    [headerImageView addSubview:bgdImageView];
    [bgdImageView release];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake((kWIDTH - 60) / 2, 5, 60, 60)];
    iconImage.backgroundColor = cellImageColor;
    NSURL *coverUrl = [NSURL URLWithString:self.anchorIntroModel.mobileMiddleLogo];
    [iconImage sd_setImageWithURL:coverUrl];
    iconImage.layer.cornerRadius = 30;
    iconImage.layer.masksToBounds = YES;
    [bgdImageView addSubview:iconImage];
    [iconImage release];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWIDTH - kWIDTH / 2) / 2, 75, kWIDTH / 2, 15)];
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    nameLabel.text = self.anchorIntroModel.nickname;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [bgdImageView addSubview:nameLabel];
    [nameLabel release];
    
    UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, kWIDTH - 20, 50)];
    tagLabel.font = [UIFont systemFontOfSize:12];
    tagLabel.textAlignment = NSTextAlignmentLeft;
    tagLabel.text = self.anchorIntroModel.personalSignature;
    tagLabel.numberOfLines = 0;
    [bgdImageView addSubview:tagLabel];
    [tagLabel release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return self.albumArray.count;
    } else {
        return self.audioArray.count;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        AlbumCell *albumcell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        albumcell.searchAlbum = self.albumArray[indexPath.row];
        return albumcell;
    } else {
        AudioCell *anchorcell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
        anchorcell.albumList = self.audioArray[indexPath.row];
        return anchorcell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray * array = @[@"发布的专辑", @"发布的声音"];
    if (section == 0){
        return array[0];
        
    } else{
        return array[1];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        AlbumDetailViewController *albumVC = [[AlbumDetailViewController alloc]init];
        albumVC.albumId = [self.albumArray[indexPath.row] albumId];
        [self.navigationController pushViewController:albumVC animated:YES];
        [albumVC release];
    } else {
    [[SingleModel shareSingleModel].playC initWithAvplayer:indexPath.row albumList:[NSMutableArray arrayWithArray: self.audioArray] sAlbum:nil];
    self.navigationController.tabBarController.selectedIndex = 2;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = CELLCOLOR;
}

@end
