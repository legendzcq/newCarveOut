//
//  MRChangePhoneCodeVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/8/1.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRChangePhoneCodeVC.h"
#import "MRChangePwdCodeNewVC.h"
#import "CQCountDownButton.h"
@interface MRChangePhoneCodeVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeField;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet CQCountDownButton *phoneCodeBtn;

@end

@implementation MRChangePhoneCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commitBtn.layer.cornerRadius = 22;
    if (self.type == EntryCodeTypeForgetPwd) {
        self.titleLabel.text = @"忘记登录密码";
        [_commitBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    }else{
        self.titleLabel.text = @"设置新手机号";
    }
    [self sendAuthCode];

}
//发送验证码
- (void)sendAuthCode{
    [self.phoneCodeBtn initxibWithDuration:60 buttonClicked:^{
        if (![NSString validateMobile:self.phoneField.text]) {
            [MRProgressHUD showMessage:@"请输入正确的手机号" inView:self.view];
            [self.phoneField becomeFirstResponder];
            [self.phoneCodeBtn setEnabled:YES];
            return;
        }
        if (self.type == EntryCodeTypeForgetPwd) {
            self.titleLabel.text = @"忘记登录密码";
            [self.commitBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
            NSDictionary * dic = @{@"mobile":self.phoneField.text,@"smsType":@"forgetPassword"};
//            [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kSendSmsCode(kMobile) withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//                [self.phoneCodeBtn startCountDown];
//            }];
        }else{
            self.titleLabel.text = @"修改手机号";
            NSDictionary * dic = @{@"mobile":self.phoneField.text,@"smsType":@"mobile"};
//            [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kSendSmsCode(kMobile) withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//                [self.phoneCodeBtn startCountDown];
//            }];
        }
       
    } countDownStart:^{
        
    } countDownUnderway:^(NSInteger restCountDownNum) {
        [self.phoneCodeBtn setTitle:[NSString stringWithFormat:@"%ldS", restCountDownNum] forState:UIControlStateNormal];
    } countDownCompletion:^{
        [self.phoneCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
    _phoneCodeBtn.layer.borderColor = kMainBtnColor.CGColor;
    _phoneCodeBtn.layer.borderWidth = 1;
    _phoneCodeBtn.layer.cornerRadius = 12;
    [[self.phoneCodeField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    [[self.phoneCodeField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
}
- (IBAction)commitBtnClick:(id)sender {
    //修改登录密码
    if (self.type == EntryCodeTypeForgetPwd) {
        MRChangePwdCodeNewVC * vc = [MRChangePwdCodeNewVC new];
        vc.type = EntryCodeTypeForgetPwd;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //点击设置新手机号
        
//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kUserUpdateMobile withParaments:@{@"mobile":self.phoneField.text,@"phoneField":self.phoneCodeField.text} withSuccessBlock:^(MRRequsetInfoModel *model) {
//            [[NSUserDefaults standardUserDefaults] setObject:self.phoneField.text forKey:@"mobile"];
//            [self setNavigationControllersWithVC:@"MRChangePwdCodeVC"];
//            [MRProgressHUD showMessage:@"设置新手机号成功" inView:self.view];
//            [self.navigationController popViewControllerAnimated:YES];
//            [[NSNotificationCenter defaultCenter] postNotificationName:kPersonInfoNotification object:nil];
//        }];
        
    }
}
-(void)changeCommitenabled
{
    if (self.phoneField.text.length > 0   &&
        self.phoneCodeField.text.length>0) {
        self.commitBtn.enabled = YES;
        self.commitBtn.backgroundColor =kMainBtnColor;
    }else
    {
        
        self.commitBtn.enabled = NO;
        self.commitBtn.backgroundColor =kCommitBtnColor;
    }
    
}

@end
