//
//  LoadingViewController.m
//  Xmly
//
//  Created by DobeFM on 15/7/8.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "LoadingViewController.h"
#import "LoadedCell.h"
#import "LoadingCell.h"
#import "LoadDownBase.h"
#import "SingleModel.h"
#import "AlbumList.h"

@interface LoadingViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableDictionary *dicLoad;//下载完成

@property (nonatomic, strong) NSMutableDictionary *dicLoading;//下载中数据

@property (nonatomic, strong) UIView *btnView;//控制器

@end


@implementation LoadingViewController
 enum loadState{
    Loading ,
    Loaded
};

static UILabel *unDataView;//没数据 lable显示

static UIButton *loadedBtn;//下载完成 按钮

static UIButton *loadingBtn;//下载中 按钮

static UIView *btnChoolView;//选中被这层盖住

static int  currentView = Loading;

static LoadDownBase *loadDownBase;//下载基类

static NSMutableArray *saveLoading;//保存下载数据

static  UISegmentedControl *segmentedControl;

static int currentLoad = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CELLCOLOR;
    self.isLoading = NO;
    self.title = @"下载";
    saveLoading = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    loadDownBase = [[LoadDownBase alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dicLoad = [self getSplistList:@"LoadDownList"];
    self.dicLoading = [self getSplistList:@"BeLoadList"];
    
    for (NSString *allkey in self.dicLoading) {
        SaveLodingDate *aSave = [[SaveLodingDate alloc]init];
        aSave.traintId = self.dicLoading[allkey][5];
        aSave.stringUrl = [self stringAlbum:[loadDownBase arrayToAlbumList:self.dicLoading[allkey]]];
        [saveLoading addObject:aSave];
    }
    
    //下载完成view
    self.loadedTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT - 74 - 39)];
    self.loadedTableView.rowHeight = 60;
    self.loadedTableView.delegate = self;
    self.loadedTableView.dataSource = self;
    [self.loadedTableView registerClass:[LoadedCell class] forCellReuseIdentifier:@"DCELL"];
    self.loadedTableView.hidden = YES;
    self.loadedTableView.tag = 1001;
    self.loadedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.loadedTableView.backgroundColor = CELLCOLOR;
    self.loadedTableView.tableFooterView = [[UIView alloc]init];
    self.loadedTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.loadedTableView];

    //下载中view
    self.loadingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,  kWIDTH, kHEIGHT - 74 - 39)];
    self.loadingTableView.rowHeight = 70;
    self.loadingTableView.backgroundColor = CELLCOLOR;
    self.loadingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.loadingTableView.delegate = self;
    self.loadingTableView.dataSource = self;
    [self.loadingTableView registerClass:[LoadingCell class] forCellReuseIdentifier:@"DINGCELL"];
    self.loadingTableView.tag = 1002;
    self.loadingTableView.tableFooterView = [[UIView alloc]init];
    self.loadingTableView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:self.loadingTableView];
    
    //导航栏上的分段控制器
    segmentedControl=[[UISegmentedControl alloc] initWithItems:@[@"下载中", @"已下载"]];
    segmentedControl.frame = CGRectMake(0, 0, kWIDTH, 40);

    [segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 0;
    [self.navigationController.navigationBar.topItem setTitleView:segmentedControl];
    
    segmentedControl.tintColor = [UIColor orangeColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName:[UIColor whiteColor]};
    [segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName:[UIColor orangeColor]};
    [segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    unDataView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    [unDataView setText:@"没有要加载的数据"];
    unDataView.textAlignment = NSTextAlignmentCenter;
    unDataView.center = self.view.center;
    if(self.dicLoading.count > 0){
     unDataView.hidden = YES;
    }
    [self.view addSubview: unDataView];
}

//分段控制器点击事件
- (void)Selectbutton:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            self.dicLoading = [self getSplistList:@"BeLoadList"];
            currentView = Loading;
            btnChoolView.backgroundColor = cellImageColor;
            self.loadedTableView.hidden = YES;
            self.loadingTableView.hidden = NO;
            if (self.dicLoading.count < 1) {
                unDataView.hidden = NO;
                
            }
            else{
                unDataView.hidden = YES;
            }
            [self.loadingTableView reloadData];

            break;
        case 1:
            self.dicLoad = [self getSplistList:@"LoadDownList"];
            btnChoolView.backgroundColor = cellImageColor;
            currentView = Loaded;
            self.loadedTableView.hidden = NO;
            self.loadingTableView.hidden = YES;
            if (self.dicLoad.count < 1) {
                unDataView.hidden = NO;
            }
            else{
                unDataView.hidden = YES;
            }
            [self.loadedTableView reloadData];

            break;
        default:
            break;
    }
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    self.loadedTableView.frame = CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height - 104 - 48) ;
    self.loadingTableView.frame = CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height - 104 - 48) ;
    self.btnView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 40);
}

