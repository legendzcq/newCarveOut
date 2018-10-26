//
//  JLMPublicModel.m
//  JLMClient
//
//  Created by yangshuai on 2017/11/7.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMPublicModel.h"

@implementation JLMPublicModel
+ (void)getDataWithParameter:(NSDictionary *)dic withVC:(JLMBaseViewController *)vc SuccessBlock:(requestDataDidSuccess)successBlock{
    
}
- (NSMutableArray *)dataArray{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

