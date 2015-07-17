//
//  SpcDetailTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/4.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpcDetailTableViewController.h"
#import "SpcDetailCell.h"
#import "AlbumDetailViewController.h"
@interface SpcDetailTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImageView *introCoverImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *introLabel;
@property (nonatomic, retain) UILabel *nickNameLabel;
@property (nonatomic, retain) UIImageView *icon;

@end

@implementation SpcDetailTableViewController

- (void)dealloc{
    [_imageView release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题详情";
    self.dataArray = [NSMutableArray array];
    [self addIntroImageView];
    [self addTableView];
}

- (void)addIntroImageView{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 250)];
    self.imageView.backgroundColor = [UIColor orangeColor];
    
    [self.tableView addSubview:self.imageView];
    [self addintroInfo];
    [_imageView release];
}


- (void)addintroInfo{
    self.introCoverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
    self.introCoverImage.backgroundColor = [UIColor lightGrayColor];
    [self.imageView addSubview:self.introCoverImage];
    [_introCoverImage release];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, 20)];
    self.titleLabel.text = @"这是标题占位符";
//    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.imageView addSubview:self.titleLabel];
    [_titleLabel release];
    
    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 165, self.view.frame.size.width, self.view.frame.size.height - 465)];
    self.introLabel.backgroundColor = [UIColor yellowColor];
    self.introLabel.alpha = 0.3;
    [self.imageView addSubview:self.introLabel];
    [_introLabel release];
    
    UILabel *specialLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, self.view.frame.size.height - 465 + 175, 100, 30)];
    specialLabel.text = @"专题小编";
    specialLabel.font = [UIFont systemFontOfSize:13];
    [self.imageView addSubview:specialLabel];
    [specialLabel release];
    
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(220, self.view.frame.size.height - 465 + 175 , 40 , 30)];
    self.icon.backgroundColor = [UIColor grayColor];
    self.icon.layer.cornerRadius = 15.f;
    self.icon.layer.masksToBounds = YES;
    [self.imageView addSubview:self.icon];
    [_icon release];
    
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, self.view.frame.size.height - 465 + 175 , 100, 30)];
    self.nickNameLabel.text = @"!!!!!!!!!";
    self.nickNameLabel.font = [UIFont systemFontOfSize: 13];
    [self.imageView addSubview:self.nickNameLabel];
    [_nickNameLabel release];
        
}
- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.tableHeaderView = self.imageView;
    
    [self.tableView registerClass:[SpcDetailCell class] forCellReuseIdentifier:@"CELL"];
    [self.view addSubview:self.tableView];
    [_tableView release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpcDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
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
