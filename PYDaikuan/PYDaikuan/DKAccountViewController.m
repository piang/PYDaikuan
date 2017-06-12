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
#import "DKNewsViewController.h"
#import "DKLoginViewController.h"
#import "DKRealNameViewController.h"

@interface DKAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <NSArray *> *dataSource;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIButton *loginButton;

@end

@implementation DKAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"个人信息";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.dataSource = @[@[@{@"title":@"收藏"},@{@"title":@"我要借钱"}]];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] == nil) {
        self.tableView.tableFooterView = self.footerView;
    }
    else {
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)headerView {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 125)];
    _headerView.backgroundColor = [UIColor colorWithRed:153/255.0 green:1 blue:1 alpha:1];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"iconurl"]] placeholderImage:[UIImage imageNamed:@"default_head_icon"]];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [loginButton setTitleColor:[UIColor colorWithRed:25/255.0 green:66/255.0 blue:16/255.0 alpha:1] forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame) + 25, 0, 200, 200);
    [loginButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    loginButton.center = CGPointMake(loginButton.center.x, iconImageView.center.y);
    [loginButton addTarget:self action:@selector(userLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] == nil) {
        [loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        loginButton.enabled = YES;
    }
    else {
        [loginButton setTitle:[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"][@"name"] isEqualToString:@""] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"][@"name"]: [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"][@"mobile"] forState:UIControlStateNormal];
        loginButton.enabled = NO;
    }
    _loginButton = loginButton;
    
    [_headerView addSubview:iconImageView];
    [_headerView addSubview:loginButton];
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 161)];
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.view.frame), 15)];
        hintLabel.textColor = [UIColor grayColor];
        hintLabel.textAlignment = NSTextAlignmentCenter;
        hintLabel.font = [UIFont systemFontOfSize:15];
        hintLabel.text = @"---------   使用第三方账号登录   ---------";
        [_footerView addSubview:hintLabel];
        
        NSString *platformName = nil;
        NSString *iconName = nil;
        
        [UMSocialUIUtility configWithPlatformType:UMSocialPlatformType_Renren withImageName:&iconName withPlatformName:&platformName];
        UIButton *renrenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        renrenButton.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 112)/3 , 53, 56, 56);
        [_footerView addSubview:renrenButton];
        [renrenButton setBackgroundImage:[UMSocialUIUtility imageNamed:iconName] forState:UIControlStateNormal];
        renrenButton.tag = UMSocialPlatformType_Renren;
        [renrenButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [UMSocialUIUtility configWithPlatformType:UMSocialPlatformType_QQ withImageName:&iconName withPlatformName:&platformName];
        UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qqButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - (CGRectGetWidth(self.view.frame) - 112)/3 - 56, 53, 56, 56);
        [_footerView addSubview:qqButton];
        [qqButton setBackgroundImage:[UMSocialUIUtility imageNamed:iconName] forState:UIControlStateNormal];
        qqButton.tag = UMSocialPlatformType_QQ;
        [qqButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;//section头部高度
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indexTableViewCellIdentifier = @"accountTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexTableViewCellIdentifier];
        
        cell.textLabel.text = _dataSource[indexPath.section][indexPath.row][@"title"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 80.0f;
    }
    
    return 45.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] == nil) {
        [self userLoginAction:nil];
    }
    else {
        
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[DKNewsViewController alloc] initWithType:1] animated:YES];
        }
        else {
            [self.navigationController pushViewController:[[DKRealNameViewController alloc] init] animated:YES];
        }
    }
}

- (void)userLoginAction:(UIButton *)sender {
    
    DKLoginViewController *loginVC = [[DKLoginViewController alloc] init];
    loginVC.callback = ^(NSString *phoneNumber){
        [[NSUserDefaults standardUserDefaults] setObject:@{@"iconurl":@"",@"name":@"",@"phone":phoneNumber,@"gender":@""} forKey:@"userInfo"];
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.tableHeaderView = self.headerView;
        [self.tableView reloadData];
    };
    
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
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
                    
                    ws.dataSource = @[@[@{@"title":@"收藏"},@{@"title":@"我要借钱"}]];
                    [[NSUserDefaults standardUserDefaults] setObject:@{@"iconurl":resp.iconurl,@"name":resp.name,@"gender":resp.gender} forKey:@"userInfo"];
                    
                    ws.tableView.tableFooterView = [[UIView alloc] init];
                    
                    ws.tableView.tableHeaderView = ws.headerView;
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
