//
//  UIViewController+FFTHUD.m
//  CrowdFunding
//
//  Created by yangshuai on 2017/8/10.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import "UITableView+MRHUD.h"
#import <objc/message.h>
#import "UIImage+Gif.h"
static const void *kHud = @"k_labelHud";
static const void *kTapG = @"k_TapG";
static const void *kProTapG = @"k_Pro_TapG";
@interface UIViewController ()

@property (nonatomic,strong)UILabel *labelHud;
@property (nonatomic,strong)UITapGestureRecognizer *tapGestureBlock;

@end
@implementation UITableView (MRHUD)
- (void)setTapGestureBlock:(UITapGestureRecognizer *)tapGestureBlock {
    objc_setAssociatedObject(self, &kProTapG, tapGestureBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGestureBlock {
    return  objc_getAssociatedObject(self, &kProTapG);
}

- (UILabel *)labelHud {
    UILabel *subhud = objc_getAssociatedObject(self, &kHud);
    if (subhud == nil) {
        subhud = [[UILabel alloc]initWithFrame:CGRectMake(20,20, self.frame.size.width - 40, 30)];
        subhud.textColor = kColor(153, 153, 153);
        subhud.font = [UIFont systemFontOfSize:12];
        subhud.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subhud];
        
        objc_setAssociatedObject(self, &kHud, subhud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return subhud;
}

#pragma mark - 显示状态
- (void)showStatus:(NSString *)status showType:(MRNoDataType)showType tapViewWithBlock:(tapViewWithBlock)block{
    
    if (status) {
        self.labelHud.text = status;
    }
    if (block) {
        
        objc_setAssociatedObject(self, &kTapG, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    // 添加手势
    [self addTapGesture];
    if (showType == MRNoDataTypeTop) {
        [self.labelHud setFrame:CGRectMake(20, 20, kWidth-40, 30)];
        
    }else{
        [self.labelHud setFrame:CGRectMake(20, 0, kHeight-40, 30)];
        
    }
    
}

#pragma mark - 显示状态以及显示没有数据时的图片

/* 添加文字及图片 */
- (void)addStatusAndImage:(NSString *)status imageName:(NSString *)imageName type:(NSString *)type tapViewWithBlock:(tapViewWithBlock)block{
    
    if (status) {
        
        self.labelHud.text = status;
    }
    if (imageName) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 100) / 2, self.center.y - 100, 100, 100)];
        
        if ([type isEqualToString:@"gif"]) {
            
//            UIImage *image = [UIImage sd_animatedGIFNamed:imageName];
//            [imageView setImage:image];
            
        } else [imageView setImage:[UIImage imageNamed:imageName]];
        
        imageView.tag = 10086;
        [self addSubview:imageView];
    }
    if (block) {
        
        objc_setAssociatedObject(self, &kTapG, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    // 添加手势
    [self addTapGesture];
}

/* 添加点击手势 */
- (void)addTapGesture {
    
    if (self.tapGestureBlock) {
        [self show];
        return;
    }
    // 添加全屏手势
    self.tapGestureBlock = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBlock)];
    [self addGestureRecognizer:self.tapGestureBlock];
}

#pragma mark - 回调  Click return
- (void)tapBlock {
    tapViewWithBlock block = objc_getAssociatedObject(self, &kTapG);
    if (block) {
        block();
    }
}

#pragma mark - 显示 Tips show
- (void)show {
    
    self.labelHud.hidden = NO;
    UIImageView *imageView = [self viewWithTag:10086];
    imageView.hidden = NO;
    [self addGestureRecognizer: self.tapGestureBlock];
    
}

#pragma mark - 消失 Tips hide
- (void)hide {
    
    if (self.labelHud) {
        /* 动画
         __weak typeof(self) __weakSelf = self;
         [UIView animateWithDuration:1 animations:^{
         __weakSelf.labelHud.alpha = 0;
         } completion:^(BOOL finished) {
         [__weakSelf.labelHud removeFromSuperview];
         }];
         */
        
        self.labelHud.hidden = YES;
    }
    
    UIImageView *imageView = [self viewWithTag:10086];
    imageView.hidden = YES;
    [self removeGestureRecognizer: self.tapGestureBlock];
}

@end
