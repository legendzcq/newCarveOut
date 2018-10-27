//
//  MRUserWalletHeaderView.m
//  MRClient
//
//  Created by yangshuai on 2018/7/23.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserWalletHeaderView.h"

@implementation MRUserWalletHeaderView

- (instancetype)initWithFrame:(CGRect)frame withBalance:(CGFloat)balance{
    if (self) {
        self = [super initWithFrame:frame];
        self.image = kImageNamed(@"mr_user_wallet_bg");
        
        UILabel * balanceLabel = [[UILabel alloc]init];
        [self addSubview:balanceLabel];
        [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self).offset(-48);
        }];
        balanceLabel.textColor = kWhiteColor;
        balanceLabel.font = kFont(33);
        balanceLabel.text = [NSString stringWithFormat:@"¥%.2f",balance];
        
        UILabel * titleLabel = [[UILabel alloc]init];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(balanceLabel);
            make.bottom.equalTo(balanceLabel.mas_top).offset(-12);
        }];
        titleLabel.text = @"账户余额";
        titleLabel.font = kFont(12);
        titleLabel.textColor = kWhiteColor;
        
        self.funcBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:self.funcBtn];
        [self.funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(balanceLabel);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        self.funcBtn.layer.masksToBounds = YES;
        self.funcBtn.layer.cornerRadius = 2.0f;
        self.funcBtn.layer.borderColor = kWhiteColor.CGColor;
        self.funcBtn.layer.borderWidth = 0.5f;
        [self.funcBtn setTitle:@"提现" forState:(UIControlStateNormal)];
        self.funcBtn.titleLabel.font = kFont(12);
        self.funcBtn.hidden = YES;
    }
    return self;
}

@end
