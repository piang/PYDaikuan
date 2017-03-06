//
//  DKAccountViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/6.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKAccountViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UMSocialUIUtility.h>

@interface DKAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation DKAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"个人信息";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] == nil) {
        
        NSString *platformName = nil;
        NSString *iconName = nil;
        [UMSocialUIUtility configWithPlatformType:UMSocialPlatformType_WechatSession withImageName:&iconName withPlatformName:&platformName];
        
        self.tableView.tableFooterView = [[UIImageView alloc] initWithImage:[UMSocialUIUtility imageNamed:iconName]];
    }
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
    
    return cell;
    
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
