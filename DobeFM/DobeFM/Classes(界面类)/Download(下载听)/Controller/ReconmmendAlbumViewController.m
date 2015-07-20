//
//  ReconmmendAlbumViewController.m
//  Xmly
//
//  Created by lanou3g on 15/6/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#import "MoreDownViewController.h"
#import "UIImageView+WebCache.h"
#import "ReconmmendAlbumViewController.h"
#import "Nework.h"
#import "searchAlbum.h"
#import "AlbumList.h"
#import "AvPlayViewController.h"
#import "SingleModel.h"
#import "AlbumCell.h"
@interface ReconmmendAlbumViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)SearchAlbum *sAlbum;
@property(nonatomic,strong)NSMutableArray *dataArray;//声音集合
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)AvPlayViewController *playC;
@end

@implementation ReconmmendAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.idString = @"http://mobile.ximalaya.com/mobile/others/ca/album/track/367273/true/1/15";
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    [self.view addSubview:self.topView];
    // Do any additional setup after loading the view.
    self.dataArray = [[NSMutableArray alloc]init];
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height - 150)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
    [self requestData];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"批量下载" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void) rightItemClick:( UIBarButtonItem*)sender{
    MoreDownViewController *moreVC = [[MoreDownViewController alloc]init];
    moreVC.view.backgroundColor = [UIColor whiteColor];
    moreVC.audioArray =[[NSMutableArray alloc]initWithArray: self.dataArray];
    [moreVC  reloadView];
    [self.navigationController pushViewController:moreVC animated:YES];

}


//数据解析
-(void)requestData{
__block typeof (self)aSelf = self;
[Nework recivedDataWithURLString:self.idString method:@"GET" body:nil Block:^(id objeck) {
    NSDictionary *dic = (NSDictionary *)objeck;
    NSDictionary *dicAlibum =dic[@"album"];
    aSelf.sAlbum = [[SearchAlbum alloc]initWithSearchAlbum:[NSString stringWithFormat:@"%@",dicAlibum[@"albumId"]] avataPath:dicAlibum[@"avatarPath"] coverLarge:dicAlibum[@"coverLarge"]  coverOrige:dicAlibum[@"coverOrigin"] coverSmall:dicAlibum[@"coverSmall"] categoryId:[NSString stringWithFormat:@"%@",dicAlibum[@"categoryId"]] categoryName:dicAlibum[@"categoryName"] categoryAt:[dicAlibum[@"categoryAt"] intValue]];
    NSArray *AListArray =dic[@"tracks"][@"list"];
    for (int i = 0 ; i < AListArray.count;i++) {
        AlbumList *alist = [[AlbumList alloc]init];
        [alist setValuesForKeysWithDictionary:AListArray[i]];
        [aSelf.dataArray addObject:alist];
    }
    
    [aSelf.tableView reloadData];
}];
    


}

//按钮事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[SingleModel shareSingleModel].playC initWithAvplayer:indexPath.row albumList:[NSMutableArray arrayWithArray: self.dataArray] sAlbum:self.sAlbum];
    [self.navigationController pushViewController:[SingleModel shareSingleModel].playC animated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string = @"aCell";
    if(self.dataArray.count < 1) return nil;
    AlbumCell *acell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:string];
    if (acell == nil) {
        acell = [[AlbumCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    }
    
    acell.audioTitleLabel.text = [self.dataArray[indexPath.row] title1];
    acell.durationLabel.text = [self convertTime:[[self.dataArray[indexPath.row] durationTime] floatValue]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dataArray[indexPath.row] albumImage]]];
    [acell.coverSmImage sd_setImageWithURL:url];
    return acell;
}



- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
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
