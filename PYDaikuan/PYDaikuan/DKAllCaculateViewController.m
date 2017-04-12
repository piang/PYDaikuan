//
//  DKAllCaculateViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/13.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKAllCaculateViewController.h"
#import "DKCaculateViewController.h"
#import "DKPersonalTaxViewController.h"

@interface DKAllCaculateViewController ()

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UIView *caculateView;
@property (strong, nonatomic) UIView *personalTaxView;

@end

@implementation DKAllCaculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"计算器";
    
    self.dataSource = @[@"贷款计算器",@"个税计算器"];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:self.dataSource];
    segment.frame = CGRectMake(15, 15 + CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]), CGRectGetWidth(self.view.frame) - 30, 30);
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    DKCaculateViewController *caculateVC = [[DKCaculateViewController alloc] init];
    [self addChildViewController:caculateVC];
    self.caculateView = caculateVC.view;
    self.caculateView.frame = CGRectMake(0, CGRectGetMaxY(segment.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    DKPersonalTaxViewController *personalTaxVC = [[DKPersonalTaxViewController alloc] init];
    [self addChildViewController:personalTaxVC];
    self.personalTaxView = personalTaxVC.view;
    self.personalTaxView.frame = CGRectMake(0, CGRectGetMaxY(segment.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    [segment setSelectedSegmentIndex:0];
    [self.view addSubview:self.caculateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentChange:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.personalTaxView removeFromSuperview];
        [self.view addSubview:self.caculateView];
    }
    else if (sender.selectedSegmentIndex == 1) {
        [self.caculateView removeFromSuperview];
        [self.view addSubview:self.personalTaxView];
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
