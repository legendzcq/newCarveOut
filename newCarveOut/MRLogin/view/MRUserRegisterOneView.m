//
//  MRUserRegisterOneView.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/11.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserRegisterOneView.h"
#import "CQCountDownButton.h"


@interface MRUserRegisterOneView()

@end

@implementation MRUserRegisterOneView

- (instancetype)initWithFrame:(CGRect)frame withType:(MRUserRegisterOneViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
         [self setupUI:type];
    }
    return self;
}
- (void)setupUI:(MRUserRegisterOneViewType)type {
    self.backgroundColor = [UIColor whiteColor];

    self.iphoneField = [self setupTextfieldplaceholder:@"请输入手机号"
                                       issecureTextEntry:NO
                                               backFrame:CGRectMake(0, 32, kWidth, 51)
                                           andFieldFrame:CGRectMake(16, 17, kWidth-32-100, 30)];
    

    self.iphoneCodeField = [self setupTextfieldplaceholder:@"请输入验证码"
                                         issecureTextEntry:NO
                                                 backFrame:CGRectMake(0, 85, kWidth, 51)
                                             andFieldFrame:CGRectMake(16, 17, kWidth-32, 30)];
    self.iphoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.iphoneCodeField.keyboardType = UIKeyboardTypeNumberPad;
    [[self.iphoneField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    [[self.iphoneCodeField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    __weak __typeof__(self) weakSelf = self;
    CQCountDownButton * countDownButton = [[CQCountDownButton alloc] initWithDuration:60 buttonClicked:^{
        __strong typeof(weakSelf) self = weakSelf;
        if (![NSString validateMobile:self.iphoneField.text]) {
            [MRProgressHUD showMessage:@"请输入正确的手机号" inView:self];
            [self.iphoneField becomeFirstResponder];
            [self.countDownButton setEnabled:YES];
            return;
        }        
        NSDictionary * dic = @{@"smsType": type==MRUserRegisterOneViewRegister? @"regist":@"login"};
//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kSendSmsCode(self.iphoneField.text) withParaments:dic withSuccessBlock:^(MRRequsetInfoModel *model) {
//
//            // 获取到验证码后开始倒计时
//            [self.countDownButton startCountDown];
//            if (self.phoneCodeBtnBlock) {
//                self.phoneCodeBtnBlock(@"");
//            }
//        } withFailureBlock:^(NSError *error) {
//
//        } progress:^(float progress) {
//
//        }];
    } countDownStart:^{
        NSLog(@"倒计时开始");
    } countDownUnderway:^(NSInteger restCountDownNum) {
        [weakSelf.countDownButton setTitle:[NSString stringWithFormat:@"%ldS", (long)restCountDownNum] forState:UIControlStateNormal];
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        [weakSelf.countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
    [self addSubview:countDownButton];
    self.countDownButton = countDownButton;
    [countDownButton setTitleColor:kOrangeColor forState:(UIControlStateNormal)];
    [countDownButton.titleLabel setFont:kFont(11)];
    countDownButton.layer.borderWidth = 1;
    countDownButton.layer.borderColor =kOrangeColor.CGColor;
    countDownButton.layer.cornerRadius = 12;
    [countDownButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iphoneField.superview .mas_centerY);
        make.right.equalTo(self.iphoneField.superview.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(82, 28));
    }];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"已有账号？登录"];
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:14.0]
     
                          range:NSMakeRange(0, AttributedStr.string.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithHexString:@"999999"]
     
                          range:NSMakeRange(0, 5)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithHexString:@"d59f4a"]
     
                          range:NSMakeRange(5,2)];

    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];

   [loginBtn setAttributedTitle:AttributedStr forState:UIControlStateNormal];

    [loginBtn setTitleColor:[UIColor colorWithHexString:@"d59f4a"] forState:(UIControlStateNormal)];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self.iphoneCodeField.superview.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         if (self.loginBtnBlock) {
             self.loginBtnBlock(@"");
         }
     }];
    self.loginBtn = loginBtn;
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [nextBtn.titleLabel setFont:kFont(14)];
     nextBtn.layer.cornerRadius = 20;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    nextBtn.backgroundColor = kCommitBtnColor;
    [self addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.top.equalTo(self.iphoneCodeField.superview.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
//    nextBtn.enabled = NO;
    self.nextBtn = nextBtn;
    [[nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         
         
//         if (![NSString validateMobile:self.iphoneField.text]) {
//             [MRProgressHUD showMessage:@"请输入正确的手机号" inView:self];
//             [self.iphoneField becomeFirstResponder];
//             [self.countDownButton setEnabled:YES];
//             return;
//         }
//
//         if (![NSString isCodePwd:self.iphoneCodeField.text]) {
//             [MRProgressHUD showMessage:@"验证码格式不对" inView:self];
//             [self.iphoneField becomeFirstResponder];
//             [self.countDownButton setEnabled:YES];
//             return;
//         }
         
         if (self.registBlock) {
             self.registBlock(self.iphoneField.text,self.iphoneCodeField.text);
         }
    }];
    
    
}



-(void)changeCommitenabled
{
    
    if (self.iphoneField.text.length > 0   &&
        self.iphoneCodeField.text.length>0)
 {
        self.nextBtn.enabled = YES;
        self.nextBtn.backgroundColor =[UIColor colorWithHexString:@"d59f4a"];
    }else
    {
        
        self.nextBtn.enabled = NO;
        self.nextBtn.backgroundColor =kCommitBtnColor;
    }
}
@end