//显示界面是否有数据
- (void)isLoadOrLoading{

    if (currentView == Loading) {
        if (self.dicLoading.count < 1) {
            unDataView.hidden = NO;
        }
        else{
            unDataView.hidden = YES;
        }
    }
    else{
        if (self.dicLoad.count < 1) {
            unDataView.hidden = NO;
        }
        else{
            unDataView.hidden = YES;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.addLoadData) {
        self.addLoadData = NO;
        [self continueDown];
    }
    self.dicLoad = [self getSplistList:@"LoadDownList"];
    self.dicLoading = [self getSplistList:@"BeLoadList"];   
    [self isLoadOrLoading];
    for (NSString *allkey in self.dicLoading) {
        bool isNew = YES;
        for (int i = 0; i < saveLoading.count ; i++) {
            //saveLoading 是否存在 dicLoading的数据
            if ([allkey isEqualToString:[NSString stringWithFormat:@"%@",((SaveLodingDate*)saveLoading[i]).traintId]]) {
                isNew = NO;
                break;
            }
            
            isNew = YES;
        }
        if (isNew) {
            SaveLodingDate *aSave = [[SaveLodingDate alloc]init];
            aSave.traintId = self.dicLoading[allkey][5];
            aSave.stringUrl = [self stringAlbum:[loadDownBase arrayToAlbumList:self.dicLoading[allkey]]];
            [saveLoading addObject:aSave];
            
        }

    }
    [self.loadingTableView reloadData];
    // [NSThread detachNewThreadSelector:@selector(tableViewReloadData) toTarget:self withObject:nil];
}

- (void) tableViewReloadData{
    [self.loadedTableView reloadData];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     if(tableView.tag == 1001){//下载完成
         return self.dicLoad.count;
     }
     else{
         return self.dicLoading.count;
     }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 1001){
        if(self.dicLoad.count < 1)  return nil;
        LoadedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCELL"];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.dicLoad[[self.dicLoad allKeys][indexPath.row]][3]];
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        cell.titleLabel.numberOfLines = 0;
        NSURL *picurl = [NSURL URLWithString:self.dicLoad[[self.dicLoad allKeys][indexPath.row]][1]];
        [cell.coverImage sd_setImageWithURL:picurl];
        return cell;
    }
    else{
        LoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DINGCELL"];
        [cell removeFromSuperview];
        AlbumList *aAlbust = [[AlbumList alloc]init];
        aAlbust = [loadDownBase arrayToAlbumList:self.dicLoading[[self.dicLoading allKeys][indexPath.row]]];
        
        cell.aAlbum = aAlbust;
        cell.indexNum = (int)indexPath.row ;
     
        [cell addSubview:((SaveLodingDate*)saveLoading[indexPath.row]).progress];

        ((SaveLodingDate*)saveLoading[indexPath.row]).progress.frame = CGRectMake(70, 50, kWIDTH - 70 - 60, 10);
        
        ((SaveLodingDate*)saveLoading[indexPath.row]).btn.frame = CGRectMake(kWIDTH - 40 - 10, 20, 40, 20) ;
        ((SaveLodingDate*)saveLoading[indexPath.row]).btn.tag = 1000+indexPath.row;
        [cell addSubview:((SaveLodingDate*)saveLoading[indexPath.row]).btn];
        [((SaveLodingDate*)saveLoading[indexPath.row]).btn addTarget:self action:@selector(star:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.dicLoading[[self.dicLoading allKeys][indexPath.row]][3]];
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        cell.titleLabel.numberOfLines = 0;
        NSURL *picurl = [NSURL URLWithString:self.dicLoading[[self.dicLoading allKeys][indexPath.row]][1]];

        [cell.coverImage sd_setImageWithURL:picurl];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        for (NSArray * aArr in [self.dicLoad allValues]) {
            
            [arr addObject:[loadDownBase arrayToAlbumList:aArr]];
        }
            [[SingleModel shareSingleModel].playC initWithAvplayer:indexPath.row albumList:arr sAlbum:nil];
        self.navigationController.tabBarController.selectedIndex = 2;
    }
}

- (NSMutableDictionary *)getSplistList:(NSString *)string{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    return [loadDownBase getLoadDownPlish:string plistPath:plistPath1];
}

- (NSString *)stringAlbum:(AlbumList *)aAlbum{
    NSString *stringUrl = @"";
    if (aAlbum.downloadAacUrl != nil && ![aAlbum.downloadAacUrl isEqualToString:@""]) {
        stringUrl = aAlbum.downloadAacUrl;
    }
    else {
        stringUrl = aAlbum.downloadUrl;
    }
    return stringUrl;
}

- (void)star:(UIButton*)sender{

        if (currentLoad >= saveLoading.count) {
            currentLoad = (int )sender.tag - 1000;
        }
        if(currentLoad != sender.tag - 1000){
            if(((SaveLodingDate*)saveLoading[currentLoad]).downLoading) {
                [[saveLoading[currentLoad] btn] setTitle:@"下载" forState:UIControlStateNormal];
                ((SaveLodingDate*)saveLoading[currentLoad]).downLoading = NO;
                self.isLoading = NO;
                //取消发送请求
                [[saveLoading[currentLoad] cnnt] cancel];
                ((SaveLodingDate*)saveLoading[currentLoad]).cnnt = nil;
            }
        }
    //当下载完成后，点击按钮文字变为已下载
    currentLoad = (int)(sender.tag - 1000);
        [self LoadBegan];
}

- (void)LoadBegan{
    //判断当前是否正在下载
    if(currentLoad >= saveLoading.count) return;
    if (((SaveLodingDate*)saveLoading[currentLoad]).downLoading) {//如果当前正在下载，那么点击按钮，按钮变为暂停状态
        [[saveLoading[currentLoad] btn] setTitle:@"下载" forState:UIControlStateNormal];
        [saveLoading[currentLoad] btn].titleLabel.font = [UIFont boldSystemFontOfSize:12];
        ((SaveLodingDate*)saveLoading[currentLoad]).downLoading = NO;
        self.isLoading = NO;
        
        //取消发送请求
        [[saveLoading[currentLoad] cnnt] cancel];
        
        
        ((SaveLodingDate*)saveLoading[currentLoad]).cnnt = nil;
    }
    else
    {//如果当前没有下载，那么点击按钮，开始或者是继续下载
        [((SaveLodingDate*)saveLoading[currentLoad]).btn setTitle:@"暂停" forState:UIControlStateNormal];
        ((SaveLodingDate*)saveLoading[currentLoad]).downLoading = YES;
        self.isLoading = YES;
        //创建下载路径
        NSURL *url = [NSURL URLWithString:((SaveLodingDate*)saveLoading[currentLoad]).stringUrl];
        
        //创建一个请求
        //        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //设置请求头信息
        //self.currentLength字节部分重新开始读取
        NSString *value = [NSString stringWithFormat:@"bytes=%lld-",((SaveLodingDate*)saveLoading[currentLoad]).currentLength];
        [request setValue:value forHTTPHeaderField:@"Range"];
        
        //发送请求（使用代理的方式）
        ((SaveLodingDate*)saveLoading[currentLoad]).cnnt = [NSURLConnection connectionWithRequest:request delegate:self];
        //        [self.cnnt start];
    }

}

#pragma mark- NSURLConnectionDataDelegate代理方法
/*
 *当接收到服务器的响应（连通了服务器）时会调用
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
#warning 判断是否是第一次连接
    if(currentLoad >= saveLoading.count) return;
    if (((SaveLodingDate*)saveLoading[currentLoad]).sumLength) return;
    
    //1.创建文件存数路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *type = [@"."stringByAppendingString:[[((SaveLodingDate*)saveLoading[currentLoad]).stringUrl componentsSeparatedByString:@"."] lastObject]];
    NSString *fileName = [[NSString stringWithFormat:@"%@",((SaveLodingDate*)saveLoading[currentLoad]).traintId] stringByAppendingString:type];
    
    NSString *filePath = [caches stringByAppendingPathComponent:fileName];
    
    //2.创建一个空的文件,到沙盒中
    NSFileManager *mgr = [NSFileManager defaultManager];
    //刚创建完毕的大小是o字节
    [mgr createFileAtPath:filePath contents:nil attributes:nil];
    
    //3.创建写数据的文件句柄
    ((SaveLodingDate*)saveLoading[currentLoad]).writeHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    
    //4.获取完整的文件长度
    ((SaveLodingDate*)saveLoading[currentLoad]).sumLength = response.expectedContentLength;
}

/*
 *当接收到服务器的数据时会调用（可能会被调用多次，每次只传递部分数据）
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(currentLoad >= saveLoading.count) return;
    //累加接收到的数据长度
    ((SaveLodingDate*)saveLoading[currentLoad]).currentLength += data.length;
    //计算进度值
    double progress = (double)((SaveLodingDate*)saveLoading[currentLoad]).currentLength/((SaveLodingDate*)saveLoading[currentLoad]).sumLength;
    ((SaveLodingDate*)saveLoading[currentLoad]).progress.progress = progress;
    
    
    //一点一点接收数据。

    //NSLog(@"接收到服务器的数据！--%@--%ld",connection,data.length);
    //把data写入到创建的空文件中，但是不能使用writeTofile(会覆盖)
    //移动到文件的尾部
    [((SaveLodingDate*)saveLoading[currentLoad]).writeHandle seekToEndOfFile];
    //从当前移动的位置，写入数据
    [((SaveLodingDate*)saveLoading[currentLoad]).writeHandle writeData:data];
}

/*
 *当服务器的数据加载完毕时就会调用
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(currentLoad >= saveLoading.count) return;

    //关闭连接，不再输入数据在文件中
    [((SaveLodingDate*)saveLoading[currentLoad]).writeHandle closeFile];
    ((SaveLodingDate*)saveLoading[currentLoad]).writeHandle = nil;
    
    //清空进度值
    ((SaveLodingDate*)saveLoading[currentLoad]).currentLength = 0;
    ((SaveLodingDate*)saveLoading[currentLoad]).sumLength = 0;
    
    //设置按钮文字为“已经下载完成”
    [((SaveLodingDate*)saveLoading[currentLoad]).btn setTitle:@"完成" forState:UIControlStateNormal];
    [((SaveLodingDate*)saveLoading[currentLoad]).btn setEnabled:NO];
    
    //清空数组与本地下载列表数据
    [loadDownBase setLoadData:((SaveLodingDate*)saveLoading[currentLoad]).traintId plsitName:@"LoadDownList" albumName:[loadDownBase arrayToAlbumList:self.dicLoading[[self.dicLoading allKeys][currentLoad]]]];
    
    self.isLoading = NO;
//    [((SaveLodingDate*)saveLoading[currentLoad]).btn removeFromSuperview];
//    [((SaveLodingDate*)saveLoading[currentLoad]).progress removeFromSuperview];
    [self.loadingTableView reloadData];
    [loadDownBase removeObjOfPlist:[NSString stringWithFormat:@"%@",((SaveLodingDate*)saveLoading[currentLoad]).traintId] splistName:@"BeLoadList"];
    [saveLoading removeObjectAtIndex:currentLoad];
    self.dicLoading = [self getSplistList:@"BeLoadList"];
    
    [self.loadingTableView reloadData];
    
    if ([self nextCellTagIsHave ]) {
        [self LoadBegan];
    }
}
/*
 *请求错误（失败）的时候调用（请求超时\断网\没有网\，一般指客户端错误）
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[saveLoading[currentLoad] btn] setTitle:@"下载" forState:UIControlStateNormal];
    [saveLoading[currentLoad] btn].titleLabel.font = [UIFont boldSystemFontOfSize:12];
    ((SaveLodingDate*)saveLoading[currentLoad]).downLoading = NO;
    self.isLoading = NO;
    
    //取消发送请求
    [[saveLoading[currentLoad] cnnt] cancel];
    
    
    ((SaveLodingDate*)saveLoading[currentLoad]).cnnt = nil;
}

- (bool)nextCellTagIsHave{
    return currentLoad < saveLoading.count;
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row < saveLoading.count) {
        [((SaveLodingDate*)saveLoading[indexPath.row]).btn removeFromSuperview];
        [((SaveLodingDate*)saveLoading[indexPath.row]).progress removeFromSuperview];
        [self.loadingTableView reloadData];
    }

}


- (void)continueDown{
    if(self.isLoading) return;
    currentLoad = self.dicLoading.count;
    self.dicLoading = [self getSplistList:@"BeLoadList"];
    if (currentLoad >= self.dicLoading.count) {
        currentLoad = 0;
    }
    [self LoadBegan];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 1001){
         cell.backgroundColor = [UIColor whiteColor];
    }
    else{
         cell.backgroundColor = [UIColor whiteColor];
    }
   
}


//为指定的行指定编辑格式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //为指定的行指定编辑格式
    if(tableView.tag == 1001){
            return  UITableViewCellEditingStyleNone;
        
    }
    return UITableViewCellEditingStyleDelete;//删除单元格
}

//编辑格式  用于删除
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //通过delegate协议 为方法指定其编辑格式
    if(tableView.tag == 1002){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            //删除btn progress
            [((SaveLodingDate*)saveLoading[indexPath.row]).btn removeFromSuperview];
            [((SaveLodingDate*)saveLoading[indexPath.row]).progress removeFromSuperview];
            //取消发送请求
            [[saveLoading[indexPath.row] cnnt] cancel];
            ((SaveLodingDate*)saveLoading[indexPath.row]).cnnt = nil;
            //如果要删除数据要先删除对应行的数据
            //再将单元格删除
            [loadDownBase removeObjOfPlist:[NSString stringWithFormat:@"%@",((SaveLodingDate*)saveLoading[indexPath.row]).traintId] splistName:@"BeLoadList"];
            [self.dicLoading removeObjectForKey:[self.dicLoading allKeys][indexPath.row]];
            [saveLoading removeObjectAtIndex:indexPath.row];
            //删除单元格
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
