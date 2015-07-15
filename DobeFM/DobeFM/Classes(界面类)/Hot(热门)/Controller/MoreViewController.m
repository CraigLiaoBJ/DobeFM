//
//  MoreTableViewController.m
//  iTing
//
//  Created by Craig Liao on 15/7/14.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *hotTableView;
//@property (nonatomic, retain) UITableView *newTableView;

@property (nonatomic, retain) NSMutableArray *arr;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr = [NSMutableArray array];
    
    for (int i = 0; i < 200; i ++) {
        int index = arc4random() % 2000;
        
        NSString *string = [NSString stringWithFormat:@"%d", index];
        
        [self.arr addObject:string];
    }

    UISegmentedControl *segControl = [[UISegmentedControl alloc]initWithItems:@[@"最热", @"最新"]];
    segControl.frame = CGRectMake((kWIDTH - 200) / 2, 5, 200, 30);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, 40)];
    imageView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:imageView];
    [imageView addSubview:segControl];
    imageView.userInteractionEnabled = YES;
    [segControl addTarget:segControl action:@selector(didClickControl:) forControlEvents:UIControlEventValueChanged];
    
    self.hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, kWIDTH, kHEIGHT - 64 - 40) style:UITableViewStylePlain];
    self.hotTableView.dataSource = self;
    self.hotTableView.delegate = self;
    self.hotTableView.rowHeight = 160;
    self.hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.hotTableView];
    
    [self.hotTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
//    self.newTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, kWIDTH, kHEIGHT - 64 - 40) style:UITableViewStylePlain];
//    self.newTableView.dataSource = self;
//    self.newTableView.delegate = self;
//    self.newTableView.rowHeight = 160;
//    self.newTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.newTableView];
//    
//    [self.newTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
}



- (void)didClickControl:(UISegmentedControl *)seg {
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self.arr removeAllObjects];
            for (int i = 0; i < 200; i ++) {
                int index = arc4random() % 2000;
                
                NSString *string = [NSString stringWithFormat:@"%d", index];
                
                [self.arr addObject:string];
            }
            [self.hotTableView reloadData];
            break;
        case 1:
            [self.arr removeAllObjects];
            for (int i = 0; i < 200; i ++) {
                int index = arc4random() % 2000;
                
                NSString *string = [NSString stringWithFormat:@"%d", index];
                
                [self.arr addObject:string];
            }
            [self.hotTableView reloadData];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.hotTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        
        cell.textLabel.text = @"ceshi";
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
        
        cell.textLabel.text = @"xiaozi";
        return cell;
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
