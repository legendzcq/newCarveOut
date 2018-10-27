//
//  MRUserRegisterTwoView.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/12.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserRegisterTwoView.h"


@interface MRUserRegisterTwoView()
@property(nonatomic,strong) UITextField * pwdField;
@property(nonatomic,strong) UITextField * pwdAgainField;
@property(nonatomic,strong) UIButton * commitBtn;
@end

@implementation MRUserRegisterTwoView
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

    self.pwdField = [self setupTextfieldplaceholder:@"请输入密码"
                                     issecureTextEntry:YES
                                             backFrame:CGRectMake(0, 32, kWidth, 51)
                                         andFieldFrame:CGRectMake(16, 17, kWidth-32-100, 30)];
    
    
    self.pwdAgainField = [self setupTextfieldplaceholder:@"请再次输入密码"
                                         issecureTextEntry:YES
                                                 backFrame:CGRectMake(0, 85, kWidth, 51)
                                             andFieldFrame:CGRectMake(16, 17, kWidth-32, 30)];

    [[self.pwdField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    [[self.pwdAgainField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [self changeCommitenabled];
    }];
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    [commitBtn.titleLabel setFont:kFont(14)];
    commitBtn.layer.cornerRadius = 20;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    commitBtn.backgroundColor = kCommitBtnColor;
    [self addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.top.equalTo(self.pwdAgainField.superview.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
 
    self.commitBtn = commitBtn;
    [[commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         
         if (![NSString validatePassword:self.pwdField.text]) {
             //        self.cardIDValueField.text.length < 8 ||self.cardIDValueField.text.length>20
             [MRProgressHUD showMessage:@"请输入6到18位字母和数字的组合" inView:self];
             [self.pwdField becomeFirstResponder];
             return ;
         }
         
         if (![NSString validatePassword:self.pwdAgainField.text]) {
             //        self.cardIDValueField.text.length < 8 ||self.cardIDValueField.text.length>20
             [MRProgressHUD showMessage:@"请输入6到18位字母和数字的组合" inView:self];
             [self.pwdAgainField becomeFirstResponder];
             return ;
         }
         
         //判断密码一致性
         if (![self.pwdField.text isEqual:self.pwdAgainField.text]) {
             [MRProgressHUD showMessage:@"输入密码不一致" inView:self];
             [self.pwdField becomeFirstResponder];
             return ;
         }
         
         if (self.registBlock) {
             self.registBlock(self.pwdField.text,self.pwdAgainField.text);
         }
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
        make.top.equalTo(self.pwdAgainField.superview.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         if (self.loginBtnBlock) {
             self.loginBtnBlock(@"");
         }
     }];

}
-(void)changeCommitenabled
{
    
    if (self.pwdField.text.length > 0   &&
        self.pwdAgainField.text.length>0)
    {
        self.commitBtn.enabled = YES;
        self.commitBtn.backgroundColor =[UIColor colorWithHexString:@"d59f4a"];
    }else
    {
        
        self.commitBtn.enabled = NO;
        self.commitBtn.backgroundColor =kCommitBtnColor;
    }
}
@end