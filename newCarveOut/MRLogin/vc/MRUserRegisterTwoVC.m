//
//  MRUserRegisterTwoVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/11.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserRegisterTwoVC.h"
#import "MRUserRegisterTwoView.h"
#import "MRUserLoginVC.h"
@interface MRUserRegisterTwoVC ()

@end

@implementation MRUserRegisterTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self setupUI];
}

-(void)setupUI {
    self.titleLabel.text = @"手机号注册";
    MRUserRegisterTwoView * regView = [[MRUserRegisterTwoView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kWidth, kHeight-kNaviBarHeight)];
    
    [self.view addSubview:regView];
    regView.loginBtnBlock = ^(NSString *id) {
        MRUserLoginVC * loginVC = [[MRUserLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    };
    regView.registBlock = ^(NSString *pwdStr, NSString *pwdAgainStr) {

        
        NSDictionary * dic = @{@"mobile":self.phoneStr,@"password":pwdStr};

//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kRegist withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//            
//            [MRProgressHUD shssage:@"注册成功" inView:self.view];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                for (MRBaseViewController * obj in self.navigationController.viewControllers) {
//                    if ([obj isKindOfClass:[MRUserLoginVC class]]) {
//                        [self.navigationController popToViewController:obj animated:YES];
//                    }
//                }
//            });
//            
//  
//        }];
        

    };
 
}

@end
