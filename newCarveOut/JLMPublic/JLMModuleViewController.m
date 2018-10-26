//
//  JLMModuleViewController.m
//  JLMClient
//
//  Created by yangshuai on 2017/10/26.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMModuleViewController.h"
#import "UIButton+ImageTitleSpacing.h"

@implementation JLMModuleViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationView.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationView];
}

- (void)setupNavigationView{
    self.searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.navigationView addSubview:self.searchBtn];
    [self.searchBtn setTitle:@"输入商家名、品类或商圈" forState:(UIControlStateNormal)];
    [self.searchBtn setImage:kImageNamed(@"jlm_home_search_deep") forState:(UIControlStateNormal)];
    [self.searchBtn setTitleColor:[UIColor colorWithHexString:@"9F9F9F"] forState:(UIControlStateNormal)];
    self.searchBtn.titleLabel.font = kFont(14);
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationView).offset(50);
        make.right.equalTo(self.navigationView).offset(-50);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.navigationView).offset(-7.5);
    }];
    [self.searchBtn setBackgroundColor:kWhiteColor];
    self.searchBtn.layer.masksToBounds = YES;
    self.searchBtn.layer.cornerRadius = 15;
    self.searchBtn.layer.borderColor = kLineColor.CGColor;
    self.searchBtn.layer.borderWidth = 0.5f;
    [self.searchBtn layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleLeft) imageTitleSpace:4];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight-0.5, kWidth, 0.5)];
    [self.navigationView addSubview:line];
    line.backgroundColor = kColor(238, 244, 247);
    
}

- (NSMutableArray *)listArray{
    if (_listArray ==nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
