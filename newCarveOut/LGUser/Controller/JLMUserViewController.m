//
//  JLMUserViewController.m
//  JLMShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMUserViewController.h"
#import "JLMUserViewCell.h"
//#import "JLMUserMyWalletVC.h"
#import "MRUserLoginVC.h"
//#import "JLMUserInfoVC.h"
//#import "JLMUserSettingVC.h"
//#import "JLMUserMessageListVC.h"
#import "MRUserLoginVC.h"
//#import "JLMHomeCaterOrderingVC.h"
//#import "JLMCustomerModel.h"
#import "MRUserLoginModel.h"
#import "UIButton+EnlargeTouchArea.h"
//#import "JLMUserChangePayPasswordVC.h"
#import "JLMBaseTabBarController.h"
#import "JLMRootWebView.h"
//#import "JLMUserActivateCardVC.h"
/**定义请求成功的block*/
typedef void(^ UILabelBlock)( UILabel * showLab);
@interface JLMUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)NSArray * titleArray;
@property (nonatomic,copy)NSArray * imageArray;
//@property (nonatomic,strong)JLMCustomerModel *CustomerM;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *telLabel;
@property (nonatomic,strong)UIImageView * logoBgImage;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *couponLabel;
@property (nonatomic,strong)UILabel *commodityPointsLabel;
@property (nonatomic,strong)NSString * balanceStr;
@property (nonatomic,strong)NSString * existPassword;
@property (nonatomic,strong)NSString * existRechargePassword;
@property (nonatomic,assign)BOOL isfinishedNetWork;
@end

@implementation JLMUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.CustomerM = [JLMCustomerModel new];
    self.titleArray = @[@"我的钱包",@"激活会员卡",@"帮助中心",@"关于我们"];
    self.imageArray = @[@"jlm_user_walletIcon",@"jlm_user_vipIcon",
                        @"jlm_user_helpicon",@"jlm_user_ usIcon"];
    [self setupUI];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:KPersonInfoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"setupPayPaawordSuccess" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self checkUserDidLogin]) {
        JLMBaseTabBarController *controller = [[JLMBaseTabBarController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        navController.navigationBarHidden = YES;
        JLMWindow.rootViewController = navController;
    }
    
}
- (void)setupUI {
    self.navigationView.hidden =  YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kStauBarHeiht+10) style:(UITableViewStylePlain)];
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
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 264)];
    backView.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = backView;
    backView.backgroundColor = kTabBGColor;
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jlm_user_bg"]];
    bgImageView.frame = CGRectMake(0, 0, kWidth, 180);
    bgImageView.userInteractionEnabled = YES;
    [backView addSubview:bgImageView];
    
    [bgImageView addTapGestureBlock:^(UIView *view) {
        if (_isfinishedNetWork) {
//            JLMUserInfoVC * vc = [JLMUserInfoVC new];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [JLMProgressHUD showMessage:@"请重新刷新数据" inView:self.view];
        }
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"jlm_user_message"] forState:UIControlStateNormal];
    [bgImageView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView).with.offset(5);
        make.top.equalTo(bgImageView).offset(kStauBarHeiht+10);
        make.width.equalTo(@(44));
        make.height.equalTo(@(44));
    }];
    [leftBtn setEnlargeEdgeWithTop:30 right:30 bottom:30 left:30];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
//         JLMUserMessageListVC * VC = [JLMUserMessageListVC new];
//         [self.navigationController pushViewController:VC animated:YES];
     }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"jlm_user_settingIcon"] forState:UIControlStateNormal];
    [bgImageView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageView).with.offset(-5);
        make.top.equalTo(leftBtn.mas_top);
        make.width.equalTo(@(44));
        make.height.equalTo(@(44));
    }];
    [rightBtn setEnlargeEdgeWithTop:30 right:30 bottom:30 left:30];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
