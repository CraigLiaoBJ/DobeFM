//
//  ClassViewController.m
//  DobeFM
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//
#import "ClassViewController.h"
#import "CustomCell.h"
#import "AnchorInfoTableViewController.h"
#import "Networking.h"
#import "ScrollModel.h"
#import "CellModel.h"
#import "MainAlbumTableViewController.h"
#define URLSTR @"http://mobile.ximalaya.com/m/category_focus_image?categoryId="
#define AlbumStr @"http://mobile.ximalaya.com/m/category_tag_list?category="

@interface ClassViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) NSMutableArray *scrollArray;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic, retain) NSMutableArray *cellDataArray;
@property (nonatomic, retain) UICollectionView *collectionVC;
@property (nonatomic, retain) AutoView *autoView;

@end

static NSInteger h = 172;
@implementation ClassViewController

- (void)dealloc{
    [_sortId release];
    [_sortName release];
    [_pageTitle release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollArray = [NSMutableArray array];
    self.cellDataArray = [NSMutableArray array];
    self.imagesArray = [NSMutableArray array];
    self.title = [NSString stringWithFormat:@"%@", self.pageTitle];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CELLCOLOR;

     //轮播图上图片来源数组
    [self reData];
    //cell上的数据来源
    [self reCellData];

}

#pragma mark --- 加载轮播图数据
- (void)reData{
    NSString *string = [URLSTR stringByAppendingFormat:@"%@&device=iPhone&version=3.1.43", self.sortId];
    
    __block typeof(self) aSelf = self;

    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            ScrollModel *scrollModel = [[ScrollModel alloc]init];
            [scrollModel setValuesForKeysWithDictionary:tempDic];
            //判断如果是取出来的“type”是这些，就不取出轮播图了。
            [aSelf.scrollArray addObject:scrollModel];
            if ((4 == scrollModel.thisType)||(7 == scrollModel.thisType)||(5 == scrollModel.thisType)||(8 == scrollModel.thisType)||(6 == scrollModel.thisType)) {
                continue;
            }
            [self.imagesArray addObject:scrollModel.pic];
            [scrollModel release];
        }
        [self addLayer];
        [self.collectionVC reloadData];
    }];
}

#pragma mark --- 视图
-(void)addLayer{
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowlayout.itemSize = CGSizeMake(kWIDTH / 4 + 10, kHEIGHT / 7.5 + 10);
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.minimumLineSpacing = 10;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset = UIEdgeInsetsMake(h + 74 + 10,10,10,10);
    self.collectionVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 48) collectionViewLayout:flowlayout];
    
    //只显示轮播图数量大于3的
    if (3 <= self.imagesArray.count) {
         //创建轮播图视图
         self.autoView = [AutoView imageScrollViewWithFrame:CGRectMake(10, 74, kWIDTH - 20, 172) imageLinkURL:self.imagesArray placeHolderImageName:@"scrollPH.png" pageControlShowStyle:UIPageControlShowStyleCenter];
        [self.collectionVC addSubview:self.autoView];

    } else {
        flowlayout.sectionInset = UIEdgeInsetsMake( 74,10,10,10);
    }
  
    //有导航控制器的时候使用这方法控制轮播图的size不会乱变动。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __block typeof(self) miao = self;
    //图片被点击后的回调方法，点击进入一个页面。
    self.autoView.callBack = ^(NSInteger index, NSString *imageURL){
        //类型为2的时候，跳转到专辑界面
        if (2 == [miao.scrollArray[index] thisType] ) {
            AlbumDetailViewController *albumVC = [[AlbumDetailViewController alloc]init];
            albumVC.albumId = [miao.scrollArray[index] albumId];
            [miao.navigationController pushViewController:albumVC animated:YES];
            [albumVC release];
        }
        //类型为3或者1的时候，跳转到主播界面
        if ((3 == [miao.scrollArray[index] thisType]) || (1 == [self.scrollArray[index] thisType])) {
            AnchorInfoTableViewController *sendView = [[AnchorInfoTableViewController alloc]init];
            sendView.anchorId = [[miao.scrollArray[index] uid]stringValue];
            [miao.navigationController pushViewController:sendView animated:YES];
            [sendView release];
        }
    };
    // 是否使用定时
    self.autoView.isNeedCycleRoll = YES;
    // 计时器定时
    self.autoView.imageMoveTime = 2.0;
    
    self.collectionVC.dataSource = self;
    self.collectionVC.delegate = self;
    self.collectionVC.showsVerticalScrollIndicator = NO;
    [self.collectionVC registerClass:[CustomCell class] forCellWithReuseIdentifier:@"CELL"];
    
    self.collectionVC.backgroundColor = CELLCOLOR;
    [self.view addSubview:self.collectionVC];
    [flowlayout release];
    [_collectionVC release];
}

#pragma ,mark --- 加载cell数据
-(void)reCellData{
    NSString *albumString = [AlbumStr stringByAppendingFormat:@"%@&device=iPhone&type=album", self.sortName];
    [Networking recivedDataWithURLString:albumString method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        
        for (NSDictionary *tempDic in listArray) {
            CellModel *cellModel = [[CellModel alloc]init];
            [cellModel setValuesForKeysWithDictionary:tempDic];
            [self.cellDataArray addObject:cellModel];
            [cellModel release];
        }
        [self.collectionVC reloadData];
    }];
}

#pragma mark --- 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellDataArray.count;
}

#pragma mark --- 重用机制
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    //item上添加图片和文字
    for (int i = 0; i < self.cellDataArray.count; i ++) {
        NSURL *url = [NSURL URLWithString:[self.cellDataArray[indexPath.row] cover_path]];
        [cell.imageView sd_setImageWithURL:url];
        cell.titleLabel.text = [self.cellDataArray[indexPath.row] tname];
    }
    return cell;
}

#pragma mark --- 点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MainAlbumTableViewController *SonVC = [[MainAlbumTableViewController alloc]init];
    SonVC.name = self.sortName;
    SonVC.tagName = [self.cellDataArray[indexPath.row] tname];
    [self.navigationController pushViewController:SonVC animated:YES];
    [SonVC release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
