//
//  DKNewsViewController.m
//  PYDaikuan
//
//  Created by piang on 16/8/14.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKNewsViewController.h"
#import "DKWebViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DKNewsTableViewCell.h"
#import "DKNewsSeparateTableViewCell.h"

@interface DKNewsViewController ()<UITableViewDelegate, UITableViewDataSource,NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) int pageNo;
@property (strong, nonatomic) NSArray *bannerDataSource;

@end

@implementation DKNewsViewController

- (instancetype)initWithType:(int)type {
    if (self = [super init]) {
        if (type == 0) {
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.loan.app887.com/api/Articles.action?keyword=&opc=10&type=%E8%B4%B7%E6%AC%BE%E8%B5%84%E8%AE%AF&uid=658549&npc=0"]];
            request.timeoutInterval = 15.0;
            request.HTTPMethod = @"POST";
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            
            NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSLog(@"%@",responseDic);
                
                _dataSource = responseDic[@"root"][@"list"];
                
                _bannerDataSource = @[responseDic[@"root"][@"list"][0][@"imglink"],responseDic[@"root"][@"list"][1][@"imglink"],responseDic[@"root"][@"list"][2][@"imglink"]];
                
                SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150) imageURLStringsGroup:_bannerDataSource];
                cycleScrollView.titlesGroup = @[responseDic[@"root"][@"list"][0][@"title"],responseDic[@"root"][@"list"][1][@"title"],responseDic[@"root"][@"list"][2][@"title"]];
                cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
                cycleScrollView.clickItemOperationBlock = ^(NSInteger index){
                    DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:_dataSource[index][@"url"]];
                    [self.navigationController pushViewController:webVC animated:YES];
                };
                
                _tableview.tableHeaderView = cycleScrollView;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableview reloadData];
                });
            }];
            
            [postDataTask resume];
        }
        else {
            _dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"colletArticles"];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"贷款咨询";
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
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
    
    if (indexPath.row % 3 == 0) {
        DKNewsSeparateTableViewCell *cell = [DKNewsSeparateTableViewCell cellWithTableView:tableView];
        cell.data = _dataSource[indexPath.row];
        return cell;
    }
    else {
        DKNewsTableViewCell *cell = [DKNewsTableViewCell cellWithTableView:tableView];
        cell.data = _dataSource[indexPath.row];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:_dataSource[indexPath.row][@"url"]];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
