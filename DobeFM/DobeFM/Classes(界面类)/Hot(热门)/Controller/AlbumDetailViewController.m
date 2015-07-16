//
//  AlbumDetailViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/5.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "AlbumCell.h"
@interface AlbumDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImageView *introCoverImage;
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
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT / 4 + 44)];
    self.imageView.backgroundColor = [UIColor orangeColor];
    
    [self.tableView addSubview:self.imageView];
    [self addintroInfo];
    [_imageView release];
}

- (void)addintroInfo{
    self.introCoverImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, kWIDTH / 4, kWIDTH / 4)];
    self.introCoverImage.backgroundColor = [UIColor lightGrayColor];
    [self.imageView addSubview:self.introCoverImage];
    [_introCoverImage release];

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
    
//    UIView *vVLeft = [[UIView alloc]initWithFrame:CGRectMake(30, kHEIGHT / 4 + 10, 10, 44)];
//    sepView.backgroundColor = [UIColor grayColor];
//    [self.imageView addSubview:vVLeft];
//    
//    UIView *vVRight = [[UIView alloc]initWithFrame:CGRectMake(kWIDTH / 3 * 2, kHEIGHT / 4, 1, 44)];
//    sepView.backgroundColor = [UIColor grayColor];
//    [self.imageView addSubview:vVRight];
//
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(0, kHEIGHT / 4, kWIDTH / 3, 44);
    [favoriteBtn setImage:[UIImage imageNamed:@"album-favorite.png"] forState:UIControlStateNormal];
    [favoriteBtn setImageEdgeInsets:UIEdgeInsetsMake(0, - kWIDTH / 6, 0, 30)];
    
    UILabel *favoriteLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 12, kWIDTH / 3, 20)];
    favoriteLabel.text = @"收藏";
    [favoriteBtn addSubview:favoriteLabel];
    [self.imageView addSubview:favoriteBtn];
    
    UIButton *batchDn = [UIButton buttonWithType:UIButtonTypeCustom];
    batchDn.frame = CGRectMake(kWIDTH / 3, kHEIGHT / 4, kWIDTH / 3, 44);
    [batchDn setImage:[UIImage imageNamed:@"album-download.png"] forState:UIControlStateNormal];
    [batchDn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UILabel *batchDnLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kWIDTH / 3, 20)];
    batchDnLbl.text = @"批量下载";
    [batchDn addSubview:batchDnLbl];
    [self.imageView addSubview:batchDn];
    
    UIButton *relateDn = [UIButton buttonWithType:UIButtonTypeCustom];
    relateDn.frame = CGRectMake(kWIDTH / 3 * 2, kHEIGHT / 4, kWIDTH / 3, 44);
    [relateDn setImage:[UIImage imageNamed:@"album-relate.png"] forState:UIControlStateNormal];
    [relateDn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    
    UILabel *relateDnLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kWIDTH / 3, 20)];
    relateDnLbl.text = @"相关专辑";
    [relateDn addSubview:relateDnLbl];
    [self.imageView addSubview:relateDn];
    
}
- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.tableHeaderView = self.imageView;
    
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"CELL"];
    [self.view addSubview:self.tableView];
    [_tableView release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumDetailViewController *albumDetail = [[AlbumDetailViewController alloc]init];
    
    [self.navigationController pushViewController:albumDetail animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
