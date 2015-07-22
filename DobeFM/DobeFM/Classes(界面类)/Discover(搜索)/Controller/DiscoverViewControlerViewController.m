//
//  DiscoverViewControlerViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/15.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "DiscoverViewControlerViewController.h"
#import "ClassViewController.h"
@interface DiscoverViewControlerViewController ()
@property(nonatomic , retain)NSArray *array;

@property(nonatomic , retain)UILabel *label;
@end

@implementation DiscoverViewControlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UISearchBar *serch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 30, 100, 20)];
    serch.placeholder = @"搜索声音、专辑、人";
    self.navigationItem.titleView = serch;
   

    self.navigationItem.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 300)];
    ImageView.userInteractionEnabled = YES;
    ImageView.image = nil;
    [self.view addSubview:ImageView];
    
        self.array = @[@"有声小说",@"音乐",@"综艺娱乐",@"相声评书",@"最新资讯",@"情感生活",@"历史人文",@"外语",@"培训讲座",@"百家讲坛",@"广播剧",@"戏剧",@"儿童",@"电台",@"商业财经",@"IT科技",@"健康养生",@"校园",@"汽车",@"旅游",@"电影",@"游戏",@"女人",@"其他",@"段子"];
    NSInteger temp = 1;
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(40 * j + 30 * (j + 1), 40 * i + 15 * (i + 1), 40, 40)];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",temp]] forState:UIControlStateNormal];
            button.tag = 200 + temp;
            button.imageView.layer.masksToBounds = YES;
            button.imageView.layer.cornerRadius = 20;
            [ImageView addSubview:button];
            [button addTarget:self action:@selector(Button:) forControlEvents:UIControlEventTouchUpInside];
            
            self.label = [[UILabel alloc]initWithFrame:CGRectMake(30 + 40 * j +  30 * j , 40 + 55 * i + 15, 40, 10)];
            self.label.font = [UIFont systemFontOfSize:10];
            self.label.text = self.array[temp - 1];
            self.label.textAlignment = NSTextAlignmentCenter;
            temp++;
            [ImageView addSubview:self.label];
          
        }
    }
}

-(void)Button:(UIButton *)sender{
    NSInteger tempTag = sender.tag - 200;
    ClassViewController *ClassVC = [[ClassViewController alloc]init];
    switch (tempTag ) {
        case 1:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 2:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 3:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 4:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 5:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 6:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 7:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 8:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 9:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 10:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 11:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 12:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 13:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 14:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 15:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 16:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 17:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 18:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 19:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 20:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 21:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 22:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 23:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 24:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
        case 25:
            [self.navigationController pushViewController:ClassVC animated:YES];
            ClassVC.title = self.array[tempTag-1];
            break;
            
        default:
            break;
    }
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
