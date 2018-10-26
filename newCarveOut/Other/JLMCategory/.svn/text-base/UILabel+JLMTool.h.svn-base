//
//  UILabel+FFTAttributed.h
//  CrowdFunding
//
//  Created by yangshuai on 2017/7/21.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JLMAttributeTapActionDelegate <NSObject>
@optional
/**
 *  YBAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)jlm_attributeTapReturnString:(NSString *)string
                               range:(NSRange)range
                               index:(NSInteger)index;
@end
@interface JLMAttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end
@interface UILabel (JLMTool)

/**
 *  字间距
 */
@property (nonatomic,assign)CGFloat wordSpace;
/**
 *  行间距
 */
@property (nonatomic,assign)CGFloat lineSpace;
/**
 *  特殊字 字颜色 字大小
 */
@property (nonatomic,copy)NSString *specialWord;
/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;
/**
 *  下划线
 */
@property (nonatomic,  copy)NSString *underlineWord;
//中划线
@property (nonatomic,  copy)NSString *centerLineWord;
@property (nonatomic,strong)UIColor  *underlineWordColor;
@property (nonatomic,strong)UIColor  *specialWordColor;
@property (nonatomic,strong)UIFont   *specialWordFont;

- (CGFloat)getHeightForWidth:(CGFloat)width;
- (CGFloat)getSpaceLabelHeight:(NSString *)str withWidh:(CGFloat)width withFontSize:(CGFloat)font;
/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)jlm_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                  tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)jlm_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                    delegate:(id <JLMAttributeTapActionDelegate> )delegate;
//添加中划线
- (void)jlm_labelAddCenterLineWith:(NSString*)string;
//添加AttributedString
- (void)jlm_labelAddAttributedString:(NSString*)string withRangeString:(NSString*)rangeString;


@end
