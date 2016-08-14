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

@end

@implementation DKIndexViewController

extern bool onlineSetting;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indexTableViewCellIdentifier = @"indexTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexTableViewCellIdentifier];
    }
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (onlineSetting) {
        DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:@"https://www.baidu.com"];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    }
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
