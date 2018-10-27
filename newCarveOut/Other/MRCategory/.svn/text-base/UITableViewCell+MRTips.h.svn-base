//
//  UITableViewCell+MRTips.h
//  MRClient
//
//  Created by yangshuai on 2018/3/29.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,MRNoDataType){
    MRNoDataTypeTop,
    MRNoDataTypeCenter,
};
/// 点击主屏幕回调
typedef void(^tapViewWithBlock)(void);
@interface UITableViewCell (MRTips)

/// 显示状态，点击屏幕时回调。显示文字 和显示位置
//- (void)showStatus:(NSString *)status showType:(MRNoDataType)showType tapViewWithBlock:(tapViewWithBlock)block;

/// 显示状态，点击屏幕时回调，如果是gif，type请填gif, 默认加载jpg,png。
- (void)showStatus:(NSString *)status imageName:(NSString *)imageName  type:(NSString *)type tapViewWithBlock:(tapViewWithBlock)block;

/// 隐藏提示
- (void)hide;
@end
