//
//  DKRealNameViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/6/12.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKRealNameViewController.h"
#import "AVUser.h"
#import <AVOSCloud/AVOSCloud.h>

@interface DKRealNameViewController ()
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *idCard;
@property (weak, nonatomic) IBOutlet UITextField *nameInputTextField;
@property (weak, nonatomic) IBOutlet UITextField *idCardInputTextField;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation DKRealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.nameInputTextField addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.idCardInputTextField addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.commitButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)commitAction:(id)sender {
    [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] setObject:self.name forKey:@"name"];
    
    [AVOSCloud setApplicationId:@"XpuV4q5fN2hj9hGr4CwzYvHO-gzGzoHsz" clientKey:@"vOcE9YRm4PLFdxv3GYrnkTVb"];
    AVObject *realUser = [AVObject objectWithClassName:@"User_RealName"];
    [realUser setObject:self.name forKey:@"name"];
    [realUser setObject:self.idCard forKey:@"idCard"];
    [realUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
           [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] setObject:self.idCard forKey:@"idCard"];
            [SVProgressHUD showWithStatus:@"提交成功，等待审核!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
    
}

- (void)passConTextChange:(UITextField *)textField{
    if (textField.tag == 25) {
        self.name = textField.text;
        
        if (self.idCard.length > 0 && self.name.length > 0) {
            
            self.commitButton.enabled = [self IsIdentityCard:self.idCard];
        }
        else {
            self.commitButton.enabled = NO;
        }
        
    }
    else {
        self.idCard = textField.text;
        
        if (self.idCard.length > 0 && self.name.length > 0) {
            self.commitButton.enabled = [self IsIdentityCard:self.idCard];
        }
        else {
            self.commitButton.enabled = NO;
        }
    }
}

- (BOOL) IsIdentityCard:(NSString *)IDCardNumber
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
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
