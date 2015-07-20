//
//  AlbumDetailViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "AlbumCell.h"
#import "AvPlayViewController.h"
#import "AlbumIntro.h"
@interface AlbumDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) AlbumIntro *albumView;
@property (nonatomic, retain) UIImageView *functionImageView;
@property (nonatomic, retain) UILabel *introLabel;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *batchDnLabel;
@property (nonatomic, retain) UILabel *relateLabel;

@end

@implementation AlbumDetailViewController

- (void)dealloc{
    [_imageView release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专辑详情";
    self.dataArray = [NSMutableArray array];
    [self addIntroImageView];
    [self addTableView];
}

- (void)addIntroImageView{
    self.albumView = [[AlbumIntro alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.albumView];
    [_albumView release];
}

- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHEIGHT / 3, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor cyanColor];
    UIVisualEffectView *bgdEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.tableView addSubview:bgdEffect];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.functionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    self.functionImageView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = self.functionImageView;
    [self batchButtons];
    [_functionImageView release];
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"CELL"];
    [self.albumView addSubview:self.tableView];
    [_tableView release];
}

- (void)addintroInfo{


    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWIDTH / 4 + 20, 25, kWIDTH / 2, 20)];
    self.titleLabel.text = @"百思不得姐";
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.imageView addSubview:self.titleLabel];
    [_titleLabel release];

    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWIDTH / 4 + 20, 25 + 20 + 5, kWIDTH / 2, 20)];
    self.introLabel.backgroundColor = [UIColor yellowColor];
    self.introLabel.alpha = 0.3;
    self.introLabel.numberOfLines = 0;
    [self.imageView addSubview:self.introLabel];
    [_introLabel release];
    
    UIView *sepView = [[UIView alloc]initWithFrame:CGRectMake(0, kHEIGHT / 4, kWIDTH, 1)];
    sepView.backgroundColor = [UIColor grayColor];
    [self.imageView addSubview:sepView];
    
    UILabel *vVLeft = [[UILabel alloc]initWithFrame:CGRectMake(kWIDTH / 3 - 1, kHEIGHT / 4 + 10, 10, 44)];
    sepView.backgroundColor = [UIColor grayColor];
    [self.imageView addSubview:vVLeft];
    
    UILabel *vVRight = [[UILabel alloc]initWithFrame:CGRectMake(kWIDTH / 3 * 2, kHEIGHT / 4, 1, 44)];
    sepView.backgroundColor = [UIColor grayColor];
    [self.imageView addSubview:vVRight];
    [self batchButtons];
}

- (void)batchButtons{

    
//    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    favoriteBtn.frame = CGRectMake(0, 0, kWIDTH / 3 - 2, 44);
//    [favoriteBtn setImage:[UIImage imageNamed:@"album-favorite.png"] forState:UIControlStateNormal];
//    [favoriteBtn setImage:[UIImage imageNamed:@"album-favorite-2.png"] forState:UIControlStateSelected];
//    [favoriteBtn setImageEdgeInsets:UIEdgeInsetsMake(0, - kWIDTH / 20, 0, 0)];
//    
//    [favoriteBtn setTitle:@"收  藏" forState:UIControlStateNormal];
//    [favoriteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [favoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [favoriteBtn setTitle:@"已收藏" forState:UIControlStateSelected];
//    [favoriteBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//    [favoriteBtn addTarget:self action:@selector(doFavoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.functionImageView addSubview:favoriteBtn];
    
    UIButton *batchDn = [UIButton buttonWithType:UIButtonTypeCustom];
    batchDn.frame = CGRectMake(20, 0, kWIDTH / 3, 44);
    [batchDn setImage:[UIImage imageNamed:@"album-download.png"] forState:UIControlStateNormal];
    [batchDn setImage:[UIImage imageNamed:@"album-download-2.png"] forState:UIControlStateSelected];
    [batchDn setImageEdgeInsets:UIEdgeInsetsMake(0, - kWIDTH / 20, 0, 0)];
    
    [batchDn setTitle:@"批量下载" forState:UIControlStateNormal];
    [batchDn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [batchDn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [batchDn setTitle:@"批量下载" forState:UIControlStateSelected];
    [batchDn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [batchDn addTarget:self action:@selector(doBatchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionImageView addSubview:batchDn];
    
    UIButton *relateDn = [UIButton buttonWithType:UIButtonTypeCustom];
    relateDn.frame = CGRectMake(kWIDTH / 2 + 20, 0, kWIDTH / 3, 44);
    [relateDn setImage:[UIImage imageNamed:@"album-relate.png"] forState:UIControlStateNormal];
    [relateDn setImage:[UIImage imageNamed:@"album-relate-2.png"] forState:UIControlStateSelected];
    [relateDn setImageEdgeInsets:UIEdgeInsetsMake(0, - kWIDTH / 20, 0, 0)];
    
    [relateDn setTitle:@"相关专辑" forState:UIControlStateNormal];
    [relateDn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [relateDn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [relateDn setTitle:@"相关专辑" forState:UIControlStateSelected];
    [relateDn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [relateDn addTarget:self action:@selector(doRelateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionImageView addSubview:relateDn];
}


- (void)doFavoriteBtn:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;
    } else {
        button.selected = YES;
    }
}
- (void)doBatchBtn:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;
    } else {
        button.selected = YES;
    }
}
- (void)doRelateBtn:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;
    } else {
        button.selected = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AvPlayViewController *albumDetail = [[AvPlayViewController alloc]init];
    
    [self.navigationController pushViewController:albumDetail animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
