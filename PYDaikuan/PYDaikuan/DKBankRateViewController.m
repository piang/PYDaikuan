//
//  DKBankRateViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/17.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKBankRateViewController.h"

@interface DKBankRateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *timeDataSource;
@property (strong, nonatomic) NSArray *rateDataSouce;
@property (assign, nonatomic) int bankId;

@end

@implementation DKBankRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"贷款利率";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.timeDataSource = @[@"六个月（含）",@"六个月至一年（含）",@"一至三年（含）",@"三至五年（含）",@"五年以上"];
    self.rateDataSouce = @[@"4.350",@"4.350",@"4.750",@"4.750",@"4.900"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indexTableViewCellIdentifier = @"bankRateTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indexTableViewCellIdentifier];
        cell.textLabel.text = self.timeDataSource[indexPath.row];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.text = self.rateDataSouce[indexPath.row];
        
        cell.accessoryView = rightLabel;
    }
    
    return cell;
    
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
