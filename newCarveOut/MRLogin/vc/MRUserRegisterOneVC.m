//
//  MRUserRegisterOneVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/11.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserRegisterOneVC.h"
#import "MRUserRegisterOneView.h"
#import "MRUserLoginVC.h"
#import "MRUserRegisterTwoVC.h"

//#import "MRUserAccountSetingVC.h"
@interface MRUserRegisterOneVC ()

@end

@implementation MRUserRegisterOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI {
    self.titleLabel.text = @"手机号注册";
    MRUserRegisterOneView * regView = [[MRUserRegisterOneView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kWidth, kHeight-kNaviBarHeight) withType:MRUserRegisterOneViewRegister];
    [self.view addSubview:regView];
    regView.loginBtnBlock = ^(NSString *id) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    regView.registBlock = ^(NSString *phoneStr, NSString *phoneCodeStr) {
        NSDictionary * dic = @{@"smsCode":phoneCodeStr,@"smsType":@"regist"};
//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kVerifySendSmsCode(phoneStr) withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
            MRUserRegisterTwoVC * twoVC =  [MRUserRegisterTwoVC new];
            twoVC.phoneStr = phoneStr;
            [self.navigationController pushViewController:twoVC animated:YES];
//        }];

    };
    regView.phoneCodeBtnBlock = ^(NSString *id) {
        
    };
}



@end