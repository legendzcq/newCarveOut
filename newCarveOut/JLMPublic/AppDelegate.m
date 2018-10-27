//
//  AppDelegate.m
//  newCarveOut
//
//  Created by 张传奇 on 2018/10/26.
//  Copyright © 2018 张传奇. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "LaunchIntroductionView.h"
#import <Bugly/Bugly.h>
#import "JxbDebugTool.h"
#import "NSString+JLMTool.h"
#import <UMSocialCore/UMSocialCore.h>    // 分享组件
#import "JLMBaseTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
            [[JxbDebugTool shareInstance] setMainColor:[UIColor blackColor]];
            [[JxbDebugTool shareInstance] enableDebugMode];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    已登录
    JLMBaseTabBarController *controller = [[JLMBaseTabBarController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.navigationBarHidden = YES;
    self.window.rootViewController = navController;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//清除角标
    [self setupBugly];
    [self.window makeKeyAndVisible];
    LaunchIntroductionView *launch =[LaunchIntroductionView sharedWithImages:@[@"jlm_firstEntry1",@"jlm_firstEntry2",@"jlm_firstEntry3"] buttonImage:@"立即体验" buttonFrame:CGRectMake((kWidth-110)*0.5, kHeight-48-45, 110, 45)];
    launch.currentColor = [UIColor colorWithHexString:@"666768"];
    launch.nomalColor = [UIColor colorWithHexString:@"ecedee"];
    
    [self setupUM];   // required: setting platforms on demand
    [self setupBugly];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//设置bugly
- (void)setupBugly {
    BuglyConfig * config = [[BuglyConfig alloc] init];
    config.debugMode = YES;
    config.blockMonitorEnable = YES;
    config.blockMonitorTimeout = 1.5;
    config.channel = @"Bugly";
    config.delegate = self;
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = NO;
    [Bugly startWithAppId:kBuglyID
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    [self performSelectorInBackground:@selector(testLogOnBackground) withObject:nil];
}
/**
 *    @brief TEST method for BuglyLog
 */
- (void)testLogOnBackground {
    int cnt = 0;
    while (1) {
        cnt++;
        switch (cnt % 5) {
            case 0:
                BLYLogError(@"Test Log Print %d", cnt);
                break;
            case 4:
                BLYLogWarn(@"Test Log Print %d", cnt);
                break;
            case 3:
                BLYLogInfo(@"Test Log Print %d", cnt);
                BLYLogv(BuglyLogLevelWarn, @"BLLogv: Test", NULL);
                break;
            case 2:
                BLYLogDebug(@"Test Log Print %d", cnt);
                BLYLog(BuglyLogLevelError, @"BLLog : %@", @"Test BLLog");
                break;
            case 1:
            default:
                BLYLogVerbose(@"Test Log Print %d", cnt);
                break;
        }
        
        // print log interval 1 sec.
        sleep(1);
    }
}

#pragma mark - BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    NSLog(@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,exception);
    
    return @"This is an attachment";
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
    }
    return YES;
}

#pragma mark - UMshare
-(void)setupUM {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self configUSharePlatforms];
}


- (void)configUSharePlatforms{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx8223436422ee274c" appSecret:@"f09c39db4b1542905db661ab6e634a86" redirectURL:nil];
    
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106838766"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
}
@end
