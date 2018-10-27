//
//  MRUserWalletVC.m
//  MRClient
//
//  Created by yangshuai on 2018/7/23.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserWalletVC.h"
#import "MRUserWalletHeaderView.h"
#import "MRUserWalletCell.h"
@interface MRUserWalletVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) MRUserWalletHeaderView * headerView;
@end

@implementation MRUserWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initNaviView];
}
- (void)initTableView{
    self.navigationView.hidden = YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.backgroundColor = kTabBGColor;
    self.tableView.showsVerticalScrollIndicator  = NO;
    self.tableView.separatorStyle = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MRUserWalletCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MRUserWalletCell"];
    self.headerView = [[MRUserWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 200) withBalance:0];
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    back.backgroundColor = [UIColor redColor];
    [back addSubview:self.headerView];
    self.tableView.tableHeaderView = back;
    self.headerView.userInteractionEnabled = YES;
    [[_headerView.funcBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        MRUserWithdrawVC * vc = [MRUserWithdrawVC new];
//        [self.navigationController pushViewController:vc animated:YES];
    }];


}
- (void)initNaviView{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(-5);
        make.top.equalTo(self.view).offset(10);
        make.width.equalTo(@(55));
        make.height.equalTo(@(55));
    }];
    [leftBtn.titleLabel setFont:kFont(14)];
    leftBtn.tintColor = kWhiteColor;
    [leftBtn addTapGestureBlock:^(UIView *view) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIImage *buttonImage = [UIImage imageNamed:@"mr_public_back"];
    [leftBtn setImage:[buttonImage imageByTintColor:kWhiteColor] forState:UIControlStateNormal];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = kFont(16);
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    //对label适配
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.view).with.offset(60);
        make.right.equalTo(self.view).with.offset(-60);
        make.centerY.equalTo(leftBtn.mas_centerY);
    }];
    titleLabel.textColor = kWhiteColor;
    titleLabel.text = @"钱包";
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRUserWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MRUserWalletCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MRUserTransactionDetailVC * vc = [[MRUserTransactionDetailVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y ;
    if (yOffset < 0) {
        CGFloat totalOffset = 200 + ABS(yOffset);
        self.headerView.frame = CGRectMake(0, yOffset, kWidth, totalOffset);
    }
}

@end
