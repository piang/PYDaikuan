//
//  DKNewsViewController.m
//  PYDaikuan
//
//  Created by piang on 16/8/14.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKNewsViewController.h"
#import "DKWebViewController.h"

@interface DKNewsViewController ()<UITableViewDelegate, UITableViewDataSource,NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation DKNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"贷款咨询";
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.loan.app887.com/api/Articles.action?keyword=&opc=20&type=%E8%B4%B7%E6%AC%BE%E8%B5%84%E8%AE%AF&uid=658549&npc=0"]];
    request.timeoutInterval = 15.0;
    request.HTTPMethod = @"POST";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"%@",responseDic);
        
        _dataSource = responseDic[@"root"][@"list"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
        });
    }];
    
    [postDataTask resume];
    
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
    
    static NSString *newsTableViewCellIdentifier = @"newsTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:newsTableViewCellIdentifier];
    }
    cell.textLabel.text = _dataSource[indexPath.row][@"title"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.text = _dataSource[indexPath.row][@"CTIME"];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    UIImage *pic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_dataSource[indexPath.row][@"imglink"]]]];
    
    UIImageView *recommandIV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame) - 112, 0, 112, 63)];
    recommandIV.image = pic;
    cell.accessoryView = recommandIV;
    
    return cell;
    
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
