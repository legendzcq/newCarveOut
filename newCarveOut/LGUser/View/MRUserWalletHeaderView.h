//
//  MRUserWalletHeaderView.h
//  MRClient
//
//  Created by yangshuai on 2018/7/23.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRUserWalletHeaderView : UIImageView
@property (nonatomic,strong) UIButton * funcBtn;//提现按钮
- (instancetype)initWithFrame:(CGRect)frame withBalance:(CGFloat)balance;
@end
