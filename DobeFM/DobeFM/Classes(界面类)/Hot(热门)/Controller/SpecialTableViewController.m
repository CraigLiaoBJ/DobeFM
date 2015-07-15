//
//  SpecialTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/2.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "SpecialTableViewController.h"
#import "SpecialCell.h"
#import "SpcDetailTableViewController.h"
#import "SpecialItem.h"

@interface SpecialTableViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray *dataArray;

@end

@implementation SpecialTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"专题";
    [self addTableView];
    [self loadData];
}

#pragma mark --- addTableView
- (void)addTableView{
    self.tableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 170;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.tableView release];
}

- (void)loadData{
    self.dataArray = [NSMutableArray array];
    __block typeof (self) aSelf = self;
    [Networking recivedDataWithURLString:@"http://mobile.ximalaya.com/m/subject_list?device=iPhone&page=1&per_page=10" method:@"GET" body:nil block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *listArray = [dic valueForKey:@"list"];
        for (NSDictionary *tempDic in listArray) {
            SpecialItem *specialItem = [SpecialItem specialCoverBig:[tempDic valueForKey:@"coverPathBig"] releaseAt:[tempDic valueForKey:@"releasedAt"] spcialID:[tempDic valueForKey:@"specialId"] subTitle:[tempDic valueForKey:@"subtitle"] titleString:[tempDic valueForKey:@"title"] hot:[tempDic valueForKey:@"isHot"]];
            [aSelf.dataArray addObject: specialItem];
            NSLog(@"111%ld" , aSelf.dataArray.count);
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.spcItem = self.dataArray[indexPath.row];
//    SpecialItem *item = self.dataArray[indexPath.row];
    
    NSLog(@"%i", cell.spcItem.hot);
    if (cell.spcItem.hot == true) {
        cell.hotImage.image = [UIImage imageNamed:@"iconfont-remenbiaoqian.png"];
    } else {
        cell.hotImage = nil;
    }
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    self.view = self
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpcDetailTableViewController *spcDetail = [[SpcDetailTableViewController alloc]init];
    
    [self.navigationController pushViewController:spcDetail animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
