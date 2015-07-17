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
@interface LoadingViewController ()<UITableViewDataSource,UITableViewDelegate>

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

static UIView *btnChoolView;//选中被这层盖住

static int  currentView = Loading;

static LoadDownBase *loadDownBase;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    loadDownBase = [[LoadDownBase alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dicLoad = [self getSplistList:@"LoadDownList"];
    self.dicLoading = [self getSplistList:@"BeLoadList"];
    
    //下载完成view
    self.loadedTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.loadedTableView.rowHeight = 60;
    self.loadedTableView.delegate = self;
    self.loadedTableView.dataSource = self;
    [self.loadedTableView registerClass:[LoadedCell class] forCellReuseIdentifier:@"DCELL"];
    self.loadedTableView.hidden = YES;
    self.loadedTableView.tag = 1001;
    [self.view addSubview:self.loadedTableView];

    
    //未下载view
    self.loadingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.loadingTableView.rowHeight = 60;
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
}

-(void)loadingBtnClick:(UIButton *)sender{
    self.dicLoading = [self getSplistList:@"BeLoadList"];
    btnChoolView.frame  = CGRectMake(0, 0, self.btnView.bounds.size.width/2 , 40);
    currentView = Loading;
    self.loadedTableView.hidden = YES;
    self.loadingTableView.hidden = NO;
    if (self.dicLoading.count < 1) {
        unDataView.hidden = NO;

    }
    else{
        unDataView.hidden = YES;
    }
     [self.loadingTableView reloadData];
}



-(void)loadedBtnClick:(UIButton *)sender{
    self.dicLoad = [self getSplistList:@"LoadDownList"];
    btnChoolView.frame  = CGRectMake(self.btnView.bounds.size.width/2, 0, self.btnView.bounds.size.width/2 , 40);
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
}


-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    self.loadedTableView.frame = CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height) ;
    self.loadingTableView.frame = CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height) ;
    self.btnView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 40);

}


-(void)viewWillAppear:(BOOL)animated{
    self.dicLoad = [self getSplistList:@"LoadDownList"];
    self.dicLoading = [self getSplistList:@"BeLoadList"];
   // [NSThread detachNewThreadSelector:@selector(tableViewReloadData) toTarget:self withObject:nil];
}

- (void) tableViewReloadData{
    [self.loadedTableView reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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
    }
    else{
//        if(self.dicLoading.count < 1)  {
//            self.loadingTableView = nil;
//            return nil;
//        };
        LoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DINGCELL"];
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
