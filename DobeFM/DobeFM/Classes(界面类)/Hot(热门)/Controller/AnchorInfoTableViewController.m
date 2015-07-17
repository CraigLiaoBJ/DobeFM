//
//  AnchorInfoTableViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/15.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "AnchorInfoTableViewController.h"

@interface AnchorInfoTableViewController ()

@end

@implementation AnchorInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addHeaderImage];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];

}

- (void)addHeaderImage{
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kWIDTH / 2 - 44)];
    self.tableView.tableHeaderView = headerImageView;
    
    UIImageView *bgdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kWIDTH / 2 - 44)];
    bgdImageView.backgroundColor = [UIColor purpleColor];
    [headerImageView addSubview:bgdImageView];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake((kWIDTH - 60) / 2, 20, 60, 60)];
    iconImage.backgroundColor = [UIColor grayColor];
    iconImage.layer.cornerRadius = 30;
    iconImage.layer.masksToBounds = YES;
    [bgdImageView addSubview:iconImage];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWIDTH - kWIDTH / 2) / 2, 85, kWIDTH / 2, 20)];
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    nameLabel.text = @"小宝贝";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [bgdImageView addSubview:nameLabel];
    
    UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWIDTH - kWIDTH / 2) / 2, 110, kWIDTH / 2, 20)];
    tagLabel.font = [UIFont systemFontOfSize:14];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.text = @"分享快乐哇";
    [bgdImageView addSubview:tagLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = @"hahahah";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray * array = @[@"发布的专辑", @"发布的声音"];
    
    if (section == 0){
        return array[0];
        
    } else{
        return array[1];
    }
    
//    for (int i = 0; i < 2; i ++) {
//        self.title = array[i];
//      
//    }
    
//      return self.title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


@end
