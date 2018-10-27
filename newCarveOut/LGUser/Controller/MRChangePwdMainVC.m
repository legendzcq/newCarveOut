//
//  MRChangePwdMainVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/31.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRChangePwdMainVC.h"
#import "MRChangePwdOrgainVC.h"
#import "MRChangePwdCodeNewVC.h"
#import "MRChangePwdCodeVC.h"
@interface MRChangePwdMainVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *orgainBackView;
@property (weak, nonatomic) IBOutlet UIView *iphoneBackView;

@end

@implementation MRChangePwdMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"修改密码";
    [_orgainBackView addTapGestureBlock:^(UIView *view) {
        MRChangePwdOrgainVC * vc = [MRChangePwdOrgainVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [_iphoneBackView addTapGestureBlock:^(UIView *view) {
        MRChangePwdCodeVC * vc = [MRChangePwdCodeVC new];
           vc.entryType = EntryCodeTypeChangePwd;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.backView.frame  = CGRectMake(0, kNaviBarHeight, kWidth, 300);
    //    float tempHeight=[[UIApplication sharedApplication] statusBarFrame].size.height>20?60:46;
    //    self.bottomView.frame = CGRectMake(0, kHeight-tempHeight, kWidth, tempHeight);
}

@end
