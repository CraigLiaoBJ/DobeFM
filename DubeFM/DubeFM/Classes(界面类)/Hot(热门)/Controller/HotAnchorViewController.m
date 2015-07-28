//
//  HotAnchorViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "HotAnchorViewController.h"
#import "HotAnchorCell.h"
#import "HotAnchorItem.h"
#import "AnchorInfoTableViewController.h"
#define URLStr @"http://mobile.ximalaya.com/m/explore_user_list?category_name=all&condition=hot&device=iPhone&page="

@interface HotAnchorViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataArray;

@end

static NSInteger n = 1;
@implementation HotAnchorViewController

//- (void)dealloc{
//    [_collectionView release];
//    [super dealloc];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = cellImageColor;
    
    self.title = @"最火主播";
    [self addCollectionView];
    [self loadData];
    [self refreshData];
}

#pragma mark --- 添加集合视图
- (void)addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(kWIDTH / 3.2, kHEIGHT / 4.5);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = CELLCOLOR;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;

    [self.collectionView registerClass:[HotAnchorCell class] forCellWithReuseIdentifier:@"CELL"];
     [self.view addSubview:self.collectionView];
//    [flowLayout release];
//    [_collectionView release];
}

#pragma mark --- 获取数据
- (void)loadData{
    NSString *string = [URLStr stringByAppendingFormat:@"%ld&per_page=20", n];
    __block typeof(self) aSelf = self;
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            HotAnchorItem *hotAnchorItem = [[HotAnchorItem alloc]init];
            [hotAnchorItem setValuesForKeysWithDictionary:tempDic];
            [aSelf.dataArray addObject:hotAnchorItem];
//            [hotAnchorItem release];
        }
        [aSelf.collectionView reloadData];
    }];
}

#pragma mark --- 刷新数据
- (void)refreshData{
    __block HotAnchorViewController *blockSelf = self;
    
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (n == 1) {
                n = 1;
            } else {
                n --;
            }
            [blockSelf loadData];
            [blockSelf.collectionView reloadData];
            [blockSelf.collectionView.header endRefreshing];
        });
    }];
    self.collectionView.header.autoChangeAlpha = YES;
    
    self.collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             n ++;
//            [blockSelf.dataArray removeAllObjects];
            [blockSelf loadData];
            [blockSelf.collectionView reloadData];
            [blockSelf.collectionView.footer endRefreshing];
        });
    }];
    self.collectionView.footer.autoChangeAlpha = YES;
}

#pragma mark --- 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotAnchorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    //给item上添加信息
    for (int i = 0; i < self.dataArray.count; i ++) {
        NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row]largeLogo]];
        [cell.picView sd_setImageWithURL:url];
        
        cell.nameLabel.text = [self.dataArray[indexPath.row]nickname];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AnchorInfoTableViewController *anchorDetail = [[AnchorInfoTableViewController alloc]init];
    anchorDetail.anchorId = [[self.dataArray[indexPath.row]uid]stringValue];
    [self.navigationController pushViewController:anchorDetail animated:YES];
//    [anchorDetail release];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = cellImageColor;
}
     
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
