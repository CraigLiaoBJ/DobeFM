//
//  HotViewController.m
//  
//
//  Created by Craig Liao on 15/7/2.
//
//

#import "HotViewController.h"
#import "SpecialTableViewController.h"
#import "AnchorInfoTableViewController.h"
#import "MoreAlbumTableViewController.h"
#import "HotAnchorViewController.h"
#import "SpcDetailViewController.h"
#import "AlbumDetailViewController.h"
#import "HotVoiceViewController.h"
#import "HotAlbumCell.h"
#import "SpecialModel.h"
#import "HotAlbumsModel.h"
#import "HotModel.h"
#define CUSTOMCOLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
#define URLSTR @"http://mobile.ximalaya.com/m/super_explore_index2?channel=ios-b1&device=iPhone&includeActivity=true&picVersion=9&scale=3&version=3.1.43"

@interface HotViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSMutableArray *imageArray;

@property (nonatomic, retain) NSMutableArray *spcialArray;

@property (nonatomic, retain) HotModel *hotModel;

@property (nonatomic, retain) SpecialModel *splModel;

@property (nonatomic, retain) UITableView *albumTableView;

@property (nonatomic, retain) NSMutableArray *albumArray;

@property (nonatomic, retain) UIScrollView *wholeScrollView;

@end

@implementation HotViewController

- (void)dealloc{
    [_hotModel release];
    [_splModel release];
    [_albumTableView release];
    [_wholeScrollView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [NSMutableArray array];
    self.dataArray  = [NSMutableArray array];
    self.spcialArray = [NSMutableArray array];
    self.albumArray = [NSMutableArray array];
//    self.hidesBottomBarWhenPushed = YES;

    self.wholeScrollView = [[[UIScrollView alloc]initWithFrame:self.view.bounds]autorelease];
    self.wholeScrollView.contentSize = CGSizeMake(0, 900);
    self.wholeScrollView.pagingEnabled = NO;
    self.wholeScrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.wholeScrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.wholeScrollView];
    [_wholeScrollView release];
    
    self.view.backgroundColor = CELLCOLOR;
    [self loadNetData];
    //[self addScrollView];
    [self addHotAnchor];
    [self addHotVoice];
//    [self addSpecial];
//    [self loadSpecialData];
    [self addRecommendAlbum];
    
}

#pragma mark --- 添加轮播图
- (void)addScrollView{
     //创建轮播图试图
    AutoView *autoView = [AutoView imageScrollViewWithFrame:CGRectMake(10, 74, kWIDTH - 20, 172) imageLinkURL:self.imageArray placeHolderImageName:@"scrollPH.png" pageControlShowStyle:UIPageControlShowStyleCenter];
    //有导航控制器的时候使用这方法控制轮播图的size不会乱变动。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
        __block typeof(self) miao = self;
        //图片被点击后的回调方法，点击进入一个页面。
        autoView.callBack = ^(NSInteger index, NSString *imageURL){
//            for (int i = 0; i < miao.imageArray.count; i ++) {
          
            if (2 == [miao.dataArray[index] typeId]) {
                AlbumDetailViewController *albumVC = [[[AlbumDetailViewController alloc]init]autorelease];
                albumVC.albumId = [miao.dataArray[index] albumId];
                [miao.navigationController pushViewController:albumVC animated:YES];
            }
            if (3 == [miao.dataArray[index] typeId]) {
                AnchorInfoTableViewController *anchorVC = [[[AnchorInfoTableViewController alloc]init]autorelease];
                anchorVC.anchorId = [miao.dataArray[index] uid];
                [miao.navigationController pushViewController:anchorVC animated:YES];
            }
            if (9 == [miao.dataArray[index] typeId]) {
                SpcDetailViewController *spcVC = [[[SpcDetailViewController alloc]init]autorelease];
                spcVC.addID = [miao.dataArray[index] specialId];
                [miao.navigationController pushViewController:spcVC animated:YES];
        }
    };
    // 是否使用定时
    autoView.isNeedCycleRoll = YES;
    // 计时器定时
    autoView.imageMoveTime = 2.0;
    [self.wholeScrollView addSubview:autoView];
}

