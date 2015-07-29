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
#import "SearchTableViewController.h"
#import "DiscoverModel.h"
#import "DiscoverCell.h"

#define URLStr @"http://mobile.ximalaya.com/m/super_explore_index2?channel=ios-b1&device=iPhone&includeActivity=true&picVersion=9&scale=3&version=3.1.43"

@interface DiscoverViewControlerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>
@property (nonatomic, retain) UISearchBar *searchBar;

//@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;
//
@property (nonatomic, retain) SearchTableViewController *searchTableViewController;
//
@property (nonatomic, retain) NSMutableArray *dataArray; //数据源数组
//
@property (nonatomic, retain) UICollectionView *collectionView;//整个界面的集合视图

@property (nonatomic, copy) NSString *searchName;//搜索条件，输入什么传到下一个界面

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
    self.view.backgroundColor = [UIColor whiteColor];

    //添加集合视图
    [self addCollectionView];
    //加载数据
    [self loadData];
    
    //添加搜索栏
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    _searchBar.placeholder = @"搜索";
    self.navigationItem.titleView = _searchBar;
//    [self.navigationController.navigationBar addSubview:searchBar];
    _searchBar.delegate = self;

    _searchTableViewController = [[SearchTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [_searchTableViewController.view setFrame:CGRectMake(0, 40, 200, 0)];
    [self addChildViewController:_searchTableViewController];
    [self.view addSubview:_searchTableViewController.view];
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

#pragma mark --- UISearchBar的代理方法
//搜索框的内容发生改变时，回调（即要搜索的内容改变）
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (0 == searchBar.text.length) {
        [self setSearchControllerHidden:YES];//控制下拉列表的隐现
    } else {
        [self setSearchControllerHidden:NO];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for (id cc in [searchBar subviews]) {
        if ([cc isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    NSLog(@"should begin");
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search clicked");
    [_searchBar resignFirstResponder];

    _searchTableViewController.searchName = searchBar.text;
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"cancel clicked");
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
    [_searchTableViewController.tableView reloadData];
    [self setSearchControllerHidden:YES];
}


//设置隐藏方法
- (void)setSearchControllerHidden:(BOOL)hidden{
    NSInteger height = hidden ? 0 : kHEIGHT;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];

    [_searchTableViewController.view setFrame:CGRectMake(0, 64, kWIDTH, height)];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
