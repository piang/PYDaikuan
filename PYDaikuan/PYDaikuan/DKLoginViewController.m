//
//  DKLoginViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/6/5.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKLoginViewController.h"
#import "AVUser.h"

@interface DKLoginViewController ()

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *password;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (nonatomic, assign) NSInteger timeout;
@property (strong, nonatomic) dispatch_source_t timer;//定时器

@end

@implementation DKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.phoneNumberTextField addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.loginButton.enabled = NO;
    
    self.timeout = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginButton:(id)sender {
    [AVUser verifyMobilePhone:self.password withBlock:^(BOOL succeeded, NSError *error) {
        //验证结果
        if (succeeded) {
            self.callback(self.phoneNumber);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}
- (IBAction)verificationCodeAction:(id)sender {
    if (self.phoneNumber.length >= 11) {
        
        AVUser *user = [AVUser user];
        user.mobilePhoneNumber = self.phoneNumber;
        user.username = @"test";
        user.password = @"test";
        NSError *error = nil;
        
        if ([user signUp:&error]) {
            [self countDownTime];
        }
        else {
//            if (error.code == 214) {
//                [AVUser requestMobilePhoneVerify:self.phoneNumber withBlock:^(BOOL succeeded, NSError *error) {
//                    if(succeeded){
//                        [self countDownTime];
//                    }
//                    else {
//                        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
//                    }
//                }];
//            }
//            else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            //}
        }
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"手机号不正确哦~"];
    }
}

- (void)countDownTime {
    self.verificationCodeButton.enabled = NO;
    self.timeout = 60;
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建timer
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatchQueue);
    //使用dispatch_source_set_timer函数设置timer参数
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    //设置回调
    dispatch_source_set_event_handler(_timer, ^{
        if (self.timeout > 0) {
            self.timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.verificationCodeButton setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)self.timeout] forState:UIControlStateNormal];
            });
        } else {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.verificationCodeButton.enabled = YES;
                [self.verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
            
        }
    });
    dispatch_resume(_timer);//开始执行
}

- (void)passConTextChange:(UITextField *)textField{
    if (textField.tag == 23) {
        self.phoneNumber = textField.text;
        
        if (self.password.length > 0 && self.phoneNumber.length >= 11) {
            self.loginButton.enabled = YES;
        }
        else {
            self.loginButton.enabled = NO;
        }
        
    }
    else {
        self.password = textField.text;
        
        if (self.password.length > 0 && self.phoneNumber.length >= 11) {
            self.loginButton.enabled = YES;
        }
        else {
            self.loginButton.enabled = NO;
        }
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
