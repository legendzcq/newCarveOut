//
//  UIView+JLMTool.h
//  CrowdFunding
//
//  Created by yangshuai on 2017/8/10.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "UIView+JLMTool.h"
#import <objc/runtime.h>

static NSString *DBCornerLayerName = @"DBCornerShapeLayer";
#define SINGLE_LINE_WIDTH (1 / [UIScreen mainScreen].scale)
#define Screen_Scale ([UIScreen mainScreen].scale)
@interface UIView()
@property (nonatomic, assign) CGRect dbCornerFrame;
@property (nonatomic,   copy) DBCommonBlock dbLayoutBlock;
@property (nonatomic, strong) CALayer *sn_maskLayer;

@end
@implementation UIView (JLMTool)
#pragma mark - frame
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
    CGRect frame = CGRectMake(0, 0, targetSize.width, targetSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
}
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return self;
    }
    
    
    /// 左侧
    if (borderType & UIBorderSideTypeLeft) {
        /// 左侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// 右侧
    if (borderType & UIBorderSideTypeRight) {
        /// 右侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// top
    if (borderType & UIBorderSideTypeTop) {
        /// top线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    /// bottom
    if (borderType & UIBorderSideTypeBottom) {
        /// bottom线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}
- (void)roundingCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor{
    [self roundingCorner:UIRectCornerAllCorners radius:radius backgroundColor:bgColor borderColor:borderColor borderWidth:SINGLE_LINE_WIDTH rect:CGRectNull];
}

- (void)roundingCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth{
    [self roundingCorner:UIRectCornerAllCorners radius:radius backgroundColor:bgColor borderColor:borderColor borderWidth:borderWidth rect:CGRectNull];
}

- (void)roundingCorner:(UIRectCorner)roundCorner radius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth rect:(CGRect)realRect{
    [self roundingCorner:roundCorner radius:radius backgroundColor:bgColor borderConfig:^(CAShapeLayer *border){
        border.strokeColor = borderColor.CGColor;
        border.lineWidth = borderWidth;
    } rect:realRect];
}

- (void)roundingCorner:(UIRectCorner)roundCorner radius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderConfig:(DBCommonBlock)borderConfig rect:(CGRect)realRect {
    [self _roundingCorner:roundCorner radius:radius backgroundColor:bgColor borderConfig:borderConfig rect:realRect];
}

- (void)roundingCornerUsingAutoLayout:(UIRectCorner)roundCorner radius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderConfig:(DBCommonBlock)borderConfig {
    if (!CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        self.dbCornerFrame = self.frame;
        [self _roundingCorner:roundCorner radius:radius backgroundColor:bgColor borderConfig:borderConfig rect:self.dbCornerFrame];
    }
    __weak typeof(self) weakSelf = self;
    [self setDbLayoutBlock:^(CGRect rect){
        [weakSelf _roundingCorner:roundCorner radius:radius backgroundColor:bgColor borderConfig:borderConfig rect:rect];
    }];
}

- (void)_roundingCorner:(UIRectCorner)roundCorner radius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderConfig:(DBCommonBlock)borderConfig rect:(CGRect)realRect {
    CGRect bounds = CGSizeEqualToSize(realRect.size, CGSizeZero) ? self.bounds : realRect;
    bounds.size.width += .13*Screen_Scale;
    bounds.size.height += .13*Screen_Scale;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    /*
     需要 优化 AutoLayout 自动计算
     CGSize size = [customContentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
     */
    
    [self removeDBCorner];
    
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(-0.2, -0.2, width, height)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.name = DBCornerLayerName;
    /*
     http://huanyueyaoqin.com/2015/07/15/UIBezierPath%E5%AD%A6%E4%B9%A0%E6%80%BB%E7%BB%93/
     */
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:roundCorner cornerRadii:CGSizeMake(radius, 0)];
    [path  appendPath:cornerPath];
    //[path setUsesEvenOddFillRule:YES];
    shapeLayer.path = path.CGPath;
    /*
     字面意思是“奇偶”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点的数量。如果结果是奇数则认为点在内部，是偶数则认为点在外部
     */
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.fillColor = bgColor.CGColor;
    if (borderConfig) {
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:roundCorner cornerRadii:CGSizeMake(radius, 0)];
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.path = borderPath.CGPath;
        borderLayer.fillColor = UIColor.clearColor.CGColor;
        [shapeLayer addSublayer:borderLayer];
        
        borderConfig(borderLayer);
    }
    if ([self isKindOfClass:[UILabel class]]) {
        //UILabel 机制不一样的  UILabel 设置 text 为 中文 也会造成图层混合 (iOS8 之后UILabel的layer层改成了 _UILabelLayer 具体可阅读 http://www.jianshu.com/p/db6602413fa3 )
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.layer addSublayer:shapeLayer];
        });
        return;
    }
    
    [self.layer addSublayer:shapeLayer];
}
//view添加点击手势
- (void (^)(UIView *))block{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setBlock:(void (^)(UIView *))block{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (void)addTapGestureBlock:(void (^)(UIView *))block{
    self.block = block;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView:)]];
}
- (void)clickView:(UIView*)view{
    if (self.block) {
        self.block(view);
    }
}

-(void)removeDBCorner {
    if ([self hasDBCornered]) {
        CALayer *layer = nil;
        for (CALayer *subLayer in self.layer.sublayers) {
            if ([subLayer.name isEqualToString:DBCornerLayerName]) {
                layer = subLayer;
            }
        }
        [layer removeFromSuperlayer];
    }
}

- (BOOL)hasDBCornered {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAShapeLayer class]] && [subLayer.name isEqualToString:DBCornerLayerName]) {
            return YES;
        }
    }
    return NO;
}

-(void)layoutSubviews {
    if (self.dbLayoutBlock && !CGSizeEqualToSize(self.frame.size,self.dbCornerFrame.size)) {
        self.dbCornerFrame = self.frame;
        self.dbLayoutBlock(self.dbCornerFrame);
    }
}

#pragma mark -- private

-(void)setDbCornerFrame:(CGRect)dbCornerFrame{
    objc_setAssociatedObject(self, @selector(dbCornerFrame), [NSValue valueWithCGRect:dbCornerFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGRect)dbCornerFrame{
    NSValue *value = objc_getAssociatedObject(self, _cmd);
    return value.CGRectValue;
}

-(void)setDbLayoutBlock:(DBCommonBlock)dbLayoutBlock{
    objc_setAssociatedObject(self, @selector(dbLayoutBlock), dbLayoutBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(DBCommonBlock)dbLayoutBlock{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)createBottomLineWithSpace:(CGFloat)space{
    [self createBottomLineWithSpace:space viewHeight:self.height];
}
- (void)createBottomLineWithSpace:(CGFloat)space viewHeight:(CGFloat)height{
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(space, height-0.5, kWidth, 0.5)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}
@end
