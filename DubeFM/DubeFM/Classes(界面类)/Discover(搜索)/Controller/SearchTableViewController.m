//
//  SearchTableViewController.m
//  DobeFM
//
//  Created by Craig Liao on 15/7/27.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "SearchTableViewController.h"
#import "AnchorCell.h"
#import "AlbumCell.h"
#import "AudioCell.h"
#import "AnchorIntroModel.h"
#import "AlbumList.h"
#import "SearchAlbum.h"
#define ALBUMURL @"http://mobile.ximalaya.com/s/mobile/search?device=iPhone&condition=%E5%93%88%E5%93%88&page=1&per_page=20&scope=album"

#define ANCHORURL @"http://mobile.ximalaya.com/s/mobile/search?device=iPhone&condition=%E5%93%88%E5%93%88&page=1&per_page=20&scope=user"

#define AUDIOURL @"http://mobile.ximalaya.com/s/mobile/search?device=iPhone&condition=%E5%93%88%E5%93%88&page=1&per_page=20&scope=voice"

@interface SearchTableViewController ()

@property (nonatomic, retain) NSMutableArray *anchorArray;

@property (nonatomic, retain) NSMutableArray *albumArray;

@property (nonatomic, retain) NSMutableArray *audioArray;

@property (nonatomic, retain) UISegmentedControl *segmentedControl;

@end

@implementation SearchTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [[UIColor blackColor] CGColor];
    //注册主播单元格
    [self.tableView registerClass:[AnchorCell class] forCellReuseIdentifier:@"anchor"];
     //注册专辑单元格
    [self.tableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"album"];
     //注册声音单元格
    [self.tableView registerClass:[AudioCell class] forCellReuseIdentifier:@"audio"];
    
    //设置分段控制器
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"找专辑", @"找人", @"找声音"]];
    _segmentedControl.frame = CGRectMake(0, 64, kWIDTH, 40);
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor orangeColor];
    [_segmentedControl addTarget:self action:@selector(didClickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didClickSegmentedControl:(UISegmentedControl *)seg{
    if (0 == seg.selectedSegmentIndex) {
        [self.tableView reloadData];
    } else if (1 == seg.selectedSegmentIndex){
        [self.tableView reloadData];
    } else {
        [self.tableView reloadData];
    }
}

- (void)loadAlbumData{
    
}

- (void)loadAnchorData{
    
}

- (void)loadAudioData{
    
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
    if (0 == _segmentedControl.selectedSegmentIndex) {
        return self.albumArray.count;
    } else if (1 == _segmentedControl.selectedSegmentIndex){
        return self.anchorArray.count;
    } else {
        return self.audioArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _segmentedControl.selectedSegmentIndex) {
        AlbumCell *albumCell = [tableView dequeueReusableCellWithIdentifier:@"album" forIndexPath:indexPath];
        return albumCell;
    } else if (1 == _segmentedControl.selectedSegmentIndex){
        AnchorCell *anchorCell = [tableView dequeueReusableCellWithIdentifier:@"anchor" forIndexPath:indexPath];
        return anchorCell;
    } else {
        AudioCell *audioCell = [tableView dequeueReusableCellWithIdentifier:@"audio" forIndexPath:indexPath];
        return audioCell;
    }
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