//         JLMUserChangePayPasswordVC * vc = [[JLMUserChangePayPasswordVC alloc]init];
//         JLMUserSettingVC * VC = [JLMUserSettingVC new];
//         VC.existPassword = self.existPassword;
//         [self.navigationController pushViewController:VC animated:YES];
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = kFont(16);
    titleLabel.text = @"我的";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftBtn.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIImageView * backlogoBgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jlm_user_logoBg"]];

    [bgImageView addSubview:backlogoBgImage];
    backlogoBgImage.layer.cornerRadius = 31;
    [backlogoBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).offset(12);
        make.bottom.equalTo(bgImageView.mas_bottom).offset(-25.5);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    backlogoBgImage.layer.masksToBounds = YES;
    backlogoBgImage.layer.cornerRadius = 31;
    
    UIImageView * logoBgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jlm_user_logoBg"]];
    self.logoBgImage = logoBgImage;
    [backlogoBgImage addSubview:logoBgImage];
    logoBgImage.layer.cornerRadius = 30;
    [logoBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(backlogoBgImage);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    logoBgImage.layer.masksToBounds = YES;
    logoBgImage.layer.cornerRadius = 30;
    
//    UIImageView * logoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jlm_user_logoIcon"]];
//    [bgImageView addSubview:logoImage];
//    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(logoBgImage.mas_centerX);
//        make.centerY.equalTo(logoBgImage.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = kFont(16);
    nameLabel.text = @"用户姓名";
    nameLabel.textColor = [UIColor whiteColor];
    [bgImageView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoBgImage.mas_right).offset(10);
        make.top.equalTo(logoBgImage.mas_top).offset(10);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.font = kFont(16);
    telLabel.text = @"   ";
    telLabel.textColor = [UIColor whiteColor];
    [bgImageView addSubview:telLabel];
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoBgImage.mas_right).offset(10);
        make.top.equalTo(nameLabel.mas_bottom).offset(8);
    }];
    self.telLabel = telLabel;
    
    UIImageView * returnImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jlm_user_backWhiteIcon"]];
    returnImage.userInteractionEnabled = YES;
//    returnImage.backgroundColor = [UIColor redColor];
    [bgImageView addSubview:returnImage];
    [returnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageView.mas_right).offset(-12);
        make.centerY.equalTo(logoBgImage.mas_centerY);
    }];
    [returnImage addTapGestureBlock:^(UIView *view) {
        if (_isfinishedNetWork) {
//            JLMUserInfoVC * vc = [JLMUserInfoVC new];
//            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            [JLMProgressHUD showMessage:@"请重新刷新数据" inView:self.view];
        }

    }];
    
//    UIView * oneView = [self getViewTitle:@"余额" value:@"0.00元" color:[UIColor colorWithHexString:@"049ccf"] block:^(UILabel *showLab) {
////        self.moneyLabel = showLab;
//    }];
    int tempWitdh =kWidth/3;
    UIView * oneView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImageView.frame), tempWitdh, 80)];
    oneView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:oneView];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.font = kFont(18);
    topLabel.text = @"0.00元";
    topLabel.textColor =[UIColor colorWithHexString:@"049ccf"];
    [oneView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneView.mas_top).offset(16);
        make.centerX.equalTo(oneView.mas_centerX);
    }];
    self.moneyLabel = topLabel;
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = kFont(14);
    bottomLabel.text = @"余额";
    bottomLabel.textColor =[UIColor colorWithHexString:@"333333"];
    [oneView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(12);
        make.centerX.equalTo(oneView.mas_centerX);
    }];
    
    UIView * twoView = [[UIView alloc]initWithFrame:CGRectMake(tempWitdh, CGRectGetMaxY(bgImageView.frame), tempWitdh, 80)];
    twoView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:twoView];

    UILabel *topLabel1 = [[UILabel alloc] init];
    topLabel1.font = kFont(18);
    topLabel1.text = @"0元";
    topLabel1.textColor =[UIColor colorWithHexString:@"e4370e"];
    [twoView addSubview:topLabel1];
    [topLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoView.mas_top).offset(16);
        make.centerX.equalTo(twoView.mas_centerX);
    }];
    self.couponLabel = topLabel1;
    UILabel *bottomLabel1 = [[UILabel alloc] init];
    bottomLabel1.font = kFont(14);
    bottomLabel1.text = @"积豆";
    bottomLabel1.textColor =[UIColor colorWithHexString:@"333333"];
    [twoView addSubview:bottomLabel1];
    [bottomLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel1.mas_bottom).offset(12);
        make.centerX.equalTo(twoView.mas_centerX);
    }];
    
    UIView * thrView = [[UIView alloc]initWithFrame:CGRectMake(tempWitdh*2, CGRectGetMaxY(bgImageView.frame), tempWitdh, 80)];
    thrView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:thrView];

    UILabel *topLabel2 = [[UILabel alloc] init];
    topLabel2.font = kFont(18);
    topLabel2.text = @"0分";
    topLabel2.textColor =[UIColor colorWithHexString:@"02afba"];
    [thrView addSubview:topLabel2];
    [topLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thrView.mas_top).offset(16);
        make.centerX.equalTo(thrView.mas_centerX);
    }];
    self.commodityPointsLabel = topLabel2;

    UILabel *bottomLabel2 = [[UILabel alloc] init];
    bottomLabel2.font = kFont(14);
    bottomLabel2.text = @"积分";
    bottomLabel2.textColor =[UIColor colorWithHexString:@"333333"];
    [thrView addSubview:bottomLabel2];
    [bottomLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel2.mas_bottom).offset(12);
        make.centerX.equalTo(thrView.mas_centerX);
    }]; 
}

