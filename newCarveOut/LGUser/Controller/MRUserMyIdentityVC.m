//
//  MRUserMyIdentityVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/25.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserMyIdentityVC.h"

@interface MRUserMyIdentityVC ()
@property (weak, nonatomic) IBOutlet UIView *backVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *IDLab;

@end

@implementation MRUserMyIdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationControllersWithVC:@"MRUserCheckIdentityVC"];
    self.titleLabel.text = @"我的实名认证";
    self.nameLab.text = self.model.customerName;
    if (![self.model.sex isKindOfClass:[NSNull class]]) {
      self.sexLab.text = [self.model.sex integerValue] ==1?@"男":@"女";
    }
    if (![self.model.idCard isKindOfClass:[NSNull class]]) {
        self.IDLab.text = [NSString replaceStringWithIDCardString:self.model.idCard];
    }
    [self setNavigationControllersWithVC:@"MRUserCheckIdentityVC"];
}


@end
