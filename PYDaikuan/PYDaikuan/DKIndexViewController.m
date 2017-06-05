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
#import "AppDelegate.h"
#import "DKIndexDetailViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DKIndexRecommendTableViewCell.h"
#import "DKIndexTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>

@interface DKIndexViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation DKIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"一键贷款";
    
    [AVOSCloud setApplicationId:@"XpuV4q5fN2hj9hGr4CwzYvHO-gzGzoHsz" clientKey:@"vOcE9YRm4PLFdxv3GYrnkTVb"];
    AVQuery *query = [AVQuery queryWithClassName:@"channel_version"];
    
    [query getObjectInBackgroundWithId:@"593415d5a22b9d0058e770f6" block:^(AVObject *object, NSError *error) {
        NSLog(@"object%@",object);
        
        int currentVersion = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentVersion"] intValue];
        
        if ( currentVersion < [object[@"currentVersion"] intValue]) {
            
            AVQuery *query = [AVQuery queryWithClassName:@"channel"];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                NSLog(@"objects%@",objects);
                
                self.dataSource = [NSMutableArray arrayWithCapacity:5];
                
                for (int i  =0 ; i < objects.count; i++) {
                    [self.dataSource addObject:objects[i][@"localData"]];
                    self.dataSource[i][@"image"] = ((AVFile *)objects[i][@"localData"][@"image"]).url;
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:object[@"currentVersion"] forKey:@"currentVersion"];
                [[NSUserDefaults standardUserDefaults] setObject:self.dataSource forKey:@"channelDatasource"];
                
                if (self.dataSource.count > 3) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSArray *bannerDataSource = @[_dataSource[0][@"image"],_dataSource[1][@"image"],_dataSource[2][@"image"],_dataSource[3][@"image"]];
                        
                        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 2) imageNamesGroup:bannerDataSource];
                        cycleScrollView.titlesGroup = @[_dataSource[0][@"title"],_dataSource[1][@"title"],_dataSource[2][@"title"],_dataSource[3][@"title"]];
                        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
                        cycleScrollView.clickItemOperationBlock = ^(NSInteger index){
                            DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:_dataSource[index][@"url"]];
                            [self.navigationController pushViewController:webVC animated:YES];
                        };
                        
                        _tableview.tableHeaderView = cycleScrollView;
                        
                        [self.tableview reloadData];
                    });
                }
                
            }];
        }
        
        else {
            self.dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"channelDatasource"];
            if (self.dataSource.count > 3) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *bannerDataSource = @[_dataSource[0][@"image"],_dataSource[1][@"image"],_dataSource[2][@"image"],_dataSource[3][@"image"]];
                    
                    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 2) imageNamesGroup:bannerDataSource];
                    cycleScrollView.titlesGroup = @[_dataSource[0][@"title"],_dataSource[1][@"title"],_dataSource[2][@"title"],_dataSource[3][@"title"]];
                    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
                    cycleScrollView.clickItemOperationBlock = ^(NSInteger index){
                        DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:_dataSource[index][@"url"]];
                        [self.navigationController pushViewController:webVC animated:YES];
                    };
                    
                    _tableview.tableHeaderView = cycleScrollView;
                    
                    [self.tableview reloadData];
                });
            }
        }
        
    }];
    
    //    self.dataSource = @[@{@"title":@"好贷网",@"image":@"daikuan_haodai",@"url":@"https://loan.rongba.com/H5tuiguang/kff?ref=hd_11016474",@"event_id":@"touch_haodai",@"maxMoney":@"0.5"},@{@"title":@"融360",@"image":@"daikuan_rong360",@"url":@"https://m.rong360.com/express?from=sem21&utm_source=huile&utm_medium=cpa&utm_campaign=sem21_1",@"event_id":@"touch_rong360",@"maxMoney":@"10"},@{@"title":@"信而富",@"image":@"daikuan_xinerfu",@"url":@"https://promotion.crfchina.com/localMarket/index.html?c=&s=imm3&salesmanNo=JKTZNJ0091&agentNo=JKTZNJ0091_20170313BJHL003&from=singlemessage&isappinstalled=0",@"event_id":@"touch_xinerfu",@"maxMoney":@"0.1"},@{@"title":@"2345贷款王",@"image":@"daikuan_2345",@"url":@"https://mdaikuan.2345.com/register3?channel=hj-yjdkw03_cpl_wlei",@"event_id":@"touch_2345",@"maxMoney":@"20"},@{@"title":@"宜人贷",@"image":@"daikuan_yiren",@"url":@"http://wap.yirendai.com/new/?siteId=2829&source=1",@"event_id":@"touch_yiren",@"maxMoney":@"10"},@{@"title":@"现金卡",@"image":@"daikuan_xianjinbaika",@"url":@"http://api.51ygdai.com/act/light-loan?source_tag=H5-yjdk3",@"event_id":@"touch_xianjinbaika",@"maxMoney":@"0.3"},@{@"title":@"拍拍贷",@"image":@"daikuan_paipai",@"url":@"https://m.invest.ppdai.com/landinginfonew.html?regsourceid=weimidaixianzhip03&role=1",@"event_id":@"touch_paipai",@"maxMoney":@"2"},@{@"title":@"好贷网",@"image":@"daikuan_haodaixinyongka",@"url":@"http://8.yun.haodai.com/?ref=hd_11016474",@"event_id":@"touch_haodaixinyongka",@"maxMoney":@"0.5"},@{@"title":@"手机贷",@"image":@"daikuan_shoujidai",@"url":@"http://sjd-m.mobanker.com/?channel=xedkw-llcs",@"event_id":@"touch_shoujidai",@"maxMoney":@"0.1"}];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onlineSetting"] boolValue]) {
        
    }
    else {
        UILabel *tableHeaderHeader = [[UILabel alloc] init];
        tableHeaderHeader.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 30);
        tableHeaderHeader.text = @"  请注意：本app不直接提供贷款，只提供贷款资讯和介绍  ";
        tableHeaderHeader.textColor = [UIColor grayColor];
        tableHeaderHeader.textAlignment = NSTextAlignmentCenter;
        tableHeaderHeader.adjustsFontSizeToFitWidth = YES;
        self.tableview.tableFooterView = tableHeaderHeader;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataSource.count > 3) {
        return self.dataSource.count + 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *indexRecommendCellIdentifier = @"indexRecommendCell";
        cell = [tableView dequeueReusableCellWithIdentifier:indexRecommendCellIdentifier];
        if (!cell) {
            cell = [[DKIndexRecommendTableViewCell alloc] initWithData:@[_dataSource[indexPath.row*2],_dataSource[indexPath.row*2+1]] withBlock:^(NSDictionary *product) {
                [MobClick event:product[@"event_id"]];
                DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:product[@"url"]];
                [self.navigationController pushViewController:webVC animated:YES];
            }];
        }
    }
    else {
        static NSString *indexTableViewCellIdentifier = @"indexTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
        
        if (!cell) {
            cell = [[DKIndexTableViewCell alloc] initWithData:_dataSource[indexPath.row - 2]];
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onlineSetting"] boolValue]) {
    [MobClick event:self.dataSource[indexPath.row - 2][@"event_id"]];
    DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:self.dataSource[indexPath.row - 2][@"url"]];
    [self.navigationController pushViewController:webVC animated:YES];
    //}
    //    else {
    //        DKIndexDetailViewController *indexDetailVC = [[DKIndexDetailViewController alloc] initWithData:self.dataSource[indexPath.row - 2]];
    //        [self.navigationController pushViewController:indexDetailVC animated:YES];
    //    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth([UIScreen mainScreen].bounds)/4;
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
