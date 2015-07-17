//
//  NewAlbumListViewController.m
//  DobeFM
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "NewAlbumListViewController.h"
#import "NewAlbumCell.h"
@interface NewAlbumListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;

@end

@implementation NewAlbumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr = [NSMutableArray array];
    
    for (int i = 0; i < 200; i ++) {
        int index = arc4random() % 2000;
        
        NSString *string = [NSString stringWithFormat:@"%d", index];
        
        [self.arr addObject:string];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 90) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 160;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.675 green:0.629 blue:1.000 alpha:1.000];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[NewAlbumCell class] forCellReuseIdentifier:@"CELL"];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"最火", @"最近更新", @"经典"]];
    segment.frame = CGRectMake(0, 70, kWIDTH, 40);
    [segment addTarget:self action:@selector(dunkengClicked:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    
}

- (void)dunkengClicked:(UISegmentedControl *)seg
{
    
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self.arr removeAllObjects];
            for (int i = 0; i < 200; i ++) {
                int index = arc4random() % 2000;
                
                NSString *string = [NSString stringWithFormat:@"%d", index];
                
                [self.arr addObject:string];
            }
            [self.tableView reloadData];
            break;
        case 1:
            [self.arr removeAllObjects];
            for (int i = 0; i < 200; i ++) {
                int index = arc4random() % 2000;
                
                NSString *string = [NSString stringWithFormat:@"%d", index];
                
                [self.arr addObject:string];
            }
            [self.tableView reloadData];
            break;
        case 2:
            [self.arr removeAllObjects];
            for (int i = 0; i < 200; i ++) {
                int index = arc4random() % 2000;
                
                NSString *string = [NSString stringWithFormat:@"%d", index];
                
                [self.arr addObject:string];
            }
            [self.tableView reloadData];
            break;

        default:
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *playerVC = [[UIViewController alloc]init];
    [self presentViewController:playerVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

