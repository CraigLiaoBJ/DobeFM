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

@interface DiscoverViewControlerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) NSArray *array;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) UILabel *label;
@end

@implementation DiscoverViewControlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"发现";
//    self.view.backgroundColor = [UIColor whiteColor];
    [self addCollectionView];
    [self loadData];

}

#pragma mark ---  添加collectionView
- (void)addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(kWIDTH / 5.3, kHEIGHT / 8.2);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = cellImageColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[DiscoverCell class] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:self.collectionView];
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

//- (void)addImageView{
//    UIImageView *ImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
//    ImageView.userInteractionEnabled = YES;
//    ImageView.image = nil;
//    [self.view addSubview:ImageView];
//    
//    self.array = @[@"有声小说",@"音乐",@"综艺娱乐",@"相声评书",@"最新资讯",@"情感生活",@"历史人文",@"外语",@"培训讲座",@"百家讲坛",@"广播剧",@"戏剧",@"儿童",@"电台",@"商业财经",@"IT科技",@"健康养生",@"校园",@"汽车",@"旅游",@"电影",@"游戏",@"女人",@"其他",@"段子"];
//    NSInteger temp = 1;
//    for (int i = 0; i < 5; i++) {
//        for (int j = 0; j < 5; j++) {
//            UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(WINWIDTH/6 + j*(WINWIDTH/6) + j*WINWIDTH,WINWIDTH/6 + i*(WINWIDTH/6) + i*WINWIDTH + WINWIDTH,WINWIDTH,WINWIDTH)];
//            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",temp]] forState:UIControlStateNormal];
//            button.tag = 200 + temp;
//            button.imageView.layer.masksToBounds = YES;
//            button.imageView.layer.cornerRadius = 16;
//            [ImageView addSubview:button];
//            [button addTarget:self action:@selector(Button:) forControlEvents:UIControlEventTouchUpInside];
//            
//            self.label = [[UILabel alloc]initWithFrame:CGRectMake(WINWIDTH/6 + j*(WINWIDTH/6) + j*WINWIDTH , WINWIDTH/6 + i*(WINWIDTH/6) + i*WINWIDTH + WINWIDTH*2 , WINWIDTH, WINWIDTH/6)];
//            self.label.font = [UIFont systemFontOfSize:10];
//            self.label.text = self.array[temp - 1];
//            self.label.textAlignment = NSTextAlignmentCenter;
//            temp++;
//            [ImageView addSubview:self.label];
//        }
//    }
//
//}

//- (void)Button:(UIButton *)sender{
//    NSInteger tempTag = sender.tag - 200;
//    ClassViewController *ClassVC = [[ClassViewController alloc]init];
//
//    [self.navigationController pushViewController:ClassVC animated:YES];
//    ClassVC.title = self.array[tempTag-1];
//}

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
    classVC.sortId = [self.dataArray[indexPath.row] categoryId];
    classVC.sortName = [self.dataArray[indexPath.row] name];
    [self.navigationController pushViewController:classVC animated:YES];
    [classVC release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
