//
//  DiscoverViewControlerViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/15.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//
#define WINWIDTH (self.view.frame.size.width/6)

#import "DiscoverViewControlerViewController.h"
#import "ClassViewController.h"
#import "DiscoverModel.h"
#import "DiscoverCell.h"
#define URLStr @"http://mobile.ximalaya.com/m/super_explore_index2?channel=ios-b1&device=iPhone&includeActivity=true&picVersion=9&scale=3&version=3.1.43"

@interface DiscoverViewControlerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSArray *data;
    NSArray *filterData;
    UISearchDisplayController *searchDisplayerController;
}

@property (nonatomic, retain) NSMutableArray *dataArray; //数据源数组

@property (nonatomic, retain) UICollectionView *collectionView;//整个界面的集合视图

@end

@implementation DiscoverViewControlerViewController

- (void)dealloc{
    [_dataArray release];
    [_collectionView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = nil;
    self.view.backgroundColor = CELLCOLOR;

    //添加集合视图
    [self addCollectionView];
    //加载数据
    [self loadData];
    
    //添加搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    searchBar.placeholder = @"搜索";
    [self.navigationController.navigationBar addSubview:searchBar];
    
    //初始化searchDisplayerController
    searchDisplayerController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayerController.searchResultsDataSource = self;
    searchDisplayerController.searchResultsDelegate = self;
    
    
}

#pragma mark ---  添加collectionView
- (void)addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc]init]autorelease];
    flowLayout.itemSize = CGSizeMake(kWIDTH / 5.3, kHEIGHT / 8.2);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView = [[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT) collectionViewLayout:flowLayout]autorelease];
    
    self.collectionView.backgroundColor = cellImageColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];

    //注册Cell
    [self.collectionView registerClass:[DiscoverCell class] forCellWithReuseIdentifier:@"CELL"];
//    [flowLayout release];
//    [_collectionView release];
}

#pragma mark --- 加载数据
- (void)loadData{
    __block typeof(self) mainSelf = self;
    [Networking recivedDataWithURLString:URLStr method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *cgtDic = dic[@"categories"];
        NSArray *dataArray = cgtDic[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            DiscoverModel *discoverModel = [[DiscoverModel alloc]init];
            [discoverModel setValuesForKeysWithDictionary:tempDic];
            [mainSelf.dataArray addObject:discoverModel];
            [discoverModel release];
        }
        [mainSelf.collectionView reloadData];
    }];
}

#pragma mark ---  代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark --- 重用机制
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] coverPath]];
    [cell.picture sd_setImageWithURL:url];
    return cell;
}

#pragma mark --- 点击跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassViewController *classVC = [[ClassViewController alloc]init];
    //类目ID号，用于下个页面加载数据
    classVC.sortId = [self.dataArray[indexPath.row] categoryId];
    //类目名称
    classVC.sortName = [self.dataArray[indexPath.row] name];
    //页面名称
    classVC.pageTitle = [self.dataArray[indexPath.row] title];
    [self.navigationController pushViewController:classVC animated:YES];
    [classVC release];
}

#pragma mark --- searchDisplayController的TableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (tableView == self.tableView) {
//        return data.count;
//    } else {
    //谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", searchDisplayerController.searchBar.text];
        filterData = [[NSArray alloc]initWithArray:[data filteredArrayUsingPredicate:predicate]];
        return filterData.count;
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
