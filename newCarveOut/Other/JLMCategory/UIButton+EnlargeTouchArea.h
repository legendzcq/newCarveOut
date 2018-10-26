//
//  UIButton+EnlargeTouchArea.h
//  jimidun
//
//  Created by microdone on 15/12/29.
//  Copyright © 2015年 microdone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(EnlargeTouchArea)
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
- (void)preventRepeatClick;
@end
