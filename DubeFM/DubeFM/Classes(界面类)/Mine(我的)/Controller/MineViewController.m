//
//  MineViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/15.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "MineViewController.h"

const CGFloat HMTopViewH = 350;

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UIImageView *topView;

@property (nonatomic, retain) NSArray *dataArray;

@end

@implementation MineViewController

- (void)dealloc{
    [_tableView release];
    [_topView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = CELLCOLOR;
    self.navigationController.navigationBarHidden = YES;
       self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, -64, kWIDTH, kHEIGHT + 20) style:UITableViewStylePlain]autorelease];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(HMTopViewH, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = CELLCOLOR;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    UIImageView *topView = [[[UIImageView alloc] init]autorelease];
    topView.image = [UIImage imageNamed:@"dobe"];
    topView.frame = CGRectMake(0, -HMTopViewH, kWIDTH, HMTopViewH - 150);
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:topView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    // 设置内边距(让cell往下移动一段距离)
    self.tableView.contentInset = UIEdgeInsetsMake(HMTopViewH , 0, 0, 0);
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
//    [topView release];
//    [_tableView release];
    
    for (int i = 0; i < 3; i ++) {
        self.dataArray = @[@"清除缓存", @"关于", @"免责声明", @"联系我们", @"版本号 v1.0"];
    }
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (2 == indexPath.row) {
        [self addAlertView];
    }
    if (1 == indexPath.row) {
        [self addAboutView];
    }
    if (3 == indexPath.row) {
        [self addContactView];
    }
    if (0 == indexPath.row) {
        [self performSelector:@selector(addClearView) withObject:nil afterDelay:1.0f];
//        [self addClearView];
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    cell.backgroundColor = CELLCOLOR;
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y + 64;
    if (y < HMTopViewH){
        CGRect frame = self.topView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        self.topView.frame = frame;
    }
}


- (void)addAboutView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"关于DobeFM" message:@"一款充满喜感的FM。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)addAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"免责声明" message:@"该软件仅供学习使用，不得用于任何商业用途。如有侵犯您版权的，请联系我们，我们将在第一时间修改。软件所有资料，版权归提供者所有。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)addContactView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"DobeFM开发者团队" message:@"craigliao@foxmail.com;\n330360233@qq.com;\n985595975@qq.com" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)addClearView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"清除缓存" message:@"缓存已清理" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

@end
