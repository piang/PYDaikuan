//
//  DKWebViewController.m
//  PYDaikuan
//
//  Created by piang on 16/8/14.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKWebViewController.h"

@interface DKWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) UIButton *gotoInitPageButton;

@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation DKWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, -40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 40)];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15]];
    
    self.gotoInitPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gotoInitPageButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 54 - 15, CGRectGetHeight(self.view.frame) - 54 - 49 - 15, 54, 54);
    [self.gotoInitPageButton setBackgroundImage:[UIImage imageNamed:@"go_home"] forState:UIControlStateNormal];
    [self.gotoInitPageButton addTarget:self action:@selector(webviewGoback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.gotoInitPageButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightItemAction:)];
    
    self.alertController = [UIAlertController alertControllerWithTitle:@"" message:@"选择操作" preferredStyle:UIAlertControllerStyleActionSheet];
    
//    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }];
    
    UIAlertAction *collectAction = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"colletArticles"];
        
        if (dataSource == nil) {
            dataSource = [[NSMutableArray alloc] initWithCapacity:5];
        }
        
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *DateTime = [formatter stringFromDate:date];
        
        [dataSource addObject:@{@"title":[self.webview stringByEvaluatingJavaScriptFromString:@"document.title"],@"url":_url,@"CTIME":DateTime}];
        [[NSUserDefaults standardUserDefaults] setObject:dataSource forKey:@"colletArticles"];

    }];
    
    UIAlertAction *refreshAction = [UIAlertAction actionWithTitle:@"刷新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.webview reload];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //[self.alertController addAction:shareAction];
    [self.alertController addAction:collectAction];
    [self.alertController addAction:refreshAction];
    [self.alertController addAction:cancelAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webviewGoback {
    if ([self.webview canGoBack]) {
        [self.webview goBack];
        if ([self.webview.request.URL.description isEqualToString:self.url]) {
            [self.gotoInitPageButton setBackgroundImage:[UIImage imageNamed:@"go_home"] forState:UIControlStateNormal];
        }
        else {
            [self.gotoInitPageButton setBackgroundImage:[UIImage imageNamed:@"go_back"] forState:UIControlStateNormal];
        }
    }
    else {
        [self.gotoInitPageButton setBackgroundImage:[UIImage imageNamed:@"go_home"] forState:UIControlStateNormal];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = theTitle;
    
    if ([self.webview.request.URL.description isEqualToString:self.url]) {
        [self.gotoInitPageButton setBackgroundImage:[UIImage imageNamed:@"go_home"] forState:UIControlStateNormal];
    }
    else {
        [self.gotoInitPageButton setBackgroundImage:[UIImage imageNamed:@"go_back"] forState:UIControlStateNormal];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@\n点击右上角按钮刷新",error.userInfo[@"NSLocalizedDescription"]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@",request.URL);
    
    if ([request.URL.description hasPrefix:@"http://"] || [request.URL.description hasPrefix:@"https://"]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)rightItemAction:(UIButton *)sender {
    [self presentViewController:self.alertController animated:YES completion:^{
        
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
