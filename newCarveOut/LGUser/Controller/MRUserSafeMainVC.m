//
//  MRUserSafeMainVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/8/1.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserSafeMainVC.h"
#import "MRShopInfoCell.h"
#import "MRChangePwdMainVC.h"
#import "MRChangePwdCodeVC.h"
//#import "MRUserPayPwManagerVC.h"
@interface MRUserSafeMainVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MRUserSafeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"安全设置";
    self.view.backgroundColor = kMainColor;
    [self initTableView];
}
#pragma mark ---- init
- (void)initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kWidth, kHeight-kNaviBarHeight) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator  = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 51;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MRShopInfoCell class] forCellReuseIdentifier:@"MRShopInfoCell"];
}

#pragma mark --- delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRShopInfoCell * cell = [[MRShopInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MRShopInfoCell" cellType:(MRShopCellTypeArrow)];
    if(indexPath.row ==0){
        cell.shopTitle.text = @"修改手机号";
        cell.lineView.hidden = NO;
    }else if(indexPath.row ==1){
        cell.shopTitle.text = @"修改登录密码";
        cell.lineView.hidden = NO;
    }

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MRChangePwdCodeVC * vc = [MRChangePwdCodeVC new];
        vc.entryType = EntryCodeTypeChangePhone;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1) {
        MRChangePwdMainVC * vc = [MRChangePwdMainVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
   

   
}
@end
