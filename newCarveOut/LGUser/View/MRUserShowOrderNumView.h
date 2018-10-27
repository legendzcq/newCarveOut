//
//  MRUserShowOrderNumView.h
//  MRClient
//
//  Created by 张传奇 on 2018/7/3.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRUserShowOrderNumView : UIView
@property (weak, nonatomic) IBOutlet UILabel *collectNumLab;
@property (weak, nonatomic) IBOutlet UILabel *watchNumLab;
@property (weak, nonatomic) IBOutlet UILabel *walletNumLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UIView *collectBackView;
@property (weak, nonatomic) IBOutlet UIView *orderBackView;
@property (weak, nonatomic) IBOutlet UIView *walletBackVIew;
@property (weak, nonatomic) IBOutlet UIView *watchNumBackView;

@end
