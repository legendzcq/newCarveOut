//
//  UIView+MRTool.h
//  CrowdFunding
//
//  Created by yangshuai on 2017/8/10.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DBCommonBlock)();
typedef void(^block)(UIView*);
/// 边框类型(位移枚举)
typedef NS_ENUM(NSInteger, UIBorderSideType) {
    UIBorderSideTypeAll    = 0,
    UIBorderSideTypeTop    = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft   = 1 << 2,
    UIBorderSideTypeRight  = 1 << 3,
};
@interface UIView (MRTool)
/**  起点x坐标  */
@property (nonatomic, assign) CGFloat x;
/**  起点y坐标  */
@property (nonatomic, assign) CGFloat y;
/**  中心点x坐标  */
@property (nonatomic, assign) CGFloat centerX;
/**  中心点y坐标  */
@property (nonatomic, assign) CGFloat centerY;
/**  宽度  */
@property (nonatomic, assign) CGFloat width;
/**  高度  */
@property (nonatomic, assign) CGFloat height;
/**  顶部  */
@property (nonatomic, assign) CGFloat top;
/**  底部  */
@property (nonatomic, assign) CGFloat bottom;
/**  左边  */
@property (nonatomic, assign) CGFloat left;
/**  右边  */
@property (nonatomic, assign) CGFloat right;
/**  size  */
@property (nonatomic, assign) CGSize size;
/**  origin */
@property (nonatomic, assign) CGPoint origin;

@property(nonatomic,copy) void(^block)(UIView*);
/**
 *  圆角的颜色-这个颜色需要和背景颜色设置一致
 */
-(void)addTapGestureBlock:(void(^)(UIView * view))block;

//添加边框
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;
/*
 * @brief 这个Api不支持自动布局
 * @param radius: 角度
 * @param bgColor: 背景颜色,必填项 需要和当前控件的父视图颜色相同
 * @param 边框颜色: 默认绘制1个像素的边框,没有边框写nil即可
 */
- (void)roundingCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor;


- (void)roundingCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth;

- (void)roundingCorner:(UIRectCorner)roundCorner radius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth rect:(CGRect)realRect;

/** 自定义边框属性 exp:虚线/实线 */
- (void)roundingCorner:(UIRectCorner)roundCorner radius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderConfig:(DBCommonBlock)borderConfig rect:(CGRect)realRect;

/** 支持自动布局的API */
- (void)roundingCornerUsingAutoLayout:(UIRectCorner)roundCorner radius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderConfig:(DBCommonBlock)borderConfig;

- (void)createBottomLineWithSpace:(CGFloat)space;
- (void)createBottomLineWithSpace:(CGFloat)space viewHeight:(CGFloat)height;

@end
