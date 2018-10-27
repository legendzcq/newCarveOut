//
//  MRBaseUIView.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/12.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRBaseUIView.h"

@implementation MRBaseUIView
//初始化输入框
-(UITextField *)setupTextfieldplaceholder:(NSString *)placeholder
                        issecureTextEntry:(BOOL)issecureTextEntry
                                backFrame:(CGRect)CGRect
                            andFieldFrame:(CGRect)fieldCGRect

{
    int tempHeight=CGRect.size.height;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRect];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    [self bringSubviewToFront:backgroundView];
    
    
    UITextField * UITextFieldValueField =[[UITextField alloc]initWithFrame:fieldCGRect];
    UITextFieldValueField.placeholder = placeholder;
    UITextFieldValueField.font = kFont(14);
    UITextFieldValueField.secureTextEntry = issecureTextEntry;
    UITextFieldValueField.clearButtonMode = UITextFieldViewModeNever;
    UITextFieldValueField.textColor = kTitleColor;
    [backgroundView addSubview:UITextFieldValueField];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(16, tempHeight-0.5, kWidth-32, 0.5)];
    lineView1.backgroundColor = kLineColor;
    [backgroundView addSubview:lineView1];
    
    return UITextFieldValueField;
}

@end
