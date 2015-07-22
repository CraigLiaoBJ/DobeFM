//
//  LoadingViewController.m
//  Xmly
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoadingViewController.h"
#import "LoadedCell.h"
#import "LoadingCell.h"
#import "LoadDownBase.h"

@interface LoadingViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSMutableDictionary *dicLoad;

@property (nonatomic, retain) NSMutableDictionary *dicLoading;

@property (nonatomic, strong) UIView *btnView;

@end


@implementation LoadingViewController
 enum loadState{
    Loading ,
    Loaded
};

static UILabel *unDataView;

static UIButton *loadedBtn;

static UIButton *loadingBtn;

static UIBarButtonItem *continueLoading;

static UIView *btnChoolView;//选中被这层盖住

static int  currentView = Loading;

static LoadDownBase *loadDownBase;

static NSMutableArray *saveLoading;

static int currentLoad = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.loadedTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height - 104 - 48)];
    self.loadedTableView.rowHeight = 60;
    self.loadedTableView.delegate = self;
    self.loadedTableView.dataSource = self;
    [self.loadedTableView registerClass:[LoadedCell class] forCellReuseIdentifier:@"DCELL"];
    self.loadedTableView.hidden = YES;
    self.loadedTableView.tag = 1001;
    [self.view addSubview:self.loadedTableView];

    
    //未下载view
    self.loadingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height-104 - 48)];
    self.loadingTableView.delegate = self;
    self.loadingTableView.dataSource = self;
    [self.loadingTableView registerClass:[LoadingCell class] forCellReuseIdentifier:@"DINGCELL"];
    self.loadingTableView.tag = 1002;
    [self.view addSubview:self.loadingTableView];

    
    
    self.btnView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*.2, 64, self.view.bounds.size.width*.6 , 40)];
    self.btnView.layer.borderWidth = 2;
    //设置按钮的边界颜色
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0,0,0,1});
    self.btnView.layer.borderColor = color;
    [self.btnView.layer setCornerRadius:CORNER_RADIUS_FLOAT];
    [self.view addSubview:self.btnView];
    
    loadingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loadingBtn.frame = CGRectMake(2, 2, self.btnView.bounds.size.width/2 - 2 - 1, 36);
    [loadingBtn setTitle:@"未下载" forState:UIControlStateNormal];
    [loadingBtn setBackgroundColor:[UIColor whiteColor]];
    [loadingBtn.layer setCornerRadius:CORNER_RADIUS_FLOAT];
    [loadingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadingBtn addTarget:self action:@selector(loadingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnView addSubview:loadingBtn];
    
    loadedBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loadedBtn.frame = CGRectMake(self.btnView.bounds.size.width/2 + 1, 2, self.btnView.bounds.size.width/2 - 2 - 1, 36);
    [loadedBtn setTitle:@"已下载" forState:UIControlStateNormal];
    [loadedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadedBtn setBackgroundColor:[UIColor whiteColor]];
    [loadedBtn.layer setCornerRadius:CORNER_RADIUS_FLOAT];
    [loadedBtn addTarget:self action:@selector(loadedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnView addSubview:loadedBtn];
    
    btnChoolView  = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, self.btnView.bounds.size.width/2 , 40)];
    btnChoolView.backgroundColor = [UIColor grayColor];
    btnChoolView.alpha = 0.2;
    [btnChoolView.layer setCornerRadius:CORNER_RADIUS_FLOAT];
    [self.btnView addSubview:btnChoolView];
    
    
    unDataView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    [unDataView setText:@"没有要加载的数据"];
    unDataView.textAlignment = NSTextAlignmentCenter;
    unDataView.center = self.view.center;
    if(self.dicLoading.count > 0){
     unDataView.hidden = YES;
    }
    [self.view addSubview: unDataView];
    
   continueLoading = [[UIBarButtonItem alloc]initWithTitle:@"全部下载" style:UIBarButtonItemStylePlain target:self action:@selector(continueLoading)];
    self.navigationItem.rightBarButtonItem = continueLoading;
    
}


-(void)continueLoading{
    NSLog(@"%@",[NSThread currentThread]);

}


-(void)loadingBtnClick:(UIButton *)sender{
    self.dicLoading = [self getSplistList:@"BeLoadList"];
    btnChoolView.frame  = CGRectMake(0, 0, self.btnView.bounds.size.width/2 , 40);
    currentView = Loading;
    self.loadedTableView.hidden = YES;
    self.loadingTableView.hidden = NO;
    [self isLoadOrLoading];
     [self.loadingTableView reloadData];
}