-(UIView *)getViewTitle:(NSString *)title value:(NSString *)value color:(UIColor *)color block:(UILabelBlock)labBlock{
    
    UIView * backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.font = kFont(22);
    topLabel.text = value;
    topLabel.textColor =color;
    [backView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(16);
        make.centerX.equalTo(backView.mas_centerX);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = kFont(14);
    bottomLabel.text = title;
    bottomLabel.textColor =[UIColor colorWithHexString:@"333333"];
    [backView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(12);
        make.centerX.equalTo(backView.mas_centerX);
    }];
    labBlock(topLabel);
    return backView;
}


#pragma mark -tableview代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JLMUserViewCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        JLMUserViewCell *cell =[JLMUserViewCell userTableViewCellWithTableView:tableView];
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!_isfinishedNetWork) {
        [JLMProgressHUD showMessage:@"请重新刷新数据" inView:self.view];
        return;
    }
    
    if (indexPath.row == 0) {
//        JLMUserMyWalletVC * vc = [JLMUserMyWalletVC new];
//        vc.balanceStr = _balanceStr;
//        vc.existRechargePassword = self.existRechargePassword;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
//        JLMUserActivateCardVC * vc = [JLMUserActivateCardVC new];
////        vc.urlString = self.CustomerM.helpUrl;
////        vc.titleString = @"帮助中心";
//        vc.acticateMemberCardDidSucceed = ^{
//            [self loadData];
//        };
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
//        JLMRootWebView * vc = [JLMRootWebView new];
//        vc.urlString = self.CustomerM.helpUrl;
//        vc.titleString = @"帮助中心";
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        JLMRootWebView * vc = [JLMRootWebView new];
        vc.urlString = @"";
        vc.titleString = @"关于我们";
        [self.navigationController pushViewController:vc animated:YES];
    }
//    else if (indexPath.row == 3)
//    {
//        JLMUserLoginVC * vc = [JLMUserLoginVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }

}
-(void)loadData {
    if (![MRUserLoginModel isLogin]) {

        return;
    }
    [JLMProgressHUD show:kLoadingText inView:self.view];
//    NSDictionary * dict = @{@"id":[JLMUserLoginModel account].userid,@"token":kToken};
//    [JLMCustomerModel getCustomerInfo:dict withVC:self HttpRequestType:HttpRequestTypeGet  SuccessBlock:^(JLMCustomerModel *CustomerM) {
//        [JLMProgressHUD hide];
//        _isfinishedNetWork = YES;
//        self.CustomerM = CustomerM;
//        self.nameLabel.text = CustomerM.nickName;
//        self.telLabel.text = CustomerM.mobileNum.stringValue;
//        self.existPassword = CustomerM.existPassword;
//        self.existRechargePassword = CustomerM.existRechargePassword;
//        [self.logoBgImage sd_setImageWithURL:[NSURL URLWithString:CustomerM.headPic] placeholderImage:[UIImage imageNamed:@"jlm_user_logoIcon"]];
//        self.logoBgImage.layer.cornerRadius = 30;
//        self.moneyLabel.text =  [NSString stringWithFormat:@"%.2f元",[CustomerM.money floatValue]];
//        self.balanceStr = [NSString stringWithFormat:@"%.2f元",[CustomerM.money floatValue]];
//        self.couponLabel.text =  [NSString stringWithFormat:@"%.2f元",[CustomerM.coupon floatValue]];
//        self.commodityPointsLabel.text =  [NSString stringWithFormat:@"%@分",CustomerM.commodityPoints.stringValue];
//        [self.tableView.mj_header endRefreshing];
//    } failure:^{
//          [self.tableView.mj_header endRefreshing];
//        _isfinishedNetWork = NO;
//    } ];

}
-(void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    @end
