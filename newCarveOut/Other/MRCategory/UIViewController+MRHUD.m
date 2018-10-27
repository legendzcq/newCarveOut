//
//  UIViewController+FFTHUD.m
//  CrowdFunding
//
//  Created by yangshuai on 2017/8/10.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import "UIViewController+MRHUD.h"
#import <objc/message.h>
#import "UIImage+Gif.h"

static const void *kHud = @"k_labelHud";
static const void *kimageHud = @"k_kimageHud";

static const void *kTapG = @"k_TapG";
static const void *kProTapG = @"k_Pro_TapG";

@interface UIViewController ()

@property (nonatomic,strong)UILabel *labelHud;
@property (nonatomic,strong)UIImageView *imageHud;
@property (nonatomic,strong)UITapGestureRecognizer *tapGestureBlock;

@end

@implementation UIViewController (HUD)


- (void)setTapGestureBlock:(UITapGestureRecognizer *)tapGestureBlock {
    objc_setAssociatedObject(self, &kProTapG, tapGestureBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGestureBlock {
    return  objc_getAssociatedObject(self, &kProTapG);
}

- (UILabel *)labelHud {
    UILabel *subhud = objc_getAssociatedObject(self, &kHud);
    if (subhud == nil) {
        subhud = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.center.y, self.view.frame.size.width - 40, 30)];
        subhud.textColor = [UIColor grayColor];
        subhud.font = [UIFont systemFontOfSize:14];
        subhud.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:subhud];
        subhud.userInteractionEnabled = YES;
        objc_setAssociatedObject(self, &kHud, subhud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return subhud;
}
- (UIImageView *)imageHud {
    UIImageView *subhud = objc_getAssociatedObject(self, &kimageHud);
    if (subhud == nil) {
        subhud = [[UIImageView alloc]init];
        [self.view addSubview:subhud];
        [subhud mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.labelHud.mas_top).offset(-16);
            make.centerX.equalTo(self.view);
        }];
        objc_setAssociatedObject(self, &kimageHud, subhud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
            [self.imageHud setImage:kImageNamed(imageName)];
        }
        if (block) {
            objc_setAssociatedObject(self, &kTapG, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        [self.view bringSubviewToFront:self.labelHud];
        [self.view bringSubviewToFront:self.imageHud];
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
    [self.labelHud addGestureRecognizer:self.tapGestureBlock];
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
    self.imageHud.hidden = NO;
    [self.view addGestureRecognizer: self.tapGestureBlock];
    
}

#pragma mark - 消失 Tips hide
- (void)hide {
    if (self.labelHud) {
        self.labelHud.hidden = YES;
    }
    if (self.imageHud) {
        self.imageHud.hidden = YES;
    }
    [self.view removeGestureRecognizer: self.tapGestureBlock];
}

@end
