//
//  SearchTableViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/27.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SearchTableViewController.h"
#import "AnchorInfoTableViewController.h"
#import "AlbumDetailViewController.h"
#import "AnchorCell.h"
#import "AlbumCell.h"
#import "AudioCell.h"
#import "AnchorIntroModel.h"
#import "AlbumList.h"
#import "SearchAlbum.h"
#define ALBUMURL @"http://mobile.ximalaya.com/s/mobile/search?device=iPhone&condition="

#define ANCHORURL @"http://mobile.ximalaya.com/s/mobile/search?device=iPhone&condition="

#define AUDIOURL @"http://mobile.ximalaya.com/s/mobile/search?device=iPhone&condition=%E5%93%88%E5%93%88&page=1&per_page=20&scope=voice"

@interface SearchTableViewController ()

@property (nonatomic, retain) NSMutableArray *anchorArray;

@property (nonatomic, retain) NSMutableArray *albumArray;

@property (nonatomic, retain) NSMutableArray *audioArray;

@property (nonatomic, retain) UISegmentedControl *segmentedControl;

@end

static NSInteger n = 1;
@implementation SearchTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.anchorArray = [NSMutableArray array];
    self.albumArray = [NSMutableArray array];
    self.audioArray = [NSMutableArray array];
    
    self.tableView.backgroundColor = CELLCOLOR;
    self.tableView.tableFooterView = nil;
    self.tableView.rowHeight = 100;
//    [self refreshAndLoad];
    //注册主播单元格
    [self.tableView registerClass:[AnchorCell class] forCellReuseIdentifier:@"anchor"];
     //注册专辑单元格
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"album"];
     //注册声音单元格
    [self.tableView registerClass:[AudioCell class] forCellReuseIdentifier:@"audio"];
    [self refreshData];
    //设置分段控制器
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"找专辑", @"找人", @"找声音"]];
    _segmentedControl.frame = CGRectMake(0, 64, kWIDTH, 40);
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor orangeColor];
    [_segmentedControl addTarget:self action:@selector(didClickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    self.tableView.tableHeaderView = _segmentedControl;
}

- (void)didClickSegmentedControl:(UISegmentedControl *)seg{
    if (0 == seg.selectedSegmentIndex) {
        [self loadAlbumData];
    } else if (1 == seg.selectedSegmentIndex){
        [self loadAnchorData];
    } else {
        [self loadAudioData];
    }
}

- (void)refreshData{
    __block SearchTableViewController *blockSelf = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (n == 1) {
                n = 1;
            } else {
                n --;
            }
            if (0 == self.segmentedControl.selectedSegmentIndex) {
                [blockSelf.albumArray removeAllObjects];
                [blockSelf loadAlbumData];
                 [blockSelf.tableView reloadData];
            } else if (1 == self.segmentedControl.selectedSegmentIndex){
                [blockSelf.anchorArray removeAllObjects];
                [blockSelf loadAnchorData];
                 [blockSelf.tableView reloadData];
            } else {
                [blockSelf.audioArray removeAllObjects];
                [blockSelf loadAudioData];
                 [blockSelf.tableView reloadData];
            }

           
            [blockSelf.tableView.header endRefreshing];
        });
    }];
    self.tableView.header.autoChangeAlpha = YES;
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            n ++;
            if (0 == self.segmentedControl.selectedSegmentIndex) {
                [blockSelf loadAlbumData];
                 [blockSelf.tableView reloadData];
            } else if (1 == self.segmentedControl.selectedSegmentIndex){
                [blockSelf loadAnchorData];
                 [blockSelf.tableView reloadData];
            } else {
                [blockSelf loadAudioData];
                 [blockSelf.tableView reloadData];
            }

            [blockSelf.tableView.footer endRefreshing];
        });
    }];
    self.tableView.footer.autoChangeAlpha = YES;
}

