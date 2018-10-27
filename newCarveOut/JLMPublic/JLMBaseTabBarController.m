//
//  JLMBaseTabBarController.m
//  JLMShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMBaseTabBarController.h"
#import "YSTabBarController.h"
#import "JLMHomeViewController.h"
#import "JLMShopViewController.h"
#import "JLMOrderViewController.h"
#import "JLMUserViewController.h"
#import "JLMRootNaviController.h"
#import "MRUserLoginVC.h"
#import "MRUserLoginModel.h"
#import "JLMRootNaviController.h"

@interface JLMBaseTabBarController ()<YSTabBarDelegate>

@end

@implementation JLMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    self.tabBar.itemTitleColor = kSubtitleColor;
    self.tabBar.itemTitleSelectedColor = kTabSelectColor;
    self.view.height = TabbarHeight;

}
- (void)initViewControllers {
    
    JLMHomeViewController *vc1 = [[JLMHomeViewController alloc] init];
    vc1.ys_tabItemTitle = @"首页";
    vc1.ys_tabItemImage = [UIImage imageNamed:@"jlm_tabbar_home_unselect"];
    vc1.ys_tabItemSelectedImage = [UIImage imageNamed:@"jlm_tabbar_home_select"];

    JLMShopViewController * vc2 = [[JLMShopViewController alloc]init];
    vc2.ys_tabItemTitle = @"商城";
    vc2.ys_tabItemImage = [UIImage imageNamed:@"jlm_tabbar_shop_unselect"];
    vc2.ys_tabItemSelectedImage = [UIImage imageNamed:@"jlm_tabbar_shop_select"];

    
    JLMOrderViewController * vc3 = [[JLMOrderViewController alloc]init];
    vc3.ys_tabItemTitle = @"订单";
    vc3.ys_tabItemImage = [UIImage imageNamed:@"jlm_tabbar_order_unselect"];
    vc3.ys_tabItemSelectedImage = [UIImage imageNamed:@"jlm_tabbar_order_select"];
    
    
    JLMUserViewController *vc4 = [[JLMUserViewController alloc] init];
    vc4.ys_tabItemTitle = @"我的";
    vc4.ys_tabItemImage = [UIImage imageNamed:@"jlm_tabbar_user_unselect"];
    vc4.ys_tabItemSelectedImage = [UIImage imageNamed:@"jlm_tabbar_user_select"];
    self.viewControllers = [NSMutableArray arrayWithObjects:vc1,vc2,vc3,vc4,nil];
    
}


//- (BOOL)ys_tabBar:(YSTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index {
//    if (![MRUserLoginModel isLogin] && (index == 2 || index == 3)) {
//        MRUserLoginVC * vc = [MRUserLoginVC new];
//        JLMRootNaviController *naviVc = [[JLMRootNaviController alloc] initWithRootViewController:vc];
////        vc.isModeEntry = YES;
//        //        tabBar.selectedItemIndex = 0;
//        [self presentViewController:naviVc animated:YES completion:^{
//            self.selectedControllerIndex = 0;
//            tabBar.selectedItemIndex = 0;
//        }];
//        return NO;
//    }
//    return YES;
//}
@end
