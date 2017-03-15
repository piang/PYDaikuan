//
//  DKBankTelViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/13.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKBankTelViewController.h"

@interface DKBankTelViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation DKBankTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"银行客服";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSource = @[@{@"title":@"中国建设银行客服电话",@"tel":@"telprompt:95533"},@{@"title":@"中国工商银行客服电话",@"tel":@"telprompt:95588"},@{@"title":@"中国平安保险(集团)股份有限公司客服电话",@"tel":@"telprompt:95511"},@{@"title":@"中国农业银行客服电话",@"tel":@"telprompt:95599"},@{@"title":@"交通银行客服电话",@"tel":@"telprompt:95559"},@{@"title":@"中国银行客服电话",@"tel":@"telprompt:95566"},@{@"title":@"中国招商银行客服电话",@"tel":@"telprompt:95555"},@{@"title":@"浙江网商银行客服电话",@"tel":@"telprompt:95188"},@{@"title":@"中国邮政储蓄银行客服电话",@"tel":@"telprompt:95580"},@{@"title":@"广发银行客服电话",@"tel":@"telprompt:400-830-8003"}];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indexTableViewCellIdentifier = @"bankTelTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indexTableViewCellIdentifier];
        cell.textLabel.text = _dataSource[indexPath.row][@"title"];
        cell.detailTextLabel.text = _dataSource[indexPath.row][@"tel"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_dataSource[indexPath.row][@"tel"]]];
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
