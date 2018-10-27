//
//  MRBaseTabBarController.m
//  MRShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "MRBaseTabBarController.h"
#import "YSTabBarController.h"
#import "MRTenementViewController.h"
#import "MRApartmentViewController.h"
#import "MRLifeViewController.h"
#import "MRUserViewController.h"
#import "MRUserLoginVC.h"
@interface MRBaseTabBarController ()<YSTabBarDelegate>

@end

@implementation MRBaseTabBarController
+ (MRBaseTabBarController *)shardManager{
    static MRBaseTabBarController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MRBaseTabBarController alloc] init];
    });
    
    return instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    [MRBaseTabBarController shardManager].tabBar.itemTitleColor = kSubtitleColor;
    [MRBaseTabBarController shardManager].tabBar.itemTitleSelectedColor = kTabSelectColor;
    [MRBaseTabBarController shardManager].view.height = TabbarHeight;

}
- (void)initViewControllers {
    MRTenementViewController *vc1 = [[MRTenementViewController alloc] init];
    vc1.ys_tabItemTitle = @"问答";
    vc1.ys_tabItemImage = [UIImage imageNamed:@"mr_tabbar_tenement_unselect"];
    vc1.ys_tabItemSelectedImage = [UIImage imageNamed:@"mr_tabbar_tenement_select"];

    MRApartmentViewController * vc2 = [[MRApartmentViewController alloc]init];
    vc2.ys_tabItemTitle = @"创作";
    vc2.ys_tabItemImage = [UIImage imageNamed:@"mr_tabbar_apartment_unselect"];
    vc2.ys_tabItemSelectedImage = [UIImage imageNamed:@"mr_tabbar_apartment_select"];

    
    MRLifeViewController * vc3 = [[MRLifeViewController alloc]init];
    vc3.ys_tabItemTitle = @"项目";
    vc3.ys_tabItemImage = [UIImage imageNamed:@"mr_tabbar_life_unselect"];
    vc3.ys_tabItemSelectedImage = [UIImage imageNamed:@"mr_tabbar_life_select"];
    
    MRLifeViewController * vc4 = [[MRLifeViewController alloc]init];
    vc4.ys_tabItemTitle = @"招聘";
    vc4.ys_tabItemImage = [UIImage imageNamed:@"mr_tabbar_life_unselect"];
    vc4.ys_tabItemSelectedImage = [UIImage imageNamed:@"mr_tabbar_life_select"];
    
//    if ([MRUserLoginModel isLogin]) {
        MRUserViewController *vc5 = [[MRUserViewController alloc] init];
        vc5.ys_tabItemTitle = @"我的";
        vc5.ys_tabItemImage = [UIImage imageNamed:@"mr_tabbar_user_unselect"];
        vc5.ys_tabItemSelectedImage = [UIImage imageNamed:@"mr_tabbar_user_select"];
        self.viewControllers = [NSMutableArray arrayWithObjects:vc1,vc2,vc3,vc4,vc5,nil];
//    }else{
//        MRUserLoginVC *vc4 = [[MRUserLoginVC alloc] init];
//        vc4.ys_tabItemTitle = @"我的";
//        vc4.ys_tabItemImage = [UIImage imageNamed:@"mr_tabbar_user_unselect"];
//        vc4.ys_tabItemSelectedImage = [UIImage imageNamed:@"mr_tabbar_user_select"];
//        [MRBaseTabBarController shardManager].viewControllers = [NSMutableArray arrayWithObjects:vc1,vc2,vc3,vc4,nil];
//    }
}
- (void)setTabBarItem{
    [self initViewControllers];
    [MRBaseTabBarController shardManager].selectedControllerIndex = 3;
}
- (void)setLoginTabBarItem{
    MRUserViewController *vc4 = [[MRUserViewController alloc] init];
    vc4.ys_tabItemTitle = @"我的";
    vc4.ys_tabItemImage = [UIImage imageNamed:@"mr_tabbar_user_unselect"];
    vc4.ys_tabItemSelectedImage = [UIImage imageNamed:@"mr_tabbar_user_select"];
    NSMutableArray * array =  [[MRBaseTabBarController shardManager].viewControllers mutableCopy];
    [array replaceObjectAtIndex:3 withObject:vc4];
    [MRBaseTabBarController shardManager].viewControllers = array;

}

- (void)ys_tabBar:(YSTabBar *)tabBar willSelectItemAtIndex:(NSUInteger)index {

}
@end