-(void)loadedBtnClick:(UIButton *)sender{
    self.dicLoad = [self getSplistList:@"LoadDownList"];
    btnChoolView.frame  = CGRectMake(self.btnView.bounds.size.width/2, 0, self.btnView.bounds.size.width/2 , 40);
    currentView = Loaded;
    self.loadedTableView.hidden = NO;
    self.loadingTableView.hidden = YES;
    [self isLoadOrLoading];
    [self.loadedTableView reloadData];
}


-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
//    self.loadedTableView.frame = CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height - 104) ;
//    self.loadingTableView.frame = CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height - 104) ;
    [self isLoadOrLoading];
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

-(void)viewWillAppear:(BOOL)animated{
    self.dicLoad = [self getSplistList:@"LoadDownList"];
    self.dicLoading = [self getSplistList:@"BeLoadList"];
    for (NSString *allkey in self.dicLoading) {
        
        for (int i = 0; i < saveLoading.count ; i++) {
            if (allkey == ((SaveLodingDate*)saveLoading[i]).traintId) {
                break ;
            }

        }
        SaveLodingDate *aSave = [[SaveLodingDate alloc]init];
        aSave.traintId = self.dicLoading[allkey][5];
        aSave.stringUrl = [self stringAlbum:[loadDownBase arrayToAlbumList:self.dicLoading[allkey]]];
        [saveLoading addObject:aSave];
    }
   // [NSThread detachNewThreadSelector:@selector(tableViewReloadData) toTarget:self withObject:nil];
}

- (void) tableViewReloadData{
    [self.loadedTableView reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
 if(tableView.tag == 1001){//下载完成
     return self.dicLoad.count;
 }
 else{
     return self.dicLoading.count;
 
 }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 1001){
        if(self.dicLoad.count < 1)  return nil;
        LoadedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DCELL"];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dicLoad[[self.dicLoad allKeys][indexPath.row]][3]];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:10];
        cell.textLabel.numberOfLines = 0;
        NSURL *picurl = [NSURL URLWithString:self.dicLoad[[self.dicLoad allKeys][indexPath.row]][1]];
        NSData *picData  = [NSData dataWithContentsOfURL:picurl];
        [cell.imageView setImage:[UIImage imageWithData:picData]];
        return cell;
    }else{
        LoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DINGCELL"];
        [cell removeFromSuperview];
        AlbumList *aAlbust = [[AlbumList alloc]init];
        aAlbust = [loadDownBase arrayToAlbumList:self.dicLoading[[self.dicLoading allKeys][indexPath.row]]];
        
        cell.aAlbum = aAlbust;
        cell.indexNum = indexPath.row ;
     
        [cell addSubview:((SaveLodingDate*)saveLoading[indexPath.row]).progress];
        NSLog(@"cell.frame ======= %f", cell.frame.size.height);
        ((SaveLodingDate*)saveLoading[indexPath.row]).progress.frame = CGRectMake((cell.bounds.size.width * .4) / 2 + 40, 50, cell.bounds.size.width * 0.5, 10);
        
        //cell.btn =
        ((SaveLodingDate*)saveLoading[indexPath.row]).btn.frame = CGRectMake(cell.bounds.size.width - 40, 20, 40, 20) ;
        ((SaveLodingDate*)saveLoading[indexPath.row]).btn.tag = 1000+indexPath.row;
        [cell addSubview:((SaveLodingDate*)saveLoading[indexPath.row]).btn];
        [((SaveLodingDate*)saveLoading[indexPath.row]).btn addTarget:self action:@selector(star:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dicLoading[[self.dicLoading allKeys][indexPath.row]][3]];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:10];
        cell.textLabel.numberOfLines = 0;
        NSURL *picurl = [NSURL URLWithString:self.dicLoading[[self.dicLoading allKeys][indexPath.row]][1]];
        NSData *picData  = [NSData dataWithContentsOfURL:picurl];
        [cell.imageView setImage:[UIImage imageWithData:picData]];
        return cell;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(DrawerTableView:)]) {
//        [self.delegate DrawerTableView:self.dic[[self.dic allKeys][indexPath.row]]];
//    }
    
}


-(NSMutableDictionary*)getSplistList:(NSString *)string{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    return [loadDownBase getLoadDownPlish:string plistPath:plistPath1];
}

