//
//  MRUserLoginVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/11.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserLoginVC.h"
#import "MRUserLoginView.h"
#import "MRUserRegisterOneVC.h"
#import "MRUserCodeLoginVC.h"
#import "MRChangePhoneCodeVC.h"
#import "MRUserLoginModel.h"
#import "MRBaseTabBarController.h"
@interface MRUserLoginVC ()

@end

@implementation MRUserLoginVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *arrViewControllers = self.navigationController.viewControllers;
    if (arrViewControllers.count == 1) {
        self.leftButton.hidden = YES;
    }else{
        self.leftButton.hidden = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI {
    self.titleLabel.text = @"登录";
    self.navigationView.hidden = YES;
    MRUserLoginView * loginView = [[MRUserLoginView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.view addSubview:loginView];
    loginView.codeBtnBlock = ^(NSString *id) {
        MRUserCodeLoginVC * vc = [MRUserCodeLoginVC new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    loginView.loginBtnBlock = ^(NSString *phoneStr, NSString *pwdStr) {
          [MRProgressHUD show:@"登录中..." inView:self.view];
            NSDictionary * dic = @{@"mobile":phoneStr,@"password":pwdStr};
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MRProgressHUD hide];
            
        });
//            [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kAuth withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//                NSDictionary * dict = model.data;
//                if ([model.state integerValue]==0) {
//                    [[NSUserDefaults standardUserDefaults] setObject:phoneStr forKey:@"mobile"];
//                    MRUserLoginModel * model = [MRUserLoginModel modelWithDictionary:dict];
//                    [MRUserLoginModel saveAccount:model];
//                    [[MRBaseTabBarController shardManager] setTabBarItem];
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }else{
//                    [MRProgressHUD showMessage:model.msg inView:self.view];
//                }
//   
//            } withFailureBlock:^(NSError *error) {
//
//            } progress:^(float progress) {
//
//            }];
    };
    loginView.regBtnBlock = ^(NSString *id) {
        MRUserRegisterOneVC * vc = [MRUserRegisterOneVC new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"忘记密码" forState:(UIControlStateNormal)];


    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         MRChangePhoneCodeVC * vc = [MRChangePhoneCodeVC new];
         vc.type = EntryCodeTypeForgetPwd;
         [self.navigationController pushViewController:vc animated:YES];
     }];
    



}
@end
