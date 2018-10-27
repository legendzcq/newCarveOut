//
//  MRProgressHUD.h
//  MRStore
//
//  Created by yangshuai on 2017/9/19.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
typedef enum{
  MRProgressModeOnlyText,           //文字
  MRProgressModeLoading,              //加载菊花
  MRProgressModeCircleLoading,         //加载圆形
  MRProgressModeCustomAnimation,         //自定义加载动画（序列帧实现）
  MRProgressModeSuccess               //成功
    
}MRProgressMode;

@interface MRProgressHUD : NSObject

/*===============================   属性   ================================================*/

@property (nonatomic,strong) MBProgressHUD  *hud;


/*===============================   方法   ================================================*/

+(instancetype)shareinstance;

//显示
+(void)show:(NSString *)msg inView:(UIView *)view mode:(MRProgressMode )myMode;
//加载中
+(void)show:(NSString *)msg inView:(UIView *)view;

//隐藏
+(void)hide;

//显示提示（1秒后消失）
+(void)showMessage:(NSString *)msg inView:(UIView *)view;

//显示提示（N秒后消失）
+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay;

//显示进度(转圈)
+(MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view;

//显示进度(菊花)
+(void)showProgress:(NSString *)msg inView:(UIView *)view;

//显示成功提示
+(void)showSuccess:(NSString *)msg inview:(UIView *)view;

//在最上层显示
+(void)showMsgWithoutView:(NSString *)msg;

//显示自定义动画(自定义动画序列帧  找UI做就可以了)
+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view;

@end