-(NSString*)stringAlbum:(AlbumList *)aAlbum{
    NSString *stringUrl = @"";
    if (aAlbum.downloadAacUrl != nil && ![aAlbum.downloadAacUrl isEqualToString:@""]) {
        stringUrl = aAlbum.downloadAacUrl;
    }
    else {
        stringUrl = aAlbum.downloadUrl;
    }
    return stringUrl;
}

- (void)star:(UIButton*)sender
    {
    //当下载完成后，点击按钮文字变为已下载
    currentLoad = sender.tag - 1000;
        [self LoadBegan];
}

- (void)LoadBegan{
    //判断当前是否正在下载
    if ([saveLoading[currentLoad] isdownLoading]) {//如果当前正在下载，那么点击按钮，按钮变为暂停状态
        [[saveLoading[currentLoad] btn] setTitle:@"下载" forState:UIControlStateNormal];
        ((SaveLodingDate*)saveLoading[currentLoad]).downLoading = NO;
        
        //取消发送请求
        [[saveLoading[currentLoad] cnnt] cancel];
        
        
        ((SaveLodingDate*)saveLoading[currentLoad]).cnnt = nil;
    }
    else
    {//如果当前没有下载，那么点击按钮，开始或者是继续下载
        [((SaveLodingDate*)saveLoading[currentLoad]).btn setTitle:@"暂停" forState:UIControlStateNormal];
        ((SaveLodingDate*)saveLoading[currentLoad]).downLoading = YES;
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
    if (((SaveLodingDate*)saveLoading[currentLoad]).sumLength) return;
    
    //1.创建文件存数路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:@"611.aac"];
    
    
    
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
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //累加接收到的数据长度
    ((SaveLodingDate*)saveLoading[currentLoad]).currentLength += data.length;
    //计算进度值
    double progress = (double)((SaveLodingDate*)saveLoading[currentLoad]).currentLength/((SaveLodingDate*)saveLoading[currentLoad]).sumLength;
    ((SaveLodingDate*)saveLoading[currentLoad]).progress.progress = progress;
    
    
    //一点一点接收数据。
    NSLog(@"接收到服务器的数据！--%@--%ld",connection,data.length);
    //把data写入到创建的空文件中，但是不能使用writeTofile(会覆盖)
    //移动到文件的尾部
    [((SaveLodingDate*)saveLoading[currentLoad]).writeHandle seekToEndOfFile];
    //从当前移动的位置，写入数据
    [((SaveLodingDate*)saveLoading[currentLoad]).writeHandle writeData:data];
}

/*
 *当服务器的数据加载完毕时就会调用
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"下载完毕----%lld",((SaveLodingDate*)saveLoading[currentLoad]).sumLength);
    //关闭连接，不再输入数据在文件中
    [((SaveLodingDate*)saveLoading[currentLoad]).writeHandle closeFile];
    ((SaveLodingDate*)saveLoading[currentLoad]).writeHandle = nil;
    
    //清空进度值
    ((SaveLodingDate*)saveLoading[currentLoad]).currentLength = 0;
    ((SaveLodingDate*)saveLoading[currentLoad]).sumLength = 0;
    
    //设置按钮文字为“已经下载完成”
    [((SaveLodingDate*)saveLoading[currentLoad]).btn setTitle:@"已经下载完成" forState:UIControlStateNormal];
    [((SaveLodingDate*)saveLoading[currentLoad]).btn setEnabled:NO];
    
    //清空数组与本地下载列表数据
    [loadDownBase setLoadData:((SaveLodingDate*)saveLoading[currentLoad]).traintId plsitName:@"LoadDownList" albumName:[loadDownBase arrayToAlbumList:self.dicLoading[[self.dicLoading allKeys][currentLoad]]]];
    
    
    [((SaveLodingDate*)saveLoading[currentLoad]).btn removeFromSuperview];
    [((SaveLodingDate*)saveLoading[currentLoad]).progress removeFromSuperview];
    [loadDownBase removeObjOfPlist:((SaveLodingDate*)saveLoading[currentLoad]).traintId splistName:@"BeLoadList"];
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
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
     NSLog(@"下载ERROR");
}

- (bool)nextCellTagIsHave{
    
    for(int i = 1; i <= self.dicLoading.count; i++ ){
      UIButton *button = (UIButton*)[self.view viewWithTag:currentLoad + i + 1000];
        if (button != nil) {
            currentLoad += i;
            return YES;
        }
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    [((SaveLodingDate*)saveLoading[indexPath.row]).btn removeFromSuperview];
    [((SaveLodingDate*)saveLoading[indexPath.row]).progress removeFromSuperview];
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
