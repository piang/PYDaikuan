//
//  DKCaculateViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 16/12/31.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKCaculateViewController.h"

@interface DKCaculateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSString *loanTotalMoney;
@property (strong, nonatomic) NSString *loanMonth;
@property (strong, nonatomic) NSString *loanRate;
@property (assign, nonatomic) float payTotalInterests;
@property (assign, nonatomic) float payTotalMoney;
@property (assign, nonatomic) float payMonthMoney;

@end

@implementation DKCaculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"贷款计算器";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSource = @[@[@{@"title":@"贷款类型:",@"placeholder":@"商业贷款"},@{@"title":@"贷款金额(万元):",@"placeholder":@"0到9999万之间"},@{@"title":@"贷款期限(年):",@"placeholder":@"1到30年之间"},@{@"title":@"贷款利率(%):",@"placeholder":@"点击输入100以内"},@{@"title":@"还款方式:",@"placeholder":@"等额本息"}],@[@{@"title":@"累计支付利息(元):"},@{@"title":@"贷累计还款总额(元):"},@{@"title":@"每月还款(元):"}]];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 80)];
    
    UIButton *startCaculateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startCaculateButton setTitle:@"开始计算" forState:UIControlStateNormal];
    startCaculateButton.frame = CGRectMake(0, 20, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    startCaculateButton.backgroundColor = [UIColor whiteColor];
    [startCaculateButton addTarget:self action:@selector(startCaculateAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:startCaculateButton];
    
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataSource[section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *caculateTableViewCellIdentifier = @"caculateTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caculateTableViewCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:caculateTableViewCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row][@"title"];
    
    if (indexPath.section == 0) {
        if (indexPath.row > 0 && indexPath.row < 4) {
            UITextField *inputTextField = [[UITextField alloc] init];
            inputTextField.textAlignment = NSTextAlignmentRight;
            inputTextField.placeholder = _dataSource[indexPath.section][indexPath.row][@"placeholder"];
            inputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            inputTextField.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) / 2, 40);
            inputTextField.tag= indexPath.row;
            [inputTextField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
            
            if (indexPath.row == 1) {
                inputTextField.text = self.loanTotalMoney;
            }
            else if (indexPath.row == 2) {
                inputTextField.text = self.loanMonth;
            }
            else if (indexPath.row == 3) {
                inputTextField.text = self.loanRate;
            }
            
            cell.accessoryView = inputTextField;
        }
        else {
            cell.detailTextLabel.text = _dataSource[indexPath.section][indexPath.row][@"placeholder"];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = (self.payTotalInterests > 0) ? [NSString stringWithFormat:@"%.2f",self.payTotalInterests] : @"";
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = (self.payTotalMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.payTotalMoney] : @"";
        }
        else if (indexPath.row == 2) {
            cell.detailTextLabel.text = (self.payMonthMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.payMonthMoney] : @"";
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)startCaculateAction:(UIButton *)sender {
    
    float tmpLoanTotalMoney = [self.loanTotalMoney floatValue] * 10000.0;
    float tmpLoanMonth = [self.loanMonth floatValue] * 12.0;
    float tmpLoanRate = [self.loanRate floatValue] / 12 / 100;
    
    self.payMonthMoney = tmpLoanTotalMoney * tmpLoanRate * pow(1 + tmpLoanRate, tmpLoanMonth) / (pow(1 + tmpLoanRate, tmpLoanMonth) - 1);
    self.payTotalMoney = self.payMonthMoney * tmpLoanMonth;
    self.payTotalInterests = self.payTotalMoney - tmpLoanTotalMoney;
    
    [self.tableView reloadData];
}

- (void)textFieldWithText:(UITextField *)textField {
    if (textField.tag == 1) {
        self.loanTotalMoney = textField.text;
    }
    else if (textField.tag == 2) {
        self.loanMonth = textField.text;
    }
    else if (textField.tag == 3) {
        self.loanRate = textField.text;
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
