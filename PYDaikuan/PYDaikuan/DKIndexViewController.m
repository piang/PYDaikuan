//
//  DKIndexViewController.m
//  PYDaikuan
//
//  Created by piang on 16/8/14.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKIndexViewController.h"
#import "DKWebViewController.h"

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
    
    self.dataSource = @[@{@"image":@"daikuan_rong360",@"url":@"https://m.rong360.com/express?from=sem21&utm_source=dl&utm_medium=cpa&utm_campaign=sem21"},@{@"image":@"daikuan_haodai",@"url":@"https://openapi.haodai.com/h5tuiguang/aff?ref=hd_11014405"},@{@"image":@"daikuan_yiren",@"url":@"https://openapi.haodai.com/h5tuiguang/aff?ref=hd_11014405"},@{@"image":@"daikuan_feidai",@"url":@"http://a2429.oadz.com/link/C/2429/375050/4J2vGhSAg0xRQn4jSo4n4eY12Qg_/a/0/http://xchannel.feidai.com/FeiDaiWebSite/feidai/down/sourcecount?code=87302"},@{@"image":@"daikuan_paipai",@"url":@"http://m.ppdai.com/landingcpsnew.html?regsourceid=xiaoedaikuanwx01"},@{@"image":@"daikuan_shanyin",@"url":@"http://ios.wecash.net/wep/simple_h5.html?version=h5&channelId=327&channelCode=70227a"}];
    
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
