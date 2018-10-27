//
//  MRPublicModel.m
//  MRClient
//
//  Created by yangshuai on 2017/11/7.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "MRPublicModel.h"

@implementation MRPublicModel
+ (void)getDataWithParameter:(NSDictionary *)dic withVC:(MRBaseViewController *)vc SuccessBlock:(requestDataDidSuccess)successBlock{
    
}
- (NSMutableArray *)dataArray{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

