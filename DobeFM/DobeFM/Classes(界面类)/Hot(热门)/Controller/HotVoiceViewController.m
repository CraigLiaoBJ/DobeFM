//
//  HotVoiceTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "HotVoiceViewController.h"
#import "HotVoiceCell.h"
#import "HotVoiceModel.h"
#define URLSTR @"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=daily&device=iPhone&page="

@interface HotVoiceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;

@end

static NSInteger n = 1;

@implementation HotVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arr = [NSMutableArray array];
    [self loadData];
//    for (int i = 0; i < 200; i ++) {
//        int index = arc4random() % 2000;
//        
//        NSString *string = [NSString stringWithFormat:@"%d", index];
//        
//        [self.arr addObject:string];
//    }
    [self addTableView];

    
//    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"最火", @"本周热门"]];
//    segment.frame = CGRectMake(0, 70, self.view.frame.size.width, 40);
//    [segment addTarget:self action:@selector(dunkengClicked:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:segment];
    
}
#pragma mark --- 添加TableView
- (void)addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, kWIDTH, kHEIGHT - 120) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.675 green:0.629 blue:1.000 alpha:1.000];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    [self refreshAndLoad];
    
    [self.tableView registerClass:[HotVoiceCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark --- 加载网络数据
- (void)loadData{
    NSString *string = [URLSTR stringByAppendingFormat:@"%ld&per_page=15&tag_name=", n ++];
    NSLog(@"%@", string);
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:string method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = dic[@"list"];
        for (NSDictionary *tempDic in listArray) {
            HotVoiceModel *voiceModel = [[HotVoiceModel alloc]init];
            [voiceModel setValuesForKeysWithDictionary:tempDic];
            [aSelf.arr addObject:voiceModel];
            NSLog(@"%ld", aSelf.arr.count);
        }
        [aSelf.tableView reloadData];
    }];
}

#pragma mark --- 刷新
- (void)refreshAndLoad{
    __block HotVoiceViewController *weakSelf = self;
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeFooterDefault refreshingBlock:^{
        [weakSelf loadData];
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.defaultFooter endRefreshing];
    }];
    
    
    [self.tableView addRefreshWithRefreshViewType:LORefreshViewTypeHeaderGif refreshingBlock:^{
        NSLog(@"asd");
        [weakSelf.arr removeAllObjects];
        //        [weakSelf loadData];
        
        //        for (int i = 0; i < 20; i++) {
        //            NSString *str = [NSString stringWithFormat:@"%d",100 + arc4random()%100];
        //            [weakSelf.dataArray addObject:str];
        //        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.gifHeader endRefreshing];
    }];
    [self.tableView.gifHeader setGifName:@"demo.gif"];
    
    self.tableView.defaultHeader.refreshLayoutType = LORefreshLayoutTypeTopIndicator;
    self.tableView.defaultFooter.refreshLayoutType = LORefreshLayoutTypeRightIndicator;
}

//- (void)dunkengClicked:(UISegmentedControl *)seg
//{
//    
//    NSInteger index = seg.selectedSegmentIndex;
//    switch (index) {
//        case 0:
//            [self.arr removeAllObjects];
//            for (int i = 0; i < 200; i ++) {
//                int index = arc4random() % 2000;
//                
//                NSString *string = [NSString stringWithFormat:@"%d", index];
//                
//                [self.arr addObject:string];
//            }
//            [self.tableView reloadData];
//            break;
//        case 1:
//            [self.arr removeAllObjects];
//            for (int i = 0; i < 200; i ++) {
//                int index = arc4random() % 2000;
//                
//                NSString *string = [NSString stringWithFormat:@"%d", index];
//                
//                [self.arr addObject:string];
//            }
//            [self.tableView reloadData];
//            break;
//        default:
//            break;
//    }
//}
//

#pragma mark --- 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.voiceModel = self.arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *playerVC = [[UIViewController alloc]init];
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRed:0.857 green:1.000 blue:1.000 alpha:1.000];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
