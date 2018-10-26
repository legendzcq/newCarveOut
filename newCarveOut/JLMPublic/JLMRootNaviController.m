//
//  JLMRootNaviController.m
//  JLMStore
//
//  Created by yangshuai on 2017/9/1.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMRootNaviController.h"

@interface JLMRootNaviController ()
@end

@implementation JLMRootNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:YES];
}

- (void)back:(UIBarButtonItem *)item {
    [self popViewControllerAnimated:YES];
}


@end

