//
//  FFTVerAlertView.h
//  FFTPlatform
//
//  Created by 张传奇 on 2018/4/27.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertResult)(NSInteger index);

@interface FFTVerAlertView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithVer:(NSString *)Ver message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)showXLAlertView;
@end