- (void)loadAlbumData{
    NSString *string = [ALBUMURL stringByAppendingFormat:@"%@&page=%ld&per_page=20&scope=album", self.searchName, n];
    NSLog(@"%@", self.searchName);
    NSString *albumString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    __block typeof(self) aSelf = self;
    [Networking recivedDataWithURLString:albumString method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *responseDic = dic[@"response"];
        NSArray *docsArray = responseDic[@"docs"];
        for (NSDictionary *tempDic in docsArray) {
            SearchAlbum *albumDoc = [[SearchAlbum alloc]init];
            [albumDoc setValuesForKeysWithDictionary:tempDic];
            [_albumArray addObject:albumDoc];
            NSLog(@"%@", albumDoc.nickname);
        }
        [aSelf.tableView reloadData];
    }];
}

- (void)loadAnchorData{
    
    NSString *string = [ALBUMURL stringByAppendingFormat:@"%@&page=%ld&per_page=20&scope=user", self.searchName, n];
    NSString *albumString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    __block typeof(self) aSelf = self;
    [Networking recivedDataWithURLString:albumString method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *responseDic = dic[@"response"];
        NSArray *docsArray = responseDic[@"docs"];
        for (NSDictionary *tempDic in docsArray) {
            AnchorIntroModel *anchorDoc = [[AnchorIntroModel alloc]init];
            [anchorDoc setValuesForKeysWithDictionary:tempDic];
            [_anchorArray addObject:anchorDoc];
        }
        [aSelf.tableView reloadData];
    }];
}

- (void)loadAudioData{
    NSString *string = [ALBUMURL stringByAppendingFormat:@"%@&page=%ld&per_page=20&scope=voice", self.searchName, n];
    NSString *albumString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    __block typeof(self) aSelf = self;
    [Networking recivedDataWithURLString:albumString method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *responseDic = dic[@"response"];
        NSArray *docsArray = responseDic[@"docs"];
        for (NSDictionary *tempDic in docsArray) {
            AlbumList *audioDoc = [[AlbumList alloc]init];
            [audioDoc setValuesForKeysWithDictionary:tempDic];
            [_audioArray addObject:audioDoc];
        }
        [aSelf.tableView reloadData];
    }];

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
    if (0 == _segmentedControl.selectedSegmentIndex) {
        return self.albumArray.count;
    } else if (1 == _segmentedControl.selectedSegmentIndex){
        return self.anchorArray.count;
    } else {
        return self.audioArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _segmentedControl.selectedSegmentIndex) {
        AlbumCell *albumCell = [tableView dequeueReusableCellWithIdentifier:@"album" forIndexPath:indexPath];
        albumCell.searchAlbum = self.albumArray[indexPath.row];
        return albumCell;
    } else if (1 == _segmentedControl.selectedSegmentIndex){
        AnchorCell *anchorCell = [tableView dequeueReusableCellWithIdentifier:@"anchor" forIndexPath:indexPath];
        anchorCell.anchorInfo = self.anchorArray[indexPath.row];
        return anchorCell;
    } else {
        AudioCell *audioCell = [tableView dequeueReusableCellWithIdentifier:@"audio" forIndexPath:indexPath];
        audioCell.albumList = self.audioArray[indexPath.row];
        return audioCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == _segmentedControl.selectedSegmentIndex) {
        AlbumDetailViewController *albumVC = [[AlbumDetailViewController alloc]init];
        albumVC.albumId = [self.albumArray[indexPath.row] albumId];
        NSLog(@"%@",albumVC.albumId);
        [self.navigationController pushViewController:albumVC animated:YES];
    } else if (1 == _segmentedControl.selectedSegmentIndex){
        AnchorInfoTableViewController *anchorVC = [[AnchorInfoTableViewController alloc]init];
        anchorVC.anchorId = [[self.anchorArray[indexPath.row] anchorUid]stringValue];
        [self.navigationController pushViewController:anchorVC animated:YES];
    } else {
        [[SingleModel shareSingleModel].playC initWithAvplayer:indexPath.row albumList:[NSMutableArray arrayWithArray: self.audioArray] sAlbum:nil];
        self.navigationController.tabBarController.selectedIndex = 2;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    [_searchBar resignFirstResponder];
    [self.view endEditing:YES];
}

@end
