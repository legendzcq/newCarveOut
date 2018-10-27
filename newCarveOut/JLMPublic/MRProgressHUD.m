//
//  MRProgressHUD.m
//  MRStore
//
//  Created by yangshuai on 2017/9/19.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "MRProgressHUD.h"

@implementation MRProgressHUD

+(instancetype)shareinstance{
    
    static MRProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MRProgressHUD alloc] init];
    });
    
    return instance;
    
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(MRProgressMode )myMode{
    [self show:msg inView:view mode:myMode customImgView:nil];
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(MRProgressMode )myMode customImgView:(UIImageView *)customImgView{
    //如果已有弹框，先消失
    if ([MRProgressHUD  shareinstance].hud != nil) {
        [[MRProgressHUD  shareinstance].hud hideAnimated:YES];
        [MRProgressHUD  shareinstance].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [MRProgressHUD  shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //[MRProgressHUD  shareinstance].hud.dimBackground = YES;    //是否显示透明背景
    
    //是否设置黑色背景，这两句配合使用
//    [MRProgressHUD  shareinstance].hud.bezelView.color = [UIColor blackColor];
//    [MRProgressHUD  shareinstance].hud.contentColor = [UIColor whiteColor];
//    
    [[MRProgressHUD  shareinstance].hud setMargin:10];
    [[MRProgressHUD  shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [MRProgressHUD  shareinstance].hud.label.text = msg;
    
//    [MRProgressHUD  shareinstance].detailsLabel.font = [UIFont systemFontOfSize:14];
    switch ((NSInteger)myMode) {
        case MRProgressModeOnlyText:
            [MRProgressHUD  shareinstance].hud.mode = MBProgressHUDModeText;
            
            break;
        case MRProgressModeLoading:
            [MRProgressHUD  shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
            //        case MRProgressModeCircleLoading:{
            //            [MRProgressHUD  shareinstance].hud.mode = MBProgressHUDModeDeterminate;
            //
            //            break;
            //        }
        case MRProgressModeSuccess:
            [MRProgressHUD  shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [MRProgressHUD  shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        default:
            break;
    }
    
    
    
}


+(void)hide{
    if ([MRProgressHUD  shareinstance].hud != nil) {
        [[MRProgressHUD  shareinstance].hud hideAnimated:YES];
    }
}


+(void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:MRProgressModeOnlyText];
    [[MRProgressHUD  shareinstance].hud hideAnimated:YES afterDelay:2.0];
}



+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:MRProgressModeOnlyText];
    [[MRProgressHUD  shareinstance].hud hideAnimated:YES afterDelay:delay];
}

+(void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:MRProgressModeSuccess];
    [[MRProgressHUD  shareinstance].hud hideAnimated:YES afterDelay:3.0];
    
}


+(void)showProgress:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:MRProgressModeLoading];
}
+ (void)show:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:MRProgressModeLoading];
}
+(MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = msg;
    return hud;
    
    
}


+(void)showMsgWithoutView:(NSString *)msg{
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view mode:MRProgressModeOnlyText];
    [[MRProgressHUD  shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}

+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view{
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:view mode:MRProgressModeCustomAnimation customImgView:showImageView];
    
    //这句话是为了展示几秒，实际要去掉
    [[MRProgressHUD  shareinstance].hud hideAnimated:YES afterDelay:8.0];
    
    
}

@end
