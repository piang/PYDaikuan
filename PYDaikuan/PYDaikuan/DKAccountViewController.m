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
@property (strong, nonatomic) NSArray <NSArray *> *dataSource;

@end

@implementation DKAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"个人信息";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] == nil) {
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 161)];
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.view.frame), 15)];
        hintLabel.textColor = [UIColor grayColor];
        hintLabel.textAlignment = NSTextAlignmentCenter;
        hintLabel.font = [UIFont systemFontOfSize:15];
        hintLabel.text = @"---------   使用第三方账号登录   ---------";
        [footerView addSubview:hintLabel];
        
        NSString *platformName = nil;
        NSString *iconName = nil;
        
        [UMSocialUIUtility configWithPlatformType:UMSocialPlatformType_WechatSession withImageName:&iconName withPlatformName:&platformName];
        UIButton *weChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        weChatButton.frame = CGRectMake(28, 53, 56, 56);
        [footerView addSubview:weChatButton];
        [weChatButton setBackgroundImage:[UMSocialUIUtility imageNamed:iconName] forState:UIControlStateNormal];
        weChatButton.tag = UMSocialPlatformType_WechatSession;
        [weChatButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [UMSocialUIUtility configWithPlatformType:UMSocialPlatformType_Sina withImageName:&iconName withPlatformName:&platformName];
        UIButton *sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sinaButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 28, 53, 56, 56);
        [footerView addSubview:sinaButton];
        [sinaButton setBackgroundImage:[UMSocialUIUtility imageNamed:iconName] forState:UIControlStateNormal];
        sinaButton.tag = UMSocialPlatformType_Sina;
        [sinaButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [UMSocialUIUtility configWithPlatformType:UMSocialPlatformType_QQ withImageName:&iconName withPlatformName:&platformName];
        UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qqButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 84, 53, 56, 56);
        [footerView addSubview:qqButton];
        [qqButton setBackgroundImage:[UMSocialUIUtility imageNamed:iconName] forState:UIControlStateNormal];
        qqButton.tag = UMSocialPlatformType_QQ;
        [qqButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView.tableFooterView = footerView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indexTableViewCellIdentifier = @"indexTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexTableViewCellIdentifier];
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (void)loginAction:(UIButton *)sender {
    
    __weak DKAccountViewController *ws = self;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface getUserInfoWithPlattype:ws.authInfo.platform viewController:self completion:^(id result, NSError * error) {
#else
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:sender.tag currentViewController:self completion:^(id result, NSError *error) {
#endif
            
            NSString *message = nil;
            
            if (error) {
                message = [NSString stringWithFormat:@"Get info fail:\n%@", error];
                UMSocialLogInfo(@"Get info fail with error %@",error);
            }else{
                if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
                    
                    UMSocialUserInfoResponse *resp = result;
                    
                    ws.dataSource = @[@[@{@"iconurl":resp.iconurl},@{@"name":resp.name},@{@"gender":resp.gender}]];
                    
                    [ws.tableView reloadData];
                    
                }else{
                    message = @"Get info fail";
                }
            }
        }];
        
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
