//
//  DKIndexViewController.m
//  PYDaikuan
//
//  Created by piang on 16/8/14.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKIndexViewController.h"
#import "DKWebViewController.h"
#import "UMMobClick/MobClick.h"

@interface DKIndexViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation DKIndexViewController

extern bool onlineSetting;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"一键贷款";
    
    self.dataSource = @[@{@"image":@"daikuan_rong360",@"url":@"https://m.rong360.com/express?from=sem21&utm_source=huile&utm_medium=cpa&utm_campaign=sem21_1",@"event_id":@"touch_rong360"},@{@"image":@"daikuan_yiren",@"url":@"http://wap.yirendai.com/new/?siteId=2829&source=1",@"event_id":@"touch_yiren"},@{@"image":@"daikuan_shoujidai",@"url":@"http://sjd-m.mobanker.com/?channel=xedkw-llcs",@"event_id":@"touch_shoujidai"},@{@"image":@"daikuan_haodai",@"url":@"https://loan.rongba.com/H5tuiguang/kff?ref=hd_11016474",@"event_id":@"touch_haodai"},@{@"image":@"daikuan_haodaixinyongka",@"url":@"http://8.yun.haodai.com/?ref=hd_11016474",@"event_id":@"touch_haodaixinyongka"},@{@"image":@"daikuan_xianjinbaika",@"url":@"http://api.51ygdai.com/act/light-loan?source_tag=H5-yjdk3",@"event_id":@"touch_xianjinbaika"}];
    
    
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indexTableViewCellIdentifier = @"indexTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexTableViewCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.dataSource[indexPath.row][@"image"]]];
    backgroundView.frame = CGRectMake(10, 5, CGRectGetWidth(self.tableview.frame) - 20, CGRectGetWidth(self.tableview.frame) / 2 - 10);
    [cell.contentView addSubview:backgroundView];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MobClick event:self.dataSource[indexPath.row][@"event_id"]];
    if (onlineSetting) {
        DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:self.dataSource[indexPath.row][@"url"]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.dataSource[indexPath.row][@"url"]]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth(self.tableview.frame) / 2;
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
