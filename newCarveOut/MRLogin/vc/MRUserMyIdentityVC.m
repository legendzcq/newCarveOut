//
//  MRUserMyIdentityVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/25.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserMyIdentityVC.h"
#import "AnswerViewController.h"

#import <YYKit/YYKit.h>
@interface MRUserMyIdentityVC ()
@property (weak, nonatomic) IBOutlet UIView *backVIew;

@end

@implementation MRUserMyIdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationControllersWithVC:@"MRUserCheckIdentityVC"];
    self.titleLabel.text = @"自我评价";
    
}

- (IBAction)commitBtn:(id)sender {
    
    AnswerViewController *VC = [[AnswerViewController alloc] init];
    VC.name = @"类型齐全";
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
