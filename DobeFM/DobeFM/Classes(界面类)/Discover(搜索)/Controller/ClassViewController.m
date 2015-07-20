//
//  ClassViewController.m
//  DobeFM
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "ClassViewController.h"
#import "AnchorInfoTableViewController.h"

@interface ClassViewController ()

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //轮播图上图片来源数组
    NSArray *imagesArray = @[@"http://f.hiphotos.baidu.com/zhidao/pic/item/a08b87d6277f9e2f522ee9e01e30e924b899f33b.jpg", @"http://photos.tuchong.com/300699/f/3882646.jpg", @"http://img4.duitang.com/uploads/item/201301/15/20130115113509_ZfnzA.thumb.600_0.jpeg", @"http://www.ichww.com/uploads/allimg/131127/1-13112G3060Y39.jpg", @"http://pic.baike.soso.com/p/20130528/20130528101014-577571184.jpg", @"http://img05.tooopen.com/images/20150316/tooopen_sy_82590685487.jpg"];
    
    //创建轮播图试图
    AutoView *autoView = [AutoView imageScrollViewWithFrame:CGRectMake(10, 74, kWIDTH - 20, 172) imageLinkURL:imagesArray placeHolderImageName:@"scrollPH.png" pageControlShowStyle:UIPageControlShowStyleCenter];
    //有导航控制器的时候使用这方法控制轮播图的size不会乱变动。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __block typeof(self) miao = self;
    //图片被点击后的回调方法，点击进入一个页面。
    autoView.callBack = ^(NSInteger index, NSString *imageURL){
        AnchorInfoTableViewController *sendView = [[AnchorInfoTableViewController alloc]init];
        sendView.view.backgroundColor = [UIColor cyanColor];
        [miao.navigationController pushViewController:sendView animated:YES];
        NSLog(@"被点中图片的索引：%ld ---- 地址：%@", index, imageURL);
    };
    // 是否使用定时
    autoView.isNeedCycleRoll = YES;
    // 计时器定时
    autoView.imageMoveTime = 2.0;
    [self.view addSubview:autoView];
    
    
    
    
    
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
