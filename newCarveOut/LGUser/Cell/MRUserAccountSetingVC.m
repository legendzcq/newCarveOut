//
//  MRUserSettingVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/11.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserAccountSetingVC.h"
#import "MRShopInfoCell.h"
#import "MRShopHeaderCell.h"
#import "JLMImagePicker.h"
#import "MRUserChangeInfoVC.h"
@interface MRUserAccountSetingVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property (nonatomic,strong) NSMutableArray * listArray;
@end

@implementation MRUserAccountSetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"账号信息";
    [self initTableView];
}
#pragma mark ---- request
- (void)requestData{
    [MRUserModel requestUserDataSuccessBlock:^(MRUserModel *model) {
        self.model = model;
        [self.tableView reloadData];
    }];
}
#pragma mark ---- init
- (void)initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kWidth, kHeight-kNaviBarHeight) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator  = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MRShopInfoCell class] forCellReuseIdentifier:@"MRShopInfoCell"];
}

#pragma mark --- delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 51;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRShopInfoCell * cell = [[MRShopInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MRShopInfoCell" cellType:(MRShopCellTypeArrow)];
    if(indexPath.row ==0){
        cell.shopTitle.text = @"昵称";
        if ([NSString isNullToString:self.model.userName]) {
            cell.shopSubTitle.text = @"未设置";
        }else{
            cell.shopSubTitle.text = self.model.userName;
        }
        cell.lineView.hidden = NO;
    }else if(indexPath.row ==1){
        cell.shopTitle.text = @"邮箱";
        if ([NSString isNullToString:self.model.email]) {
            cell.shopSubTitle.text = @"未绑定";
        }else{
            cell.shopSubTitle.text = self.model.email;
        }
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MRUserChangeInfoVC * vc = [MRUserChangeInfoVC new];
        vc.string = self.model.nicName;
        vc.businessDidFinsh = ^(id parameter) {
            [MRProgressHUD showMessage:@"设置昵称成功" inView:self.view];
            [self requestData];
        };
        vc.infoType = ChangeInfoTypeName;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        MRUserChangeInfoVC * vc = [MRUserChangeInfoVC new];
        vc.string = self.model.email;
        vc.infoType = ChangeInfoTypeEmail;
        vc.businessDidFinsh = ^(id parameter) {
            [MRProgressHUD showMessage:@"设置邮箱成功" inView:self.view];
            [self requestData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
