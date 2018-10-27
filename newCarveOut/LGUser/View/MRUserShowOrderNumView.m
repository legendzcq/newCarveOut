//
//  MRUserShowOrderNumView.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/3.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserShowOrderNumView.h"

@implementation MRUserShowOrderNumView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MRUserShowOrderNumView" owner:nil options:nil];
        return [nibView objectAtIndex:0];
    }
    return self;
}

@end
