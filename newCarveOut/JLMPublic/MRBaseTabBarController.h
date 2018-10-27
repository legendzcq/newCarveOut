//
//  MRBaseTabBarController.h
//  MRShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "YSTabBarController.h"

@interface MRBaseTabBarController : YSTabBarController
+ (MRBaseTabBarController*)shardManager;
- (void)setTabBarItem;
- (void)setLoginTabBarItem;
@end
