//
//  UITableViewCell+MRTips.m
//  MRClient
//
//  Created by yangshuai on 2018/3/29.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "UITableViewCell+MRTips.h"
#import <objc/message.h>

static const void *kHud = @"k_labelHud";
static const void *kTapG = @"k_TapG";
static const void *kProTapG = @"k_Pro_TapG";

@interface UIViewController ()

@property (nonatomic,strong)UILabel *labelHud;
@property (nonatomic,strong)UITapGestureRecognizer *tapGestureBlock;

@end

@implementation UITableViewCell (MRTips)


- (void)setTapGestureBlock:(UITapGestureRecognizer *)tapGestureBlock {
    objc_setAssociatedObject(self, &kProTapG, tapGestureBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGestureBlock {
    return  objc_getAssociatedObject(self, &kProTapG);
}

- (UILabel *)labelHud {
    UILabel *subhud = objc_getAssociatedObject(self, &kHud);
    if (subhud == nil) {
        subhud = [[UILabel alloc]initWithFrame:CGRectMake(20,150, kWidth - 40, 30)];
        subhud.userInteractionEnabled = YES;
        subhud.textColor = [UIColor grayColor];
        subhud.font = [UIFont systemFontOfSize:14];
        subhud.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subhud];
        
        objc_setAssociatedObject(self, &kHud, subhud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return subhud;
}

#pragma mark - 显示状态
- (void)showStatus:(NSString *)status tapViewWithBlock:(tapViewWithBlock)block {
    [self addStatusAndImage:status imageName:nil type:nil tapViewWithBlock:block];
}

#pragma mark - 显示状态以及显示没有数据时的图片
- (void)showStatus:(NSString *)status imageName:(NSString *)imageName type:(NSString *)type tapViewWithBlock:(tapViewWithBlock)block {
    [self addStatusAndImage:status imageName:imageName type:type tapViewWithBlock:block];
}

/* 添加文字及图片 */
- (void)addStatusAndImage:(NSString *)status imageName:(NSString *)imageName type:(NSString *)type tapViewWithBlock:(tapViewWithBlock)block{
    if (self.labelHud.text ==nil) {
        if (status) {
            
            self.labelHud.text = status;
        }
        if (imageName) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.labelHud.mas_top).offset(-16);
                make.centerX.equalTo(self);
            }];
            if ([type isEqualToString:@"gif"]) {                
//                UIImage *image = [UIImage sd_animatedGIFNamed:imageName];
//                [imageView setImage:image];
                
            } else [imageView setImage:[UIImage imageNamed:imageName]];
            
            imageView.tag = 10086;
        }
        if (block) {
            
            objc_setAssociatedObject(self, &kTapG, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        // 添加手势
        [self addTapGesture];
    }
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

