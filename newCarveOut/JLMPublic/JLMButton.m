//
//  JLMButton.m
//  JLMShop
//
//  Created by yangshuai on 2017/8/30.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMButton.h"

@implementation JLMButton

-(void)addTapBlock:(void(^)(UIButton*))block
{
    self.block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click:(UIButton*)btn
{
    if(self.block) {
        self.block(btn);
    }
}

-(void)setBlock:(void(^)(UIButton*))block
{
    _block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}

@end
