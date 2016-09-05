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
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    self.gotoInitPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gotoInitPageButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 54 - 15, CGRectGetHeight(self.view.frame) - 54 - 49 - 15, 54, 54);
    [self.gotoInitPageButton setBackgroundImage:[UIImage imageNamed:@"go_home"] forState:UIControlStateNormal];
    [self.gotoInitPageButton addTarget:self action:@selector(webviewGoback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.gotoInitPageButton];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@",request.URL);
    
    if ([request.URL.description hasPrefix:@"http://"] || [request.URL.description hasPrefix:@"https://"]) {
        return YES;
    }
    else {
        return NO;
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