#pragma  mark --- 添加最火主播
- (void)addHotAnchor{
    UIImageView *hotAnchor = [[UIImageView alloc]initWithFrame:CGRectMake(10, 255, (kWIDTH - 30) / 2 , 100)];
    
    hotAnchor.backgroundColor = [UIColor orangeColor];
    //添加图片
    hotAnchor.image = [UIImage imageNamed:@"hotAnchor.png"];
 
    hotAnchor.userInteractionEnabled = YES;
    /**
     触摸按钮
     */
    UITapGestureRecognizer *anchorTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(anchorTap)];
    [hotAnchor addGestureRecognizer:anchorTap];
    
    [self.wholeScrollView addSubview:hotAnchor];
    
    [hotAnchor release];
    [anchorTap release];
}

#pragma mark --- 最火主播触摸事件
- (void)anchorTap{
    HotAnchorViewController *AnchorVC = [[HotAnchorViewController alloc]init];
    [self.navigationController pushViewController:AnchorVC animated:YES];
    [AnchorVC release];
}

#pragma mark -- 最热声音
- (void)addHotVoice{
    UIImageView *hotVoice = [[UIImageView alloc]initWithFrame:CGRectMake((kWIDTH - 30) / 2 + 20, 255, (kWIDTH - 30) / 2, 100)];
    hotVoice.image = [UIImage imageNamed:@"hotvoice.png"];
    //添加图片
    hotVoice.backgroundColor = [UIColor orangeColor];
    
    //触摸
    hotVoice.userInteractionEnabled = YES;
    UITapGestureRecognizer *hotVoiceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hotVoice)];
    [hotVoice addGestureRecognizer:hotVoiceTap];
    
    [self.wholeScrollView addSubview:hotVoice];
    
    [hotVoice release];
    [hotVoiceTap release];
}

#pragma mark --- 最热声音触摸事件
- (void)hotVoice{
    HotVoiceViewController *hotVoiceVC = [[HotVoiceViewController alloc]init];
    [self.navigationController pushViewController:hotVoiceVC animated:YES];
    [hotVoiceVC release];
}

#pragma mark --- 最热专题
- (void)addSpecial{
    UIImageView *special = [[UIImageView alloc]initWithFrame:CGRectMake(10, 365, kWIDTH - 20, 50)];
    special.backgroundColor = [UIColor whiteColor];
    special.alpha = 0.8;
    //专题标题
    UILabel *specialLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, kWIDTH / 4, 15)];
    specialLabel.textAlignment = NSTextAlignmentLeft;
    specialLabel.font = [UIFont systemFontOfSize:16];
    specialLabel.text = @"专题";
    [special addSubview:specialLabel];
    
    //专题小图片
    UIImageView *splImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    splImage.layer.cornerRadius = 20.f;
    splImage.layer.masksToBounds = YES;
    NSURL *url = [NSURL URLWithString:self.splModel.coverPathSmall];
    [splImage sd_setImageWithURL:url];
    [special addSubview:splImage];
    
    //专题名字
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, kWIDTH / 3 * 2, 20)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = self.splModel.title;
    [special addSubview:titleLabel];
    
    //展开图标
    UIImageView *moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH / 3 * 2.5 + 10, 15, 20, 20)];
    moreImage.image = [UIImage imageNamed:@"hotView-more.png"];
    [special addSubview:moreImage];
    [UIColor colorWithRed:0.897 green:1.000 blue:0.937 alpha:1.000];
    
    //触摸
    special.userInteractionEnabled = YES;
    UITapGestureRecognizer *specialTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(specialTapAction)];
    [special addGestureRecognizer:specialTap];
    
    [self.wholeScrollView addSubview:special];
    
    [special release];
    [specialLabel release];
    [splImage release];
    [titleLabel release];
    [moreImage release];
    [specialTap release];
}

