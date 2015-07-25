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
#import "AnchorInfoTableViewController.h"
#import "CellModel.h"
#import "MainAlbumTableViewController.h"
#define URLSTR @"http://mobile.ximalaya.com/m/category_focus_image?categoryId="
#define AlbumStr @"http://mobile.ximalaya.com/m/category_tag_list?category="

@interface ClassViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    AutoView *autoView;
    
}
@property (nonatomic, retain) NSMutableArray *scrollArray;
//@property (nonatomic, retain) NSMutableArray *cellImageArray;
@property (nonatomic, retain) NSMutableArray *cellDataArray;

@end
@interface ClassViewController ()

@end
static NSMutableArray *imagesArray;
static NSMutableArray *image;
static UICollectionView *CollectionVC;
static NSInteger h = 172;
@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollArray = [NSMutableArray array];
//    self.imagesArray = [NSMutableArray array];
    self.cellDataArray = [NSMutableArray array];
//    self.cellImageArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor brownColor];
    imagesArray = [[NSMutableArray alloc]init];
    image = [[NSMutableArray alloc]init];
    
    //轮播图上图片来源数组
    
    [self reData];
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
            
            [aSelf.scrollArray addObject:scrollModel];
            if ((4 == scrollModel.thisType)||(7 == scrollModel.thisType)||(5 == scrollModel.thisType)||(8 == scrollModel.thisType)||(6 == scrollModel.thisType)) {
                continue;
            }
            [imagesArray addObject:scrollModel.pic];
        }
        [self addLayer];

        [CollectionVC reloadData];
    }];
}

//- (void)reLayout{
//    if (imagesArray.count < 1) {
//        autoView.frame = CGRectMake(0, 0, 0, 0);
//        h = 0;
//        [CollectionVC reloadData];
//    } else{
//        h = 172;
//         [CollectionVC reloadData];;
//    }
//    
//}
#pragma mark --- 视图
-(void)addLayer{
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowlayout.itemSize = CGSizeMake(kWIDTH / 4, 80);
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.minimumLineSpacing = 10;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset = UIEdgeInsetsMake(h + 74 + 10,10,10,10);
    CollectionVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 48) collectionViewLayout:flowlayout];
    
    if (3 <= imagesArray.count) {

         //创建轮播图试图
         autoView = [AutoView imageScrollViewWithFrame:CGRectMake(10, 74, kWIDTH - 20, 172) imageLinkURL:imagesArray placeHolderImageName:@"scrollPH.png" pageControlShowStyle:UIPageControlShowStyleCenter];
        [CollectionVC addSubview:autoView];

    } else {
        flowlayout.sectionInset = UIEdgeInsetsMake( 74,10,10,10);
    }
  
    //有导航控制器的时候使用这方法控制轮播图的size不会乱变动。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __block typeof(self) miao = self;
    //图片被点击后的回调方法，点击进入一个页面。
    autoView.callBack = ^(NSInteger index, NSString *imageURL){
        
        if (2 == [miao.scrollArray[index] thisType] ) {
            AlbumDetailViewController *albumVC = [[AlbumDetailViewController alloc]init];
            albumVC.albumId = [miao.scrollArray[index] albumId];
            [miao.navigationController pushViewController:albumVC animated:YES];
        }


        if ((3 == [miao.scrollArray[index] thisType]) || (1 == [self.scrollArray[index] thisType])) {
            AnchorInfoTableViewController *sendView = [[AnchorInfoTableViewController alloc]init];
            sendView.anchorId = [[miao.scrollArray[index] uid]stringValue];
            [miao.navigationController pushViewController:sendView animated:YES];
        }
        
      
    };
    // 是否使用定时
    autoView.isNeedCycleRoll = YES;
    // 计时器定时
    autoView.imageMoveTime = 2.0;
      
    
    CollectionVC.dataSource = self;
    CollectionVC.delegate = self;
    CollectionVC.showsVerticalScrollIndicator = NO;
    [CollectionVC registerClass:[CustomCell class] forCellWithReuseIdentifier:@"CELL"];
    
    CollectionVC.backgroundColor = CELLCOLOR;
//    CollectionVC.backgroundColor = [UIColor clearColor];
    [self.view addSubview:CollectionVC];
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
        }
        [CollectionVC reloadData];
//        [self reLayout];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
