//
//  DKWebViewController.m
//  PYDaikuan
//
//  Created by piang on 16/8/14.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKWebViewController.h"

@interface DKWebViewController ()

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, strong) NSString *url;

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
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webview];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    UIButton *gotoInitPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoInitPageButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 200, CGRectGetHeight(self.view.frame) - 200, 100, 100);
    gotoInitPageButton.backgroundColor = [UIColor redColor];
    [gotoInitPageButton addTarget:self action:@selector(webviewGoback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gotoInitPageButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webviewGoback {
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }
//    else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
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
