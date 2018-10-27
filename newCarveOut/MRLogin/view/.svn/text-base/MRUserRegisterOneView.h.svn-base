//
//  MRUserRegisterOneView.h
//  MRClient
//
//  Created by 张传奇 on 2018/7/11.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRBaseUIView.h"

typedef enum : NSUInteger {
    MRUserRegisterOneViewRegister,
    MRUserRegisterOneViewLogin,
} MRUserRegisterOneViewType;

@interface MRUserRegisterOneView : MRBaseUIView
@property(nonatomic,copy) void (^loginBtnBlock)(NSString * id);
@property(nonatomic,copy) void (^registBlock)(NSString * phoneStr,NSString * phoneCodeStr);
@property(nonatomic,copy) void (^phoneCodeBtnBlock)(NSString * id);


@property(nonatomic,strong) CQCountDownButton * countDownButton;
@property(nonatomic,strong) UITextField * iphoneField;
@property(nonatomic,strong) UITextField * iphoneCodeField;
@property(nonatomic,strong) UIButton * nextBtn;
@property(nonatomic,strong) UIButton * loginBtn;
- (instancetype)initWithFrame:(CGRect)frame withType:(MRUserRegisterOneViewType)type;
@end
