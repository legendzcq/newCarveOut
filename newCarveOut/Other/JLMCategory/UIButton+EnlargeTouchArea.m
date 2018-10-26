//
//  UIButton+EnlargeTouchArea.m
//  jimidun
//
//  Created by microdone on 15/12/29.
//  Copyright © 2015年 microdone. All rights reserved.
//

#import "UIButton+EnlargeTouchArea.h"
#import <objc/runtime.h>
@implementation UIButton(EnlargeTouchArea)
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*) hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}
- (void)preventRepeatClick{
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

/**
 http://www.douban.com/note/288982236/
 增加 UIButton 的點擊範圍
 可以分別控制上下左右的延長範圍
 原理
 
 利用 objective-c 中的 objc_setAssociatedObject 來記錄要變大的範圍。
 
 objc_setAssociatedObject 是 objective-c runtime library 裡面的 function。
 
 Objective-C Runtime Reference
 
 要使用需要import:
 #import <objc/runtime.h>
 最後，最重要的是去 override - (UIView) hitTest:(CGPoint) point withEvent:(UIEvent) event
 
 用新設定的 Rect 來當做點擊範圍。
 
 How to use
 
 在建立 Button 時，就可以直接設定 Button 的點擊範圍
 
 UIButton* enlargeButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
 [enlargeButton1 setTitle:@"Enlarge Button" forState:UIControlStateNormal];
 [enlargeButton1 setFrame:CGRectMake(90, 150, 100, 50)];
 [enlargeButton1 addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
 [enlargeButton1 sizeToFit];
 [self.view addSubview:enlargeButton1];
 
 // 增加 button 的點擊範圍
 [enlargeButton1 setEnlargeEdgeWithTop:20 right:20 bottom:20
 left:0];
 小結
 
 Category 搭配 Associative 真的是蠻好用的！
 
 */
