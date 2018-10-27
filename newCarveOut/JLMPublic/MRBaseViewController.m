//
//  MRBaseViewController.m
//  MRShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "MRBaseViewController.h"
#import "MRBaseTabBarController.h"
@interface MRBaseViewController ()
@end

@implementation MRBaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //消除导航控制器对scrollView影响
    self.automaticallyAdjustsScrollViewInsets = NO;

    //创建导航栏
    [self createNavigationBar];
    //创建两侧按钮
    [self createButton];
    //创建中央label,考虑到内容会多 最好用Masonry适配
    [self createTitileLabel];

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
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight-1, kWidth, 1)];
    self.bottomLine .backgroundColor = kLineColor;
    [navigationView addSubview:self.bottomLine];
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
#define kNavigationBtnWidth 50
- (void)createButton {
    //创建左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navigationView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationView).with.offset(0);
        make.bottom.equalTo(self.navigationView).offset(5);
        make.width.equalTo(@(kNavigationBtnWidth));
        make.height.equalTo(@(55));
    }];
    [leftBtn.titleLabel setFont:kFont(14)];
    [leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton = leftBtn;
    
    //创建右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navigationView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView).with.offset(-5);
        make.bottom.equalTo(self.navigationView.mas_bottom).offset(5);
        make.width.equalTo(@(60));
        make.height.equalTo(@(55));
    }];
    [rightBtn.titleLabel setFont:kFont(14)];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.rightButton = rightBtn;
    NSArray *arrViewControllers = self.navigationController.viewControllers;
    if (arrViewControllers.count == 1) {
        [leftBtn setImage:kImageNamed(@"--") forState:UIControlStateNormal];
    }else{
        [leftBtn setImage:[UIImage imageNamed:@"mr_public_back"] forState:UIControlStateNormal];
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
    [pwdAgainShowBtn setImage:[UIImage imageNamed:@"MR_user_password_visible"] forState:UIControlStateSelected];
    [pwdAgainShowBtn setImage:[UIImage imageNamed:@"MR_user_password_invisible"] forState:UIControlStateNormal];
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
    MRBaseTabBarController *controller = [[MRBaseTabBarController alloc] init];
    controller.selectedControllerIndex = 2;
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
- (void)setNavigationControllersWithLeaveVC:(NSString*)classString{
    Class vcClass = NSClassFromString(classString);
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    NSLog(@"%@",marr);
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[vcClass class]]) {
            NSInteger index = [marr indexOfObject:vc];
            for (NSInteger i =index+1; i < marr.count; i++) {
                [marr removeObjectAtIndex:i];
            }
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}
-(void)dissModeLoginController {
    
}
//获取当前展示VC

- (MRBaseViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return (MRBaseViewController*)currentVC;
    
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    } if ([rootVC isKindOfClass:[MRBaseTabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [MRBaseTabBarController shardManager].selectedController;
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
    
}
-(BOOL)checkUserDidLogin{
    if (![MRUserLoginModel isLogin]) {
        MRUserLoginVC * vc = [[MRUserLoginVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    return YES;
}
- (void)checkUserDidLoginWithLife{
    if (![MRUserLoginModel isLogin]) {
        MRUserLoginVC * vc = [[MRUserLoginVC alloc]init];
//        vc.loginSuccess = ^{
//            [MRBaseTabBarController shardManager].selectedControllerIndex = 2;
//        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (BOOL)checkUserDidLoginWithLoginSuccess:(loginSuccess)block{
    if (![MRUserLoginModel isLogin]) {
        MRUserLoginVC * vc = [[MRUserLoginVC alloc]init];
//        vc.loginSuccess = ^{
//            [MRBaseTabBarController shardManager].selectedControllerIndex = 2;
//        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    return [MRUserLoginModel isLogin];
}


@end

