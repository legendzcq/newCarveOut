//
//  MRUserChangeInfoVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/8/1.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserChangeInfoVC.h"

@interface MRUserChangeInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UILabel *centerLab;
@property (weak, nonatomic) IBOutlet UITextField *entryInfoField;

@end

@implementation MRUserChangeInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightButton.hidden = NO;
    self.titleLabel.text = @"设置昵称";
    [self.rightButton setTitleColor:kMainBtnColor forState:(UIControlStateNormal)];
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    if (self.infoType == ChangeInfoTypeEmail) {
        self.titleLabel.text = @"设置邮箱";
        self.topLab.text = @"请输入您的邮箱";
        self.centerLab.text = @"邮箱";
        self.entryInfoField.placeholder = @"请输入邮箱";
        self.entryInfoField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    self.entryInfoField.text = self.string;
    [[self.rightButton rac_signalForControlEvents:(UIControlEventTouchUpInside)]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         [MRProgressHUD show:kLoadingText inView:self.view];
         if (self.infoType == ChangeInfoTypeName) {
             //设置姓名
             [self updateRealName];
         }else{
             //设置邮箱
             [self updateEmail];
         }
    }];
    
}
- (void)updateRealName{
    if (![NSString validateNickName:self.entryInfoField.text]) {
        [MRProgressHUD showMessage:@"请输入正确的昵称" inView:self.view];
        return;
    }
    NSDictionary * dic = @{@"userName":self.entryInfoField.text};
//    [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kUserUpdateNickname withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//            [self.navigationController popViewControllerAnimated:YES];
//            if (self.businessDidFinsh) {
//                self.businessDidFinsh(model.data);
//            }
//        [[NSNotificationCenter defaultCenter] postNotificationName:kPersonInfoNotification object:nil];
//    }];
}
- (void)updateEmail{
    if (![NSString validateEmail:self.entryInfoField.text]) {
        [MRProgressHUD showMessage:@"请输入正确的邮箱" inView:self.view];
        return;
    }
    NSDictionary * dic = @{@"email":self.entryInfoField.text};
//    [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kUserUpdateEmail withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//            [self.navigationController popViewControllerAnimated:YES];
//            if (self.businessDidFinsh) {
//                self.businessDidFinsh(model.data);
//            }
//        [[NSNotificationCenter defaultCenter] postNotificationName:kPersonInfoNotification object:nil];
//    }];
}


@end
