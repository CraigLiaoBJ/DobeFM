//
//  HotViewController.m
//  
//
//  Created by Craig Liao on 15/7/2.
//
//

#import "HotViewController.h"
#import "HotAnchorTableViewController.h"
#import "SpecialTableViewController.h"
#import "HotVoiceViewController.h"
#import "AnchorInfoTableViewController.h"
#import "SpecialModel.h"
#define CUSTOMCOLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

#define URLSTR @"http://mobile.ximalaya.com/m/super_explore_index2?channel=ios-b1&device=iPhone&includeActivity=true&picVersion=9&scale=3&version=3.1.43"
#import "HotModel.h"
@interface HotViewController ()

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSMutableArray *imageArray;

@property (nonatomic, retain) NSMutableArray *spcialArray;

@property (nonatomic, retain) HotModel *hotModel;

@property (nonatomic, retain) SpecialModel *splModel;

@end

@implementation HotViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    // Do any additional setup after loading the view.
    [self loadNetData];
    //[self addScrollView];
    [self addHotAnchor];
    [self addHotVoice];
//    [self addSpecial];
    [self loadSpecialData];
    
}

#pragma mark --- 添加轮播图
- (void)addScrollView{

//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    //轮播图上图片来源数组
//    NSMutableArray *imagesArray = [NSMutableArray array ];
//    
//    for (HotModel *hotMdl in self.dataArray) {
//        
//        [imagesArray addObject:hotMdl.pic];
//    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"pic" object:nil userInfo:nil];
    
//    NSArray *imagesArray = @[@"http://f.hiphotos.baidu.com/zhidao/pic/item/a08b87d6277f9e2f522ee9e01e30e924b899f33b.jpg", @"http://photos.tuchong.com/300699/f/3882646.jpg", @"http://img4.duitang.com/uploads/item/201301/15/20130115113509_ZfnzA.thumb.600_0.jpeg", @"http://www.ichww.com/uploads/allimg/131127/1-13112G3060Y39.jpg", @"http://pic.baike.soso.com/p/20130528/20130528101014-577571184.jpg", @"http://img05.tooopen.com/images/20150316/tooopen_sy_82590685487.jpg"];
    
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
    [self.view addSubview:autoView];
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
    
    [self.view addSubview:hotAnchor];
    
    [hotAnchor release];
    [anchorLabel release];
    [anchorTap release];

}

#pragma mark --- 最火主播触摸事件
- (void)anchorTap{
    HotAnchorTableViewController *AnchorVC = [[HotAnchorTableViewController alloc]init];
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
    
    [self.view addSubview:hotVoice];
    
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
    
    
    //触摸
    special.userInteractionEnabled = YES;
    UITapGestureRecognizer *specialTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(specialTapAction)];
    [special addGestureRecognizer:specialTap];
    
    [self.view addSubview:special];
    
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

#pragma mark ---  加载轮播图数据
- (void)loadNetData{
    self.imageArray = [NSMutableArray array];
    self.dataArray  = [NSMutableArray array];
    
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:URLSTR method:@"GET" body:nil block:^(id object) {
       
        NSDictionary *dic = (NSDictionary *)object;
        
        NSDictionary *bigDic = dic[@"focusImages"];
        NSArray *listArray = bigDic[@"list"];
        
        for (NSDictionary *tempDic in listArray) {
            
            aSelf.hotModel = [[HotModel alloc]init];
            [aSelf.hotModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.dataArray addObject:aSelf.hotModel];
            [aSelf.imageArray addObject:aSelf.hotModel.pic];
        }
        [self addScrollView];
    }];
    
}

#pragma mark ---  加载专题数据
- (void)loadSpecialData{
    self.spcialArray = [NSMutableArray array];
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:URLSTR method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *splDic = dic[@"latest_special"];
        
        aSelf.splModel = [[SpecialModel alloc]init];
        [aSelf.splModel setValuesForKeysWithDictionary:splDic];
        [aSelf addSpecial];
    }];
}

//- (void)doChange{
//    [self addScrollView];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
