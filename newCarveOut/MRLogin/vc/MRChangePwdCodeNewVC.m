//
//  MRChangePwdCodeNewVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/8/1.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRChangePwdCodeNewVC.h"

@interface MRChangePwdCodeNewVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewField;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewAgainField;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation MRChangePwdCodeNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commitBtn.layer.cornerRadius = 22;
    if (self.type == EntryCodeTypeForgetPwd) {
        self.titleLabel.text = @"忘记密码";
    }else{
        self.titleLabel.text = @"修改密码";
    }
    [[self.pwdNewField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    [[self.pwdNewAgainField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {

    }];
}
- (IBAction)commitBtnClick:(id)sender {
    if ([NSString validatePassword:self.pwdNewField.text] && [NSString validatePassword:self.pwdNewAgainField.text]) {
        if ([NSString validatePassword:self.pwdNewField.text] != [NSString validatePassword:self.pwdNewAgainField.text]) {
            [MRProgressHUD showMessage:@"两次密码输入不一致" inView:self.view];
        }else{
            NSDictionary * dic = @{@"password":self.pwdNewField.text,@"verifyPassword":self.pwdNewAgainField.text};
//            [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kUserUpdatePassword withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//                [MRProgressHUD showMessage:@"修改密码成功" inView:self.view];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                });
//            }];

        }
    }else{
        [MRProgressHUD showMessage:@"密码格式错误,应为6-16位字母数字组成" inView:self.view];
    }
}

- (IBAction)newBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    BOOL isSelect = btn.isSelected;
    [btn setSelected:!isSelect];
    [_pwdNewField setSecureTextEntry:isSelect];
}
- (IBAction)againBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    BOOL isSelect = btn.isSelected;
    [btn setSelected:!isSelect];
    [_pwdNewAgainField setSecureTextEntry:isSelect];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.backView.frame  = CGRectMake(0, kNaviBarHeight, kWidth, 300);
    
}

-(void)changeCommitenabled{
    if ([NSString validatePassword:self.pwdNewField.text]) {
        self.commitBtn.enabled = YES;
        self.commitBtn.backgroundColor =kMainBtnColor;
    }else{
        self.commitBtn.enabled = NO;
        self.commitBtn.backgroundColor =kCommitBtnColor;
    }
}
@end
