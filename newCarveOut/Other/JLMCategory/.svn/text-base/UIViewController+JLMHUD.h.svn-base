//
//  UIViewController+FFTHUD.h
//  CrowdFunding
//
//  Created by yangshuai on 2017/8/10.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSInteger,NoDataType){
    NoDataTypeTop,
    NoDataTypeCenter,
};
/// 点击主屏幕回调
typedef void(^tapViewWithBlock)();
@interface UIViewController (JLMHUD)
/// 显示状态，点击屏幕时回调。显示文字
- (void)showStatus:(NSString *)status tapViewWithBlock:(tapViewWithBlock)block;

/// 显示状态，点击屏幕时回调，如果是gif，type请填gif, 默认加载jpg,png。
- (void)showStatus:(NSString *)status imageName:(NSString *)imageName type:(NSString *)type tapViewWithBlock:(tapViewWithBlock)block;

/// 隐藏提示
- (void)hide;
- (void)show;
@end
