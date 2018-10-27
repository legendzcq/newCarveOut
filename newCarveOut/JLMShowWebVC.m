//
//  JLMShowWebVC.m
//  JLMStore
//
//  Created by 张传奇 on 2017/12/11.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMShowWebVC.h"
#import "SGWebView.h"
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
@interface JLMShowWebVC ()
{
    NSString * requrl;
}
@end

@implementation JLMShowWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"推荐码";
    [self.rightButton setImage:kImageNamed(@"jlm_user_share") forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];    
}



-(void)rightBtnClick
{
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRoundAndSuperRadius;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"选择要分享到的平台";
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        if (platformType == UMSocialPlatformType_WechatSession) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
        }else
        {
            
        }
        
        [self shareWebPageToPlatformType:platformType];
        //        [self shareImageAndTextToPlatformType:platformType];
        //        NSLog(@"%@",userInfo);
    }];
}


/**
 分享网页

 @param platformType platformType description
 */
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"举手之劳，招财进宝！" descr:@"邀请更多商户入驻积了么，就能享受业绩提成，别人消费你赚钱！赶快邀起来吧！" thumImage:[UIImage imageNamed:@"80"]];
    //设置网页地址
    shareObject.webpageUrl =  [NSString stringWithFormat:@"http://admin.jilemept.com/jlm-biz-cms/notIntercept/recommendHtml?recommendCode=%@",[MRUserLoginModel account].id.stringValue];
//    self.urlString;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}







//- (void)showBottomNormalView
//{
//    //加入copy的操作
//    //@see http://dev.umeng.com/social/ios/进阶文档#6
//    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+2
//                                     withPlatformIcon:[UIImage imageNamed:@"icon_circle"]
//                                     withPlatformName:@"演示icon"];
//
//    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
//#ifdef UM_Swift
//    [UMSocialSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
//#else
//        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//#endif
//            //在回调里面获得点击的
//            if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
//                NSLog(@"点击演示添加Icon后该做的操作");
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加自定义icon"
//                                                                    message:@"具体操作方法请参考UShareUI内接口文档"
//                                                                   delegate:nil
//                                                          cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                          otherButtonTitles:nil];
//                    [alert show];
//
//                });
//            }
//            else{
////                [self runShareWithType:platformType];
//            }
//        }];
//    }
//


@end
