//
//  MRChangePwdOrgainVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/8/1.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRChangePwdOrgainVC.h"

@interface MRChangePwdOrgainVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *pwdOrgainField;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewField;
@property (weak, nonatomic) IBOutlet UITextField *pwdAgainField;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation MRChangePwdOrgainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = @"修改密码";
    self.commitBtn.layer.cornerRadius = 22;
    
    [[self.pwdOrgainField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    [[self.pwdNewField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    [[self.pwdAgainField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    
}

- (IBAction)commitBtnClick:(id)sender {
    if (![NSString validatePassword:self.pwdOrgainField.text] || ![NSString validatePassword:self.pwdNewField.text] ||![NSString validatePassword:self.pwdAgainField.text]) {
        [MRProgressHUD showMessage:@"密码格式错误" inView:self.view];
        return;
    }else if(self.pwdNewField.text != self.pwdAgainField.text){
        [MRProgressHUD showMessage:@"两次密码不相同" inView:self.view];
        return;
    }
    NSDictionary * dic = @{@"oldPassword":self.pwdOrgainField.text,@"password":self.pwdNewField.text,@"verifyPassword":self.pwdAgainField.text};
//    [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kUserUpdatePassword withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//        [MRProgressHUD showMessage:@"修改密码成功" inView:self.view];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//    }];
}

- (IBAction)OrgainBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    BOOL isSelect = btn.isSelected;
    [btn setSelected:!isSelect];
    [_pwdOrgainField setSecureTextEntry:isSelect];
}
- (IBAction)pwdNewBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    BOOL isSelect = btn.isSelected;
    [btn setSelected:!isSelect];
    [_pwdNewField setSecureTextEntry:isSelect];
}
- (IBAction)pwdAgainBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    BOOL isSelect = btn.isSelected;
    [btn setSelected:!isSelect];
    [_pwdAgainField setSecureTextEntry:isSelect];
}

-(void)changeCommitenabled{
    if (self.pwdOrgainField.text.length > 5   &&
        self.pwdNewField.text.length>5 &&
        self.pwdAgainField.text.length>5) {
        self.commitBtn.enabled = YES;
        self.commitBtn.backgroundColor =kMainBtnColor;
    }else{
        self.commitBtn.enabled = NO;
        self.commitBtn.backgroundColor =kCommitBtnColor;
    }
}
@end
