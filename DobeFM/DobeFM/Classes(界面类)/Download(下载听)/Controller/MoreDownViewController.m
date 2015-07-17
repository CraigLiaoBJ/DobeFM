//
//  MoreDownViewController.m
//  Xmly
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#import "LoadDownBase.h"
#import "ChoolNumView.h"
#import "MoreDownViewController.h"
#import "MoreDownCell.h"
#import "AlbumList.h"

@interface MoreDownViewController ()<UITableViewDelegate,UITableViewDataSource,ChoolNumDelegate>

@property (nonatomic, strong) UITableView *moreDownTableView;

@property (nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation MoreDownViewController

static NSMutableArray *showArray;

static ChoolNumView *choolView;

static bool isAllCheck = NO;

static LoadDownBase *loadDownBase;

static bool isDoading = NO;//是否在下载

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"批量下载";
    
    loadDownBase = [[LoadDownBase alloc]init];
    choolView = [[ChoolNumView alloc]initWithFrame:self.view.frame];
    choolView.backgroundColor = [UIColor whiteColor];
    choolView.delegate = self;
    [self.view addSubview:choolView];
    
    self.moreDownTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.moreDownTableView];
    self.moreDownTableView.delegate = self;
    self.moreDownTableView.dataSource = self;
    [self.moreDownTableView registerClass:[MoreDownCell class] forCellReuseIdentifier:@"moreCell"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.cellArray = [[NSMutableArray alloc]init];
    
    UIView *loadDownBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 78, self.view.bounds.size.width, 30)];
    loadDownBtnView.backgroundColor  = [UIColor grayColor];
    [self.view addSubview:loadDownBtnView];
    
    UIButton *loadDownBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - self.view.bounds.size.width*0.2, 2, self.view.bounds.size.width*0.2, 26)];
    [loadDownBtn setTitle:@"下载" forState:UIControlStateNormal];
    [loadDownBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loadDownBtn addTarget:self action:@selector(loadDownAction:) forControlEvents:UIControlEventTouchUpInside];
    [loadDownBtn.layer setCornerRadius:10];
    loadDownBtn.layer.borderWidth = 1;
    //设置按钮的边界颜色
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0,0,0,1});
    loadDownBtn.layer.borderColor = color;
    loadDownBtn.backgroundColor = [UIColor whiteColor];
    [loadDownBtnView addSubview:loadDownBtn];
}

//全选
- (void) rightItemClick:( UIBarButtonItem*)sender{

    isAllCheck = isAllCheck == NO;
    for (AlbumList *detail in  showArray) {
        detail.isSelect = isAllCheck;
    }
    
    [self.moreDownTableView reloadData];

}

//下载
-(void)loadDownAction:(UIButton *)sender{
    
    for (AlbumList *albumListId in showArray) {
        if (albumListId.isSelect == YES) {
           [loadDownBase setLoadData:[albumListId trackId] plsitName:@"BeLoadList" albumName:albumListId];
        }
    }
    if (!isDoading) {
        [NSThread detachNewThreadSelector:@selector(threadLoadDownAction) toTarget:self withObject:nil];
        isDoading = YES;
    }
   
}

//多线程下载
- (void) threadLoadDownAction{
//    AlbumList *oneList = [[AlbumList alloc]init];
//    oneList = [loadDownBase getLoadingList];
//    for (AlbumList *albumListId in showArray) {
//        if (albumListId.isSelect == YES) {
//            [self threadLoad:albumListId];
//            [loadDownBase removeObjOfPlist:[albumListId trackId] splistName:@"BeLoadList"];
//        }
//    }
    while ([loadDownBase isLoadingList]) {
        AlbumList *oneList = [[AlbumList alloc]init];
        oneList = [loadDownBase getLoadingList];
        [self threadLoad:oneList];
        [loadDownBase removeObjOfPlist:[oneList trackId] splistName:@"BeLoadList"];
    }
    isDoading = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    isAllCheck = NO;
    for (AlbumList *detail in  showArray) {
        detail.isSelect = isAllCheck;
    }
}

-(void)reloadView{
        if (self.audioArray.count <= 50  ) {
            showArray =[[NSMutableArray alloc]initWithArray:self.audioArray];
        }
        else
        {
            for (int  i = 0; i < 50 ; i++) {
                [showArray addObject:self.audioArray[i]];

            }
        }
    NSInteger ChoolHeight = 30*(self.audioArray.count/CHOOL_NEWLINE_NUM/4 + 1);
    self.moreDownTableView.frame = CGRectMake(0,64 + ChoolHeight, self.view.bounds.size.width, self.view.bounds.size.height - ChoolHeight - 78 - 64);
    choolView.num = self.audioArray.count;
    [self.moreDownTableView reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return showArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreDownCell *acell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];

    acell.titleStr.text = [NSString stringWithFormat:@"%@",[showArray[indexPath.row] title1]];

    acell.checkbox.selected = ((AlbumList*)showArray[indexPath.row]).isSelect == YES;
    [self.cellArray addObject:acell];
    return acell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ((AlbumList*)showArray[indexPath.row]).isSelect = ((AlbumList*)showArray[indexPath.row]).isSelect == NO;
    [self.moreDownTableView reloadData];
}

//换显示集数段位
-(void)labelClick:(MDownButton *)sender{
   // NSLog(@"%f--%f",sender.starNum,sender.endNum);
    [showArray removeAllObjects];
    for (int  i = sender.starNum - 1 ; i < sender.endNum ; i++) {
        [showArray addObject:self.audioArray[i]];
    }
    [self.moreDownTableView reloadData];
}

//下载音乐
-(void)threadLoad:(AlbumList*)sender{
    [loadDownBase loadAudioToLocation:[sender downloadAacUrl] styp:@".mp3" albumName:sender];
    [loadDownBase setLoadData:[sender trackId] plsitName:@"LoadDownList" albumName:sender];
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
