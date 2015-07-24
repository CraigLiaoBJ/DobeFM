//
//  ClassViewController.m
//  DobeFM
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//
#define Width (self.view.frame.size.width/4)
#import "ClassViewController.h"
#import "CustomCell.h"
#import "MoreViewController.h"
#import "Networking.h"
@interface ClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
static NSMutableArray *imagesArray;
static NSMutableArray *image;
static UICollectionView *CollectionVC;
@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    imagesArray = [[NSMutableArray alloc]init];
    image = [[NSMutableArray alloc]init];
    
    //轮播图上图片来源数组
    
    [self reData];
    [self reCellData];
   
  
}
- (void)reData{
    [Networking recivedDataWithURLString:@"http://mobile.ximalaya.com/m/category_focus_image?categoryId=3&device=iPhone&version=3.1.43"method:@"GET" body:nil block:^(id object) {
        for (NSDictionary *arr in object[@"list"]) {
            [imagesArray addObject:arr[@"pic"]];
        }
        [self addLayer];
    }];
}

-(void)addLayer{
    
    //创建轮播图试图
    AutoView *autoView = [AutoView imageScrollViewWithFrame:CGRectMake(10, 74, kWIDTH - 20, 172) imageLinkURL:imagesArray placeHolderImageName:nil pageControlShowStyle:UIPageControlShowStyleCenter];
    //有导航控制器的时候使用这方法控制轮播图的size不会乱变动。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __block typeof(self) miao = self;
    //图片被点击后的回调方法，点击进入一个页面。
    autoView.callBack = ^(NSInteger index, NSString *imageURL){
        UIViewController *sendView = [[UIViewController alloc]init];
        sendView.view.backgroundColor = [UIColor cyanColor];
        [miao.navigationController pushViewController:sendView animated:YES];
        NSLog(@"被点中图片的索引：%ld ---- 地址：%@", index, imageURL);
    };
    // 是否使用定时
    autoView.isNeedCycleRoll = YES;
    // 计时器定时
    autoView.imageMoveTime = 2.0;
    
    
  
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
  
    flowlayout.itemSize = CGSizeMake(Width, 80);
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.minimumLineSpacing = 10;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset = UIEdgeInsetsMake(172 + 74 + 10,10,10,10);
    CollectionVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 48) collectionViewLayout:flowlayout];
    CollectionVC.dataSource = self;
    CollectionVC.delegate = self;
    [CollectionVC registerClass:[CustomCell class] forCellWithReuseIdentifier:@"CELL"];
    CollectionVC.backgroundColor = [UIColor clearColor];
    [self.view addSubview:CollectionVC];
    [CollectionVC addSubview:autoView];
}

-(void)reCellData{
    [Networking recivedDataWithURLString:@"http://mobile.ximalaya.com/m/category_tag_list?category=book&device=iPhone&type=album"method:@"GET" body:nil block:^(id object) {
        for (NSArray *arr in object[@"list"]) {
        [image addObject:arr];
        }
        [CollectionVC reloadData];
    }];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return image.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image[indexPath.row][@"cover_path"]]];
    cell.imageView.image = [UIImage imageWithData:data];

    cell.titilelabel.text = image[indexPath.row][@"tname"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreViewController *SonVC = [[MoreViewController alloc]init];
    [self.navigationController pushViewController:SonVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
