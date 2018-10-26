//
//  JLMBaseViewController.m
//  JLMShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMBaseViewController.h"
#import "JLMBaseTabBarController.h"
#import "JLMRootNaviController.h"
#import "JLMUserLoginVC.h"
@interface JLMBaseViewController ()

@end

@implementation JLMBaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //隐藏系统的导航条
    //消除导航控制器对scrollView影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建导航栏
    [self createNavigationBar];
    //创建中心的logo
    //创建两侧按钮
    [self createButton];
    //创建中央label,考虑到内容会多 最好用Masonry适配
    [self createTitileLabel];
    //创建中心的logo
    //    [self createLogoImageView];
}


- (void)createNavigationBar {
    _shadeChangeView = [[UIView alloc]init];
    [self.view addSubview:_shadeChangeView];
    _shadeChangeView.hidden = YES;
    _shadeChangeView.backgroundColor = kMainColor;
    UIView *navigationView = [[UIView alloc] init];
    [self.view addSubview:navigationView];
    
    //对自定义的导航条适配
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kNaviBarHeight);
    }];
    [_shadeChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    self.navigationView = navigationView;
    self.navigationView.backgroundColor = [UIColor whiteColor];
    //    kMainColor;
    //    self.navigationView.backgroundColor = kb
}

- (void)createTitileLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = kFont(16);
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    //对label适配
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.leftButton).with.offset(44);
        make.right.equalTo(self.rightButton).with.offset(-44);
        //        make.centerY.equalTo(self.navigationView).with.offset(10);
        make.centerY.equalTo(self.leftButton.mas_centerY);
    }];
}
- (void)createLogoImageView {
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.navigationView addSubview:logoImageView];
    self.logoImageView = logoImageView;
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(self.navigationView.center.x, self.navigationView.center.y + 10));
        make.size.mas_equalTo(CGSizeMake(78, 25));
    }];
    self.logoImageView.hidden = YES;
}
//按钮长宽
#define kNavigationBtnWidthAndHeight 55
- (void)createButton {
    //创建左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navigationView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationView).with.offset(-5);
        make.bottom.equalTo(self.navigationView).offset(5);
        make.width.equalTo(@(kNavigationBtnWidthAndHeight));
        make.height.equalTo(@(kNavigationBtnWidthAndHeight));
    }];
    [leftBtn.titleLabel setFont:kFont(14)];
    [leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton = leftBtn;
    
    //创建右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navigationView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView).with.offset(-5);
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(5);//.with.height.offset(20);
        make.width.equalTo(@(kNavigationBtnWidthAndHeight));
        make.height.equalTo(@(kNavigationBtnWidthAndHeight));
    }];
    [rightBtn.titleLabel setFont:kFont(14)];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = rightBtn;
    NSArray *arrViewControllers = self.navigationController.viewControllers;
    if (arrViewControllers.count == 1) {
        [leftBtn setImage:kImageNamed(@"--") forState:UIControlStateNormal];
    }else{
        [leftBtn setImage:[UIImage imageNamed:@"jlm_public_back.png"] forState:UIControlStateNormal];
    }
    [rightBtn setTitleColor:kSubtitleColor forState:(UIControlStateNormal)];
}

- (void)leftBtnClicked:(UIButton *)leftBtn {
    //左侧按钮点击事件
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)rightBtnClicked:(UIButton*)sende{
}
- (void)endEditing {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


//初始化输入框
-(UITextField *)setupTextfieldimageName:(NSString *)imageName
                        withplaceholder:(NSString *)placeholder
                      issecureTextEntry:(BOOL)issecureTextEntry
                               andFrame:(CGRect)CGRect
{
    int tempHeight=CGRect.size.height;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRect];
    backgroundView.backgroundColor = kMainColor;
    [self.view addSubview:backgroundView];
    
    UIImageView * iconview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    iconview.contentMode= UIViewContentModeCenter;
    iconview.frame = CGRectMake(12, (tempHeight-13)*0.5, 9, 13);
    [backgroundView addSubview:iconview];
    
    UITextField * UITextFieldValueField =[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconview.frame)+4, 0,  kWidth-12-9-4, tempHeight)];
    UITextFieldValueField.placeholder = placeholder;
    UITextFieldValueField.font = kFont(15);
    UITextFieldValueField.secureTextEntry = issecureTextEntry;
    UITextFieldValueField.clearButtonMode = UITextFieldViewModeAlways;
    UITextFieldValueField.textColor = [UIColor colorWithHexString:@"333333"];
    [backgroundView addSubview:UITextFieldValueField];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(12, tempHeight-0.5, kWidth-24, 0.5)];
    lineView1.backgroundColor = kLineColor;
    [backgroundView addSubview:lineView1];
    
    return UITextFieldValueField;
}


