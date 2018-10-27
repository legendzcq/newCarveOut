//
//  MRBaseUIView.h
//  MRClient
//
//  Created by 张传奇 on 2018/7/12.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRBaseUIView : UIView
//初始化输入框
-(UITextField *)setupTextfieldplaceholder:(NSString *)placeholder
                        issecureTextEntry:(BOOL)issecureTextEntry
                                backFrame:(CGRect)CGRect
                            andFieldFrame:(CGRect)fieldCGRect;
@end
