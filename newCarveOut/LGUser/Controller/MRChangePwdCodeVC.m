//
//  MRChangePwdCodeVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/8/1.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRChangePwdCodeVC.h"
#import "MRChangePwdCodeNewVC.h"
#import "MRChangePhoneCodeVC.h"
#import "CQCountDownButton.h"
@interface MRChangePwdCodeVC ()
@property (weak, nonatomic) IBOutlet UITextField *iphoneCodeField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIView *backVIew;
@property (weak, nonatomic) IBOutlet CQCountDownButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *telLbael;

@property (nonatomic,copy)NSString * iphoneNum;

@end

@implementation MRChangePwdCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.telLbael.text = kMobile;
    if (self.entryType == EntryCodeTypeChangePwd) {
        self.titleLabel.text = @"修改密码";
    }else{
        self.titleLabel.text = @"修改手机号";
    }
    
    self.bottomLine.hidden = NO;
    self.nextBtn.layer.cornerRadius = 22;
    [_codeBtn initxibWithDuration:60 buttonClicked:^{
        if (![NSString validateMobile:self.telLbael.text]) {
            [MRProgressHUD showMessage:@"请输入正确的手机号" inView:self.view];
            [self.iphoneCodeField becomeFirstResponder];
            [self.codeBtn setEnabled:YES];
            return;
        }
        NSDictionary * dic = @{@"mobile":kMobile,@"smsType":@"mobile"};
//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kSendSmsCode(kMobile) withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//            [self.codeBtn startCountDown];
//        }];
        
    } countDownStart:^{
        
    } countDownUnderway:^(NSInteger restCountDownNum) {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%ldS", restCountDownNum] forState:UIControlStateNormal];
    } countDownCompletion:^{
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
    self.codeBtn.layer.cornerRadius = 12;
    self.codeBtn.layer.borderColor = kMainBtnColor.CGColor;
    self.codeBtn.layer.borderWidth = 1;
    
    [[self.iphoneCodeField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
}
- (IBAction)nextBtnClick:(id)sender {
    if (self.entryType == EntryCodeTypeChangePhone) {
        NSDictionary * dic = @{@"mobile":kMobile,@"smsType":@"mobile",@"smsCode":self.iphoneCodeField.text};
//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kVerifySendSmsCode(kMobile) withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//            MRChangePhoneCodeVC * vc = [MRChangePhoneCodeVC new];
//            [self.navigationController pushViewController:vc animated:YES];
//        }];
    }else if (self.entryType == EntryCodeTypeChangePwd){
        NSDictionary * dic = @{@"mobile":kMobile,@"smsType":@"password",@"smsCode":self.iphoneCodeField.text};
//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kVerifySendSmsCode(kMobile) withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//            MRChangePwdCodeNewVC * vc = [MRChangePwdCodeNewVC new];
//            [self.navigationController pushViewController:vc animated:YES];
//        }];

    }else{
        
    }

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.backVIew.frame  = CGRectMake(0, kNaviBarHeight+5, kWidth, 300);
}

-(void)changeCommitenabled{
    if (self.iphoneCodeField.text.length > 5) {
        self.nextBtn.enabled = YES;
        self.nextBtn.backgroundColor =kBtnColor;
    }else{
        self.nextBtn.enabled = NO;
        self.nextBtn.backgroundColor =kCommitBtnColor;
    }
}

@end