//初始化验证码输入框
-(UITextField *)setupCodeTextfieldimageName:(NSString *)imageName
                            withplaceholder:(NSString *)placeholder
                          issecureTextEntry:(BOOL)issecureTextEntry
                                   andFrame:(CGRect)CGRect
{
    int tempHeight=CGRect.size.height;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRect];
    backgroundView.backgroundColor = kMainColor;
    [self.view addSubview:backgroundView];
    
    UIImageView * iconview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    iconview.contentMode= UIViewContentModeCenter;
    iconview.frame = CGRectMake(12, (tempHeight-13)*0.5, 9, 13);
    [backgroundView addSubview:iconview];
    
    UITextField * UITextFieldValueField =[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconview.frame)+4, 0,  kWidth-12-9-4-90-20-12, tempHeight)];
    UITextFieldValueField.placeholder = placeholder;
    UITextFieldValueField.font = kFont(15);
    UITextFieldValueField.secureTextEntry = issecureTextEntry;
    UITextFieldValueField.clearButtonMode = UITextFieldViewModeAlways;
    UITextFieldValueField.textColor = [UIColor colorWithHexString:@"333333"];
    [backgroundView addSubview:UITextFieldValueField];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(12, tempHeight-0.5, kWidth-24, 0.5)];
    lineView1.backgroundColor = kLineColor;
    [backgroundView addSubview:lineView1];
    
    
    
    
    
    return UITextFieldValueField;
}
//初始化密码输入框
-(UITextField *)setupPwdTextfieldimageName:(NSString *)imageName
                           withplaceholder:(NSString *)placeholder
                         issecureTextEntry:(BOOL)issecureTextEntry
                                  andFrame:(CGRect)CGRect
                                       btn:(void (^)(UIButton *))eyeBtnBlock
{
    int tempHeight=CGRect.size.height;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRect];
    backgroundView.backgroundColor = kMainColor;
    [self.view addSubview:backgroundView];
    
    UIImageView * iconview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    iconview.contentMode= UIViewContentModeCenter;
    iconview.frame = CGRectMake(12, (tempHeight-13)*0.5, 9, 13);
    [backgroundView addSubview:iconview];
    
    UITextField * UITextFieldValueField =[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconview.frame)+4, 0,  kWidth-12-9-4-22-12-12, tempHeight)];
    UITextFieldValueField.placeholder = placeholder;
    UITextFieldValueField.font = kFont(15);
    UITextFieldValueField.secureTextEntry = issecureTextEntry;
    UITextFieldValueField.clearButtonMode = UITextFieldViewModeAlways;
    UITextFieldValueField.textColor = [UIColor colorWithHexString:@"333333"];
    [backgroundView addSubview:UITextFieldValueField];
    //    UITextFieldValueField.backgroundColor = [UIColor redColor];
    
    UIButton * pwdAgainShowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pwdAgainShowBtn setImage:[UIImage imageNamed:@"jlm_user_password_visible"] forState:UIControlStateSelected];
    [pwdAgainShowBtn setImage:[UIImage imageNamed:@"jlm_user_password_invisible"] forState:UIControlStateNormal];
    pwdAgainShowBtn.frame = CGRectMake(CGRectGetMaxX(UITextFieldValueField.frame)+8, (tempHeight-14)*0.5, 22, 14);
    [backgroundView addSubview:pwdAgainShowBtn];
    eyeBtnBlock(pwdAgainShowBtn);
    
    [[pwdAgainShowBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        pwdAgainShowBtn.selected = !pwdAgainShowBtn.isSelected;
        UITextFieldValueField.secureTextEntry =!pwdAgainShowBtn.isSelected;
    }];
    
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(12, tempHeight-0.5, kWidth-24, 0.5)];
    lineView1.backgroundColor = kLineColor;
    [backgroundView addSubview:lineView1];
    
    
    return UITextFieldValueField;
}
- (void)getLoginedController {
    //已登录
    JLMBaseTabBarController *controller = [[JLMBaseTabBarController alloc] init];
    controller.selectedControllerIndex = 2;
    JLMRootNaviController *naviVc = [[JLMRootNaviController alloc] initWithRootViewController:controller];
    naviVc.navigationBarHidden = YES;
    JLMWindow.rootViewController = naviVc;
}

-(void)presentModeLoginController {
    JLMUserLoginVC * vc = [JLMUserLoginVC new];
    JLMRootNaviController *naviVc = [[JLMRootNaviController alloc] initWithRootViewController:vc];
    vc.isModeEntry = YES;
    [self presentViewController:naviVc animated:YES completion:^{
        
    }];
}
//判断用户是否登录 如果未登录请登录
- (BOOL)checkUserDidLogin{
    if (![JLMUserLoginModel isLogin]) {
        JLMUserLoginVC * vc = [JLMUserLoginVC new];
        JLMRootNaviController *naviVc = [[JLMRootNaviController alloc] initWithRootViewController:vc];
        vc.isModeEntry = YES;
        [self presentViewController:naviVc animated:YES completion:^{
            
        }];
    }
    return [JLMUserLoginModel isLogin];
}
//判断用户是否登录 如果未登录请登录
- (BOOL)checkUserDidLoginWithLoginSuccess:(loginSuccess)block{
    if (![JLMUserLoginModel isLogin]) {
        JLMUserLoginVC * vc = [JLMUserLoginVC new];
        JLMRootNaviController *naviVc = [[JLMRootNaviController alloc] initWithRootViewController:vc];
        vc.isModeEntry = YES;
        vc.isModeDissmiss = YES;
        vc.loginSuccess = ^{
            block();
        };
        [self presentViewController:naviVc animated:YES completion:^{
            
        }];
    }
    return [JLMUserLoginModel isLogin];
    
}
- (void)setNavigationControllersWithVC:(NSString*)classString{
    Class vcClass = NSClassFromString(classString);
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[vcClass class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}
-(void)dissModeLoginController {
    
}

@end

