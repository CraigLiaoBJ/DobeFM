//
//  TabBarViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/15.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "TabBarViewController.h"
#import "DiscoverViewControlerViewController.h"
#import "HotViewController.h"
#import "LoadingViewController.h"
//#import "MineViewController.h"
#import "MineViewController.h"
#import "SingleModel.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //热门界面
    HotViewController *hotVC = [[HotViewController alloc]init];
    [self addOneChildVc:hotVC title:@"热门" imageNamed:@"hot.png" selectedImageName:@"hot-2.png"];

    //发现界面
    DiscoverViewControlerViewController *discoverVC = [[DiscoverViewControlerViewController alloc] init];
    [self addOneChildVc:discoverVC title:@"发现" imageNamed:@"discover.png" selectedImageName:@"discover-2.png"];
    
    //播放
//    [self addOneChildVc:[SingleModel shareSingleModel].playC title:nil imageNamed:@"playaudio" selectedImageName:@"playaudio"];
    
    [self addOneChildVc:[SingleModel shareSingleModel].playC title:@"" imageNamed:@"playergray.png" selectedImageName:@"playerorange.png"];
    
    //下载听界面

    [self addOneChildVc:[SingleModel shareSingleModel].loadingC title:@"下载听" imageNamed:@"download.png" selectedImageName:@"download-2.png"];
    
    //我的 界面
//    ReconmmendAlbumViewController *mineVC = [[ReconmmendAlbumViewController alloc]init];
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self addOneChildVc:mineVC title:@"我的" imageNamed:@"mine.png" selectedImageName:@"mine-2.png"];
 
    [discoverVC release];
    [hotVC release];
    [mineVC release];
}


/**
 *  设置加载tabBar方法
 *
 *  @param childVC           子视图控制器
 *  @param title             名称
 *  @param imageName         tabBarItem图片
 *  @param selectedImageName tabBarItem点击后的图片
 */
- (void)addOneChildVc:(UIViewController *)childVC title:(NSString *)title imageNamed:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //添加名称
    childVC.title = title;
    //tabBarItem图片
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (IOS7){
        //declare the image used as original(no rendering)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
      
    }
    childVC.tabBarItem.selectedImage = selectedImage;
    
    //添加导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVC];
    nav.navigationBar.tintColor = [UIColor orangeColor];
    
    [self addChildViewController:nav];
    
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    [nav release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
