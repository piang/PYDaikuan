//
//  DKBankTelViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/13.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKBankTelViewController.h"
#import "DKBankRateViewController.h"

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
    
    self.dataSource = @[@{@"title":@"中国建设银行客服电话",@"tel":@"telprompt:95533",@"image":@"constructionBank"},@{@"title":@"中国工商银行客服电话",@"tel":@"telprompt:95588",@"image":@"icbc"},@{@"title":@"中国平安保险(集团)股份有限公司客服电话",@"tel":@"telprompt:95511",@"image":@"pingan"},@{@"title":@"中国农业银行客服电话",@"tel":@"telprompt:95599",@"image":@"argiculturalBank"},@{@"title":@"交通银行客服电话",@"tel":@"telprompt:95559",@"image":@"communicationsBank"},@{@"title":@"中国银行客服电话",@"tel":@"telprompt:95566",@"image":@"chinaBank"},@{@"title":@"中国招商银行客服电话",@"tel":@"telprompt:95555",@"image":@"merchantsBank"},@{@"title":@"浙江网商银行客服电话",@"tel":@"telprompt:95188",@"image":@"MYBank"},@{@"title":@"中国邮政储蓄银行客服电话",@"tel":@"telprompt:95580",@"image":@"postalSavingsBank"},@{@"title":@"广发银行客服电话",@"tel":@"telprompt:400-830-8003",@"image":@"guangfaBank"}];
    
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
        cell.imageView.image = [UIImage imageNamed:_dataSource[indexPath.row][@"image"]];
        cell.textLabel.text = _dataSource[indexPath.row][@"title"];
        cell.detailTextLabel.text = _dataSource[indexPath.row][@"tel"];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[DKBankRateViewController alloc] init] animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
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
