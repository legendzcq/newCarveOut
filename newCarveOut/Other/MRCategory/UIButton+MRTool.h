//
//  UIButton+MRTool.h
//  MRClient
//
//  Created by yangshuai on 2018/7/2.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MRButtonEdgeInsetsStyle) {
    MRButtonEdgeInsetsStyleTop, // image在上，label在下
    MRButtonEdgeInsetsStyleLeft, // image在左，label在右
    MRButtonEdgeInsetsStyleBottom, // image在下，label在上
    MRButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (MRTool)
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
- (void)preventRepeatClick;
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MRButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
