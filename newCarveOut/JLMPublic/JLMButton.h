//
//  JLMButton.h
//  JLMShop
//
//  Created by yangshuai on 2017/8/30.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLMButton : UIButton
@property(nonatomic,copy) void(^block)(UIButton*);
-(void)addTapBlock:(void(^)(UIButton *btn))block;

@end
