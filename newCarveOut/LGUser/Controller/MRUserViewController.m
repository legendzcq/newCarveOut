//
//  MRUserViewController.m
//  MRClient
//
//  Created by yangshuai on 2018/7/2.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserViewController.h"
#import "MRUserShowOrderNumView.h"
#import "MRUserShowImageCell.h"
#import "MRUserSettingCell.h"
#import "MRUserAccountSetingVC.h"
#import "MRUserLoginVC.h"
#import "MRUserSystemInformationVC.h"
#import "MRUserWalletVC.h"
#import "MRUserSettingVC.h"
#import "MRUserLoginVC.h"
#import "MRUserModel.h"

@interface MRUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,  copy)NSArray * bottomTitleArray;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView * logoBgImage;
@property (nonatomic,strong)MRUserModel * model;
@property (nonatomic,strong)MRUserShowOrderNumView * showView;
@end

@implementation MRUserViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottomTitleArray = @[@"客服咨询",@"投诉建议",@"加入我们"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kPersonInfoNotification object:nil];
    [self setupUI];
    [self setupNavigationview];
    [self requestData];
}
- (void)requestData{
//    [MRProgressHUD show:kLoadingText inView:self.view];
//    [YSNetWorkManager requestWithType:(HttpRequestTypeGet) withUrlString:kUserIndex withParaments:nil withSuccessBlock:^(MRRequsetInfoModel *model) {
//        [self.tableView.mj_header endRefreshing];
//        self.model = [MRUserModel modelWithDictionary:model.data];
//        [MRUserModel saveUserInfo:self.model];
//        [self setupHeaderData];
//    }];
}
-(void)setupNavigationview {
    self.navigationView.hidden =  NO;
    self.bottomLine.hidden = YES;
    self.navigationView.backgroundColor =[[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    [self.view bringSubviewToFront:self.navigationView];
    self.rightButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"mr_user_settingIcon"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"mr_user_message"] forState:UIControlStateNormal];
    [[self.leftButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        MRUserLoginVC * loginVC = [[MRUserLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    [self.rightButton addTapGestureBlock:^(UIView *view) {
        MRUserSystemInformationVC * vc = [[MRUserSystemInformationVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)setupUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-TabbarHeight) style:(UITableViewStylePlain)];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.showsVerticalScrollIndicator  = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,0, 0, 0);           //top left bottom right 左右边距相同
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = kTabBGColor;
    [self.tableView setSeparatorColor:kLineColor];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRUserShowImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MRUserShowImageCell"];
    [self.tableView registerClass:[MRUserSettingCell class] forCellReuseIdentifier:@"MRUserSettingCell"];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 261)];
    backView.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = backView;
    backView.backgroundColor = kTabBGColor;
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mr_user_mybg"]];
    bgImageView.frame = CGRectMake(0, 0, kWidth, 197);
    bgImageView.userInteractionEnabled = YES;
    [backView addSubview:bgImageView];
    bgImageView.backgroundColor = [UIColor whiteColor];
    
    MRUserShowOrderNumView * showView = [[MRUserShowOrderNumView alloc] init];
    self.showView = showView;
    [backView addSubview:showView];
    showView.frame =CGRectMake(0, 197, kWidth, 64);
    [showView.orderBackView addTapGestureBlock:^(UIView *view) {
//        [self.navigationController pushViewController:[MRUserOrderModuleVC new] animated:YES];
    }];
    [showView.collectBackView addTapGestureBlock:^(UIView *view) {
//          [self.navigationController pushViewController:[MRUserCollectRentVC new] animated:YES];
    }];
    [showView.watchNumBackView addTapGestureBlock:^(UIView *view) {
    }];
    [showView.walletBackVIew addTapGestureBlock:^(UIView *view) {
        MRUserWalletVC * vc = [[MRUserWalletVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UIImageView * logoBgImage = [[UIImageView alloc]initWithImage:kUserIconPlaceholder];
    self.logoBgImage = logoBgImage;
    [bgImageView addSubview:logoBgImage];
    logoBgImage.layer.cornerRadius = 30;
    [logoBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    logoBgImage.layer.masksToBounds = YES;
    logoBgImage.layer.cornerRadius = 30;
    [logoBgImage addTapGestureBlock:^(UIView *view) {
        MRUserSettingVC * vc = [[MRUserSettingVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = kFont(15);
    nameLabel.text = @"用户名";
    nameLabel.textColor = [UIColor whiteColor];
    [bgImageView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(logoBgImage.mas_centerX);
        make.top.equalTo(logoBgImage.mas_bottom).offset(12);
    }];
    self.nameLabel = nameLabel;

}
- (void)setupHeaderData{
    self.nameLabel.text = self.model.userName;
    [self.logoBgImage setImageWithURL:kURL(self.model.headPortrait) placeholder:kUserIconPlaceholder];
    self.showView.collectNumLab.text = self.model.collectNumber.stringValue;
    self.showView.watchNumLab.text = self.model.pactSeeNumber.stringValue;
    self.showView.orderNumLab.text = self.model.orderNumber.stringValue;
    self.showView.walletNumLab.text = kZeroString(self.model.blance.stringValue);

}
#pragma mark -tableview代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==2) {
        return [MRUserShowImageCell cellHeight];
    } else if (indexPath.row == 1) {
        return [MRUserSettingCell cellHeight];
    }
    
    return 51;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.bottomTitleArray.count+3);
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        MRUserShowImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MRUserShowImageCell"];
        cell.bannerImg.image = kImageNamed(@"mr_user_banner");
        return cell;
    }
    else if (indexPath.row == 2) {
        
        MRUserShowImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MRUserShowImageCell"];
        cell.bannerImg.image = kImageNamed(@"mr_user_banner1");
        return cell;
    }
    else if (indexPath.row == 1) {
        
        MRUserSettingCell * cell = [[MRUserSettingCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MRUserSettingCell"];
        cell.btnClickBlock = ^(NSInteger index) {
            if (index == 0) {
//                MRUserMyContractVC * vc = [MRUserMyContractVC new];
//                [self.navigationController pushViewController:vc animated:YES];
            }else if (index == 1) {
     
            }else if (index == 2) {
//                MRUserNeedPayOrderListVC * vc = [MRUserNeedPayOrderListVC new];
//                vc.isMainEntry = YES;
//                [self.navigationController pushViewController:vc animated:YES];
            }else if (index == 3) {
//                MRUserHousekeeperVC * vc = [MRUserHousekeeperVC new];
//                [self.navigationController pushViewController:vc animated:YES];
            }else if (index ==4){
//                MRLifeRepairMainVC * vc = [[MRLifeRepairMainVC alloc]init];
//                vc.repairsId = self.model.repairsId;
//                [self.navigationController pushViewController:vc animated:YES];
            }else if (index ==5){
//                MRLifeCleanMainVC * vc = [[MRLifeCleanMainVC alloc]init];
//                vc.cleaningId = self.model.cleaningId;
//                [self.navigationController pushViewController:vc animated:YES];
            }else if (index ==6){
                MRRootWebView * webView = [[MRRootWebView alloc]init];
                webView.urlString = self.model.checkGuideUrl;
                [self.navigationController pushViewController:webView animated:YES];
            }
            
        };
        
        return cell;
    }

    static NSString *ID = @"JLMUserViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    }
    cell.selectionStyle = NO;
    cell.textLabel.text = self.bottomTitleArray[indexPath.row-3];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
    cell.textLabel.font = kFont(14);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        //客服咨询
        MRRootWebView * webView = [[MRRootWebView alloc]init];
        webView.urlString = self.model.serviceAdvisoryUrl;
        [self.navigationController pushViewController:webView animated:YES];
        
    }else if (indexPath.row ==4){
        
//        MRUserChangeContractVC * vc = [MRUserChangeContractVC new];
//        [self.navigationController pushViewController:vc animated:YES];
        
        //投诉建议
    }else if (indexPath.row ==5){
        //加入我们
//        MRRootWebView * webView = [[MRRootWebView alloc]init];
//        webView.urlString = self.model.joinUsUrl;
//        [self.navigationController pushViewController:webView animated:YES];
//        MRUserApproximateCommitVC * vc = [MRUserApproximateCommitVC new];
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (offset >= self.logoBgImage.centerY-30) {
        self.navigationView.backgroundColor =[[UIColor colorWithHexString:@"FE9C06"]colorWithAlphaComponent:1];
    }else if(offset < self.logoBgImage.bottom){
        self.navigationView.backgroundColor =[[UIColor colorWithHexString:@"FE9C06"]colorWithAlphaComponent:0];
    }

}
@end
