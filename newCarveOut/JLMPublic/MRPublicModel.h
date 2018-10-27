//
//  MRPublicModel.h
//  MRClient
//
//  Created by yangshuai on 2017/11/7.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
/**定义请求成功的block*/
typedef void(^ requestDataDidSuccess)( NSMutableArray * listArray ,NSInteger isLastPage);
@interface MRPublicModel : NSObject
@property (nonatomic,strong) NSMutableArray * dataArray;
+ (void)getDataWithParameter:(NSDictionary*)dic withVC:(MRBaseViewController*)vc SuccessBlock:(requestDataDidSuccess)successBlock;
@end
