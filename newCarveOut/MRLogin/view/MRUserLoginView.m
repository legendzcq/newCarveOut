//
//  MRUserLoginView.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/12.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserLoginView.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
@interface MRUserLoginView()
@property(nonatomic,strong) UITextField * iphoneField;
@property(nonatomic,strong) UITextField * pwdField;
@property(nonatomic,strong) UIButton * commitBtn;
@property (nonatomic, strong) ZFPlayerController *player;
@property(nonatomic,strong)UIView * playerBackView;
@end

@implementation MRUserLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    self.playerBackView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.playerBackView];
//    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
//    /// 播放器相关
//    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.playerBackView];
//    [self.player enterPortraitFullScreen:YES animated:YES];
//    [self.player updateNoramlPlayerWithContainerView:self];
//
//    @weakify(self)
//    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
//        @strongify(self)
//
//    };
//
//    /// 播放完自动播放下一个
//    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
//        @strongify(self)
//                [self.player.currentPlayerManager replay];
//        //        [self.player playTheNext];
//        //        if (!self.player.isLastAssetURL) {
//        //            NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
//        //            [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
//        //        } else {
//        //            [self.player stop];
//        //        }
////        [self.player stop];
//    };
//
//            NSString *path = arc4random_uniform(2) ? @"login_video" : @"loginmovie";
//    self.player.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"]]  ;
    
    
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 24+TabbarHeight, 60, 20)];
    titleLab.font = kFont(20);
    titleLab.text = @"您好";
    titleLab.textColor = [UIColor colorWithHexString:@"333333"];
    [self addSubview:titleLab];
    [titleLab sizeToFit];
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"欢迎来到ME家，立即 注册"];
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:12.0]
     
                          range:NSMakeRange(0, AttributedStr.string.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithHexString:@"999999"]
     
                          range:NSMakeRange(0,  AttributedStr.string.length-2)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithHexString:@"d59f4a"]
     
                          range:NSMakeRange( AttributedStr.string.length-2,2)];
    
    
    UIButton * regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regBtn.frame = CGRectMake(16, CGRectGetMaxY(titleLab.frame)+8, 150, 13);
    [regBtn setAttributedTitle:AttributedStr forState:UIControlStateNormal];
    
    [regBtn setTitleColor:[UIColor colorWithHexString:@"d59f4a"] forState:(UIControlStateNormal)];
    [self addSubview:regBtn];
    [regBtn sizeToFit];
    
    [[regBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         if (self.regBtnBlock) {
             self.regBtnBlock(@"");
         }
     }];
    
    self.iphoneField = [self setupTextfieldplaceholder:@"请输入手机号"
                                     issecureTextEntry:NO
                                             backFrame:CGRectMake(0, CGRectGetMaxY(regBtn.frame)+16, kWidth, 51)
                                         andFieldFrame:CGRectMake(16, 17, kWidth-32, 30)];
    self.iphoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.pwdField = [self setupTextfieldplaceholder:@"请输入密码"
                                  issecureTextEntry:YES
                                          backFrame:CGRectMake(0, CGRectGetMaxY(self.iphoneField.superview.frame)+1, kWidth, 51)
                                      andFieldFrame:CGRectMake(16, 17, kWidth-32, 30)];
    [[self.iphoneField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    [[self.pwdField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    commitBtn.frame = CGRectMake(kWidth-116, CGRectGetMaxY(self.pwdField.superview.frame)+16, 100, 44) ;
    [commitBtn.titleLabel setFont:kFont(14)];
    commitBtn.layer.cornerRadius = 20;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    commitBtn.backgroundColor = kCommitBtnColor;
    [self addSubview:commitBtn];
    
    commitBtn.enabled = NO;
    self.commitBtn = commitBtn;
    [[commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         
         
//         if (![NSString validateMobile:self.iphoneField.text]) {
//             [MRProgressHUD showMessage:@"请输入正确的手机号" inView:self];
//             [self.iphoneField becomeFirstResponder];
//             
//             return;
//         }
//         
//         if (![NSString isPassword:self.pwdField.text]) {
//             [MRProgressHUD showMessage:@"密码格式不对" inView:self];
//             [self.iphoneField becomeFirstResponder];
//             
//             return;
//         }
         
         if (self.loginBtnBlock) {
             self.loginBtnBlock(self.iphoneField.text,self.pwdField.text);
         }
     }];
    
    UIButton * codeLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeLoginBtn setTitle:@"验证码登录" forState:(UIControlStateNormal)];
    codeLoginBtn.frame = CGRectMake(16, CGRectGetMaxY(self.pwdField.superview.frame)+32, 100, 44) ;
    [codeLoginBtn.titleLabel setFont:kFont(14)];
    [codeLoginBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:(UIControlStateNormal)];
    [self addSubview:codeLoginBtn];
    [codeLoginBtn sizeToFit];
    [[codeLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         if (self.codeBtnBlock) {
             self.codeBtnBlock(@"");
         }
     }];
    
}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    if (self.player.isFullScreen) {
//        return UIInterfaceOrientationMaskLandscape;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}
-(void)changeCommitenabled
{
    
    if (self.iphoneField.text.length > 0   &&
        self.pwdField.text.length>0)
    {
        self.commitBtn.enabled = YES;
        self.commitBtn.backgroundColor =[UIColor colorWithHexString:@"d59f4a"];
    }else
    {
        
        self.commitBtn.enabled = NO;
        self.commitBtn.backgroundColor =kCommitBtnColor;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}
@end
