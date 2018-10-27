//
//  MRBaseRequsetModel.h
//  MRClient
//
//  Created by yangshuai on 2017/11/6.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequsetBaseModel : NSObject
@property (nonatomic,  copy) NSString * result;
@property (nonatomic,strong) NSNumber * code;
@property (nonatomic,strong) NSDictionary * info;
@end


@interface MRRequsetInfoModel : NSObject
@property (nonatomic,  copy) NSString * msg;
@property (nonatomic,strong) id  data;
@property (nonatomic,  copy) NSString * detail;
@property (nonatomic,strong) NSNumber * state;
@property (nonatomic,strong) NSNumber * isLastPage;
@property (nonatomic,strong) NSDictionary * info;
@property (nonatomic,assign) NSInteger  lastPage;
@end
