//
//  UIImage+RoundedCorners.h
//  YSUserCenterViewController
//
//  Created by 杨帅 on 16/12/19.
//  Copyright © 2016年 danielYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JLMTool)

/**
 *  返回圆型图片
 */
- (instancetype)circleImage;

/**
 *  返回圆型图片
 */
+ (instancetype)circleImage:(NSString *)image;
/**
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+(UIImage *)IMGCompressed:(UIImage *)sourceImg targetWidth:(CGFloat)defineWidth;
//返回圆角图片并且带有border

// 加载Gif
+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;
//使用颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
//缩放图片
- (UIImage *)scaleToSize:(CGSize)newsize;
@end
