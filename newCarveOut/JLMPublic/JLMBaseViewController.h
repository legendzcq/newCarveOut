//
//  JLMBaseViewController.h
//  JLMShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,EntryCodeType)
{
    
    EntryCodeTypeChangePhone = 0,
    EntryCodeTypeChangePwd,
    EntryCodeTypeForgetPwd
    
};
@class CQCountDownButton;
typedef  void (^loginSuccess)();
@interface JLMBaseViewController : UIViewController
/**
 *  自定义导航栏
 */
@property (nonatomic, weak) UIView *navigationView;
/**
 *  导航栏中央label
 */
@property (nonatomic, weak) UILabel *titleLabel;
/**
 *  中央logo(默认隐藏)
 */
@property (nonatomic, weak) UIImageView *logoImageView;
/**
 *  左侧按钮
 */
@property (nonatomic, weak) UIButton *leftButton;
/**
 *  右侧按钮
 */
@property (nonatomic, weak) UIButton *rightButton;

//渐变背景
@property (nonatomic,strong) UIView * shadeChangeView;

@property (nonatomic,strong) UITableView * tableView;


/**
 *  左侧按钮响应方法, 可重写
 */
- (void)leftBtnClicked:(UIButton *)leftBtn;
/**
 *  右侧按钮响应方法, 可重写
 */
- (void)rightBtnClicked:(UIButton *)rightBtn;
/**
 关闭键盘
 */
- (void)endEditing;

@property (nonatomic,strong) void (^businessDidFinsh)(id parameter);
//初始化输入框
-(UITextField *)setupTextfieldimageName:(NSString *)imageName
                        withplaceholder:(NSString *)placeholder
                      issecureTextEntry:(BOOL)issecureTextEntry
                               andFrame:(CGRect)CGRect;
//初始化验证码输入框
-(UITextField *)setupCodeTextfieldimageName:(NSString *)imageName
                            withplaceholder:(NSString *)placeholder
                          issecureTextEntry:(BOOL)issecureTextEntry
                                   andFrame:(CGRect)CGRect;
//初始化密码输入框
-(UITextField *)setupPwdTextfieldimageName:(NSString *)imageName
                           withplaceholder:(NSString *)placeholder
                         issecureTextEntry:(BOOL)issecureTextEntry
                                  andFrame:(CGRect)CGRect
                                       btn:(void (^)(UIButton *))eyeBtnBlock;
@property (nonatomic,strong) void (^ businessProcessingSuccessful)();
- (void)getLoginedController;

/**
 模态登录
 */
- (void)presentModeLoginController;
- (void)dissModeLoginController;
- (BOOL)checkUserDidLogin;
- (BOOL)checkUserDidLoginWithLoginSuccess:(loginSuccess)block;

/**
 清除栈中某个控制器
 */
- (void)setNavigationControllersWithVC:(NSString*)classString;
@end

