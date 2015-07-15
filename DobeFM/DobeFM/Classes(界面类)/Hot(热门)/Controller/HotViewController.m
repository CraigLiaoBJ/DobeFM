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
#import "HotVoiceTableViewController.h"
#define CUSTOMCOLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
@interface HotViewController ()

@end

@implementation HotViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addScrollView];
    [self addHotAnchor];
    [self addHotVoice];
    [self addSpecial];
    

}

/**
 *  添加轮播图
 */
- (void)addScrollView{

    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    NSArray *imagesArray = @[@"http://f.hiphotos.baidu.com/zhidao/pic/item/a08b87d6277f9e2f522ee9e01e30e924b899f33b.jpg", @"http://photos.tuchong.com/300699/f/3882646.jpg", @"http://img4.duitang.com/uploads/item/201301/15/20130115113509_ZfnzA.thumb.600_0.jpeg", @"http://www.ichww.com/uploads/allimg/131127/1-13112G3060Y39.jpg", @"http://pic.baike.soso.com/p/20130528/20130528101014-577571184.jpg", @"http://img05.tooopen.com/images/20150316/tooopen_sy_82590685487.jpg"];
    
    AutoView *autoView = [AutoView imageScrollViewWithFrame:CGRectMake(10, 150, width - 20, 172) imageLinkURL:imagesArray placeHolderImageName:nil pageControlShowStyle:UIPageControlShowStyleCenter];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
        __block typeof(self) miao = self;
    
        //图片被点击后的回调方法
        autoView.callBack = ^(NSInteger index, NSString *imageURL){
            UIViewController *sendView = [[UIViewController alloc]init];
            sendView.view.backgroundColor = [UIColor cyanColor];
            [miao presentViewController:sendView animated:YES completion:nil];
            NSLog(@"被点中图片的索引：%ld ---- 地址：%@", index, imageURL);
        };

    autoView.isNeedCycleRoll = YES;
    autoView.imageMoveTime = 2.0;
    [self.view addSubview:autoView];
    
}
/**
 *  添加最火主播
 */
- (void)addHotAnchor{
    UIImageView *hotAnchor = [[UIImageView alloc]initWithFrame:CGRectMake(10, 330, 172.5, 100)];
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
/**
 *  最火主播触摸事件
 */
- (void)anchorTap{
    HotAnchorTableViewController *AnchorVC = [[HotAnchorTableViewController alloc]init];
    [self.navigationController pushViewController:AnchorVC animated:YES];
    [AnchorVC release];
}

/**
 *  添加最热声音
 */
- (void)addHotVoice{
    UIImageView *hotVoice = [[UIImageView alloc]initWithFrame:CGRectMake(192.5, 330, 172.5 , 100)];
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

//触摸事件
- (void)hotVoice{
    HotVoiceTableViewController *hotVoiceVC = [[HotVoiceTableViewController alloc]init];
    [self.navigationController pushViewController:hotVoiceVC animated:YES];
    [hotVoiceVC release];
}

/**
 *  添加专题
 */
- (void)addSpecial{
    UIImageView *special = [[UIImageView alloc]initWithFrame:CGRectMake(10, 440, 355, 50)];
    special.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *specialLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 200, 20)];
    specialLabel.textAlignment = NSTextAlignmentCenter;
    specialLabel.text = @"专题";
    [special addSubview:specialLabel];
    
    //触摸
    special.userInteractionEnabled = YES;
    UITapGestureRecognizer *specialTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(specialTapAction)];
    [special addGestureRecognizer:specialTap];
    
    [self.view addSubview:special];
    
    [special release];
    [specialLabel release];
    [specialTap release];
}

//专题触摸事件
- (void)specialTapAction{
    SpecialTableViewController *specialVC = [[SpecialTableViewController alloc]init];
    [self.navigationController pushViewController:specialVC animated:YES];
    [specialVC release];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