#pragma mark --- 最热专题触摸事件
- (void)specialTapAction{
    SpecialTableViewController *specialVC = [[SpecialTableViewController alloc]init];
    [self.navigationController pushViewController:specialVC animated:YES];
    [specialVC release];
}

#pragma mark ---  加载数据
- (void)loadNetData{
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:URLSTR method:@"GET" body:nil block:^(id object) {
       
        NSDictionary *dic = (NSDictionary *)object;
        //轮播图数据
        NSDictionary *bigDic = dic[@"focusImages"];
        NSArray *listArray = bigDic[@"list"];
        
        for (NSDictionary *tempDic in listArray) {
            aSelf.hotModel = [[[HotModel alloc]init]autorelease];
            [aSelf.hotModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.dataArray addObject:aSelf.hotModel];
            [aSelf.imageArray addObject:aSelf.hotModel.pic];
//            [_hotModel release];
        }
        [self addScrollView];
        
        //专题数据
        NSDictionary *splDic = dic[@"latest_special"];
        
        aSelf.splModel = [[[SpecialModel alloc]init]autorelease];
        [aSelf.splModel setValuesForKeysWithDictionary:splDic];
        [aSelf addSpecial];
        [_splModel release];
        //推荐专辑数据
        NSDictionary *albumDic = dic[@"recommendAlbums"];
        NSArray *abmArray = albumDic[@"list"];
        for (NSDictionary *tempDic in abmArray) {
            HotAlbumsModel *hotAlbumModel = [[HotAlbumsModel alloc]init];
            [hotAlbumModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.albumArray addObject:hotAlbumModel];
            [hotAlbumModel release];
        }
        [aSelf.albumTableView reloadData];
    }];
}

#pragma mark --- 加载推荐专辑
- (void)addRecommendAlbum{
    self.albumTableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 425, kWIDTH, 430) style:UITableViewStylePlain]autorelease];
    self.albumTableView.rowHeight = 50;
    self.albumTableView.dataSource = self;
    self.albumTableView.delegate = self;
    self.albumTableView.userInteractionEnabled = YES;
    [self.wholeScrollView addSubview:self.albumTableView];
    
    UIImageView *imageViw = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 425, kWIDTH, 30)]autorelease];
    imageViw.userInteractionEnabled = YES;
    
    UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(20, 5, kWIDTH / 2, 20)]autorelease];
    label.text = @"推荐专辑";
    label.font = [UIFont boldSystemFontOfSize:15];
    [imageViw addSubview:label];

    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(kWIDTH - 75, 0, 75, 30);

    UILabel * titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(13, 0, 50, 30)]autorelease];
    titleLabel.text = @"更多";
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [moreBtn addSubview:titleLabel];
    
    [moreBtn setImage:[UIImage imageNamed:@"iconfont-gengduo-3.png"] forState:UIControlStateNormal];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    
    [moreBtn addTarget:self action:@selector(didClickmoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [imageViw addSubview:moreBtn];

    self.albumTableView.tableHeaderView = imageViw;
    self.albumTableView.tableFooterView = nil;
    
    [self.albumTableView registerClass:[HotAlbumCell class] forCellReuseIdentifier:@"CELL"];
//    [_albumTableView release];
}

- (void)didClickmoreBtn{
    MoreAlbumTableViewController *moreAlbumVC = [[MoreAlbumTableViewController alloc]init];
    [self.navigationController pushViewController:moreAlbumVC animated:YES];
    [moreAlbumVC release];
}

#pragma mark --- 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.hotAlbumsModel = self.albumArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailViewController *albmDtl = [[[AlbumDetailViewController alloc]init]autorelease];
    albmDtl.albumId = [self.albumArray[indexPath.row]albumId];
    [self.navigationController pushViewController:albmDtl animated:YES];
//    [albmDtl release];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
