//
//  DKPersonalTaxViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/1/9.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKPersonalTaxViewController.h"

@interface DKPersonalTaxViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSString *incomeMoney;
@property (assign, nonatomic) float incomeAfterTaxMoney;
@property (assign, nonatomic) float taxMoney;
@property (assign, nonatomic) float oldAgeMoney;
@property (assign, nonatomic) float medicalMoney;
@property (assign, nonatomic) float unemploymentMoney;
@property (assign, nonatomic) float housingMoney;

@end

@implementation DKPersonalTaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"个人所得税计算器";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 80)];
    
    self.dataSource = @[@[@{@"title":@"月薪(元):",@"placeholder":@"请输入月薪"}],@[@{@"title":@"税后工资(元):"},@{@"title":@"个人所得税扣除(元):"},@{@"title":@"养老保险金(元):"},@{@"title":@"医疗保险金(元):"},@{@"title":@"失业保险金(元):"},@{@"title":@"住房公积金(元):"}]];
    
    UIButton *startCaculateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startCaculateButton setTitle:@"开始计算" forState:UIControlStateNormal];
    startCaculateButton.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 40);
    startCaculateButton.backgroundColor = [UIColor whiteColor];
    [startCaculateButton addTarget:self action:@selector(startCaculateAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:startCaculateButton];
    
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        UITextField *inputTextField = [[UITextField alloc] init];
        inputTextField.textAlignment = NSTextAlignmentRight;
        inputTextField.placeholder = _dataSource[indexPath.section][indexPath.row][@"placeholder"];
        inputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        inputTextField.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) / 2, 40);
        [inputTextField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
        inputTextField.text = self.incomeMoney;
        
        cell.accessoryView = inputTextField;
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = (self.incomeAfterTaxMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.incomeAfterTaxMoney] : @"";
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = (self.taxMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.taxMoney] : @"";
        }
        else if (indexPath.row == 2) {
            cell.detailTextLabel.text = (self.oldAgeMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.oldAgeMoney] : @"";
        }
        else if (indexPath.row == 3) {
            cell.detailTextLabel.text = (self.medicalMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.medicalMoney] : @"";
        }
        else if (indexPath.row == 4) {
            cell.detailTextLabel.text = (self.unemploymentMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.unemploymentMoney] : @"";
        }
        else if (indexPath.row == 5) {
            cell.detailTextLabel.text = (self.housingMoney > 0) ? [NSString stringWithFormat:@"%.2f",self.housingMoney] : @"";
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)startCaculateAction:(UIButton *)sender {
    
    float tmpIncomeMoney = [self.incomeMoney floatValue];
    
    self.oldAgeMoney = tmpIncomeMoney * 0.08;
    self.medicalMoney = tmpIncomeMoney * 0.02 + 3;
    self.housingMoney = tmpIncomeMoney * 0.12 < 2327 ? tmpIncomeMoney * 0.12 : 2327;
    self.unemploymentMoney = tmpIncomeMoney * 0.002;
    
    float tmpPersonalIncomeBeforeTaxMoney = tmpIncomeMoney * 0.778 - 3500;
    
    if (tmpPersonalIncomeBeforeTaxMoney <= 0) {
        self.taxMoney = 0;
    }
    else {
        if (tmpPersonalIncomeBeforeTaxMoney <= 1500) {
            self.taxMoney = tmpPersonalIncomeBeforeTaxMoney * 0.03;
        }
        else {
            if (tmpPersonalIncomeBeforeTaxMoney <= 4500) {
                self.taxMoney = tmpPersonalIncomeBeforeTaxMoney * 0.1 - 105;
            }
            else {
                if (tmpPersonalIncomeBeforeTaxMoney <= 9000) {
                    self.taxMoney = tmpPersonalIncomeBeforeTaxMoney * 0.2 - 555;
                }
                else {
                    if (tmpPersonalIncomeBeforeTaxMoney <= 35000) {
                        self.taxMoney = tmpPersonalIncomeBeforeTaxMoney * 0.25 - 1005;
                    }
                    else {
                        if (tmpPersonalIncomeBeforeTaxMoney <= 55000) {
                            self.taxMoney = tmpPersonalIncomeBeforeTaxMoney * 0.3 - 2755;
                        }
                        else {
                            if (tmpPersonalIncomeBeforeTaxMoney <= 80000) {
                                self.taxMoney = tmpPersonalIncomeBeforeTaxMoney * 0.35 - 5505;
                            }
                            else {
                                self.taxMoney = tmpPersonalIncomeBeforeTaxMoney * 0.45 - 13505;
                            }
                        }
                    }
                }
            }
        }
    }
    self.incomeAfterTaxMoney = tmpIncomeMoney * 0.898 - self.housingMoney - self.taxMoney;
    
    [self.tableView reloadData];
}

- (void)textFieldWithText:(UITextField *)textField {
    self.incomeMoney = textField.text;
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
