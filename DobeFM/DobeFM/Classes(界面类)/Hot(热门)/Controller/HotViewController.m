//
//  HotViewController.m
//  
//
//  Created by Craig Liao on 15/7/2.
//
//

#import "HotViewController.h"
#import "SpecialTableViewController.h"
#import "HotVoiceViewController.h"
#import "AnchorInfoTableViewController.h"
#import "SpecialModel.h"
#import "AlbumDetailViewController.h"
#import "HotAlbumCell.h"
#import "HotAlbumsModel.h"
#import "AlbumDetailViewController.h"
#import "MoreAlbumTableViewController.h"
#import "HotAnchorViewController.h"
#define CUSTOMCOLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

#define URLSTR @"http://mobile.ximalaya.com/m/super_explore_index2?channel=ios-b1&device=iPhone&includeActivity=true&picVersion=9&scale=3&version=3.1.43"
#import "HotModel.h"
@interface HotViewController ()<UITableViewDataSource, UITableViewDelegate>

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

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    self.wholeScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.wholeScrollView.contentSize = CGSizeMake(0, kHEIGHT * 1.5);
    self.wholeScrollView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.wholeScrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.wholeScrollView];
    self.view.backgroundColor = [UIColor colorWithRed:0.935 green:0.987 blue:1.000 alpha:1.000];
    // Do any additional setup after loading the view.
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
            AnchorInfoTableViewController *sendView = [[AnchorInfoTableViewController alloc]init];
            sendView.view.backgroundColor = [UIColor cyanColor];
            [miao.navigationController pushViewController:sendView animated:YES];
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
    /**
     占位文字
     */
    UILabel *anchorLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 40, 150, 20)];
    anchorLabel.text = @"Hot Anchor";
    anchorLabel.textColor = [UIColor purpleColor];
    anchorLabel.textAlignment = NSTextAlignmentCenter;
    [hotAnchor addSubview:anchorLabel];
    hotAnchor.userInteractionEnabled = YES;
    /**
     触摸按钮
     */
    UITapGestureRecognizer *anchorTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(anchorTap)];
    [hotAnchor addGestureRecognizer:anchorTap];
    
    [self.wholeScrollView addSubview:hotAnchor];
    
    [hotAnchor release];
    [anchorLabel release];
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
    hotVoice.backgroundColor = [UIColor orangeColor];
    //占位文字
    UILabel *hotVoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 40, 150, 20)];
    hotVoiceLabel.text = @"Hot Voice";
    hotVoiceLabel.textColor = [UIColor purpleColor];
    hotVoiceLabel.textAlignment = NSTextAlignmentCenter;
    [hotVoice addSubview:hotVoiceLabel];
    
    //触摸
    hotVoice.userInteractionEnabled = YES;
    UITapGestureRecognizer *hotVoiceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hotVoice)];
    [hotVoice addGestureRecognizer:hotVoiceTap];
    
    [self.wholeScrollView addSubview:hotVoice];
    
    [hotVoice release];
    [hotVoiceLabel release];
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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, kWIDTH / 3, 20)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = self.splModel.title;
    [special addSubview:titleLabel];
    
    //展开图标
    UIImageView *moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH / 4 * 3, 12.5, 25, 25)];
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
    self.imageArray = [NSMutableArray array];
    self.dataArray  = [NSMutableArray array];
    self.spcialArray = [NSMutableArray array];
    self.albumArray = [NSMutableArray array];

    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:URLSTR method:@"GET" body:nil block:^(id object) {
       
        NSDictionary *dic = (NSDictionary *)object;
        //轮播图数据
        NSDictionary *bigDic = dic[@"focusImages"];
        NSArray *listArray = bigDic[@"list"];
        
        for (NSDictionary *tempDic in listArray) {
            
            aSelf.hotModel = [[HotModel alloc]init];
            [aSelf.hotModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.dataArray addObject:aSelf.hotModel];
            [aSelf.imageArray addObject:aSelf.hotModel.pic];
        }
        [self addScrollView];
        
        //专题数据
        NSDictionary *splDic = dic[@"latest_special"];
        
        aSelf.splModel = [[SpecialModel alloc]init];
        [aSelf.splModel setValuesForKeysWithDictionary:splDic];
        [aSelf addSpecial];
        
        //推荐专辑数据
        NSDictionary *albumDic = dic[@"recommendAlbums"];
        NSArray *abmArray = albumDic[@"list"];
        for (NSDictionary *tempDic in abmArray) {
            HotAlbumsModel *hotAlbumModel = [[HotAlbumsModel alloc]init];
            [hotAlbumModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.albumArray addObject:hotAlbumModel];
        }
        [aSelf.albumTableView reloadData];
        
    }];
}

#pragma mark ---  加载专题数据
//- (void)loadSpecialData{
//    self.spcialArray = [NSMutableArray array];
//    __block typeof (self) aSelf = self;
//    [Networking recivedDataWithURLString:URLSTR method:@"GET" body:nil block:^(id object) {
//        
//    }];
//}

#pragma mark --- 加载推荐专辑
- (void)addRecommendAlbum{
    self.albumTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 425, kWIDTH, 450) style:UITableViewStylePlain];
    self.albumTableView.rowHeight = 50;
    self.albumTableView.dataSource = self;
    self.albumTableView.delegate = self;
    self.albumTableView.userInteractionEnabled = YES;
    [self.wholeScrollView addSubview:self.albumTableView];
    
    UIImageView *imageViw = [[UIImageView alloc]initWithFrame:CGRectMake(0, 425, kWIDTH, 30)];
    imageViw.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, kWIDTH / 2, 20)];
    label.text = @"推荐专辑";
    label.font = [UIFont boldSystemFontOfSize:15];
    [imageViw addSubview:label];

    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(kWIDTH - 75, 0, 75, 30);

    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, 50, 30)];
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
}

- (void)didClickmoreBtn{
    MoreAlbumTableViewController *moreAlbumVC = [[MoreAlbumTableViewController alloc]init];
    [self.navigationController pushViewController:moreAlbumVC animated:YES];
}
#pragma mark --- 代理方法


/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.hotAlbumsModel = self.albumArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailViewController *albmDtl = [[AlbumDetailViewController alloc]init];
    albmDtl.albumId = [self.albumArray[indexPath.row]albumId];
    [self.navigationController pushViewController:albmDtl animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
