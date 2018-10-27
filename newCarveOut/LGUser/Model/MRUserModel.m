//
//  MRUserModel.m
//  MRClient
//
//  Created by yangshuai on 2018/8/13.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserModel.h"
#define MRUserInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.data"]

@implementation MRUserModel
+ (void)requestUserDataSuccessBlock:(requestUserDataSuccess)successBlock{
//    [YSNetWorkManager requestWithType:(HttpRequestTypeGet) withUrlString:kUser withParaments:nil withSuccessBlock:^(MRRequsetInfoModel *model) {
//        successBlock([MRUserModel modelWithDictionary:model.data]);
//        NSLog(@"%@",model.data);
//    }];
   
}
+ (void)updateUserIconWithImage:(UIImage*)image successBlock:(requestUserDataSuccess)successBlock{
    NSDictionary * dic = @{@"file":@"image.jpg"};
    [MRProgressHUD show:@"正在上传头像中..." inView:[[MRBaseViewController new] getCurrentVC].view];
//    [YSNetWorkManager uploadImageWithOperations:dic withImageArray:@[image] withtargetWidth:300 withUrlString:kUserUpLoadPic withFileName:nil withSuccessBlock:^(MRRequsetInfoModel *model) {
//        [MRProgressHUD hide];
//        if ([model.state integerValue]==0) {
//            successBlock([MRUserModel modelWithDictionary:model.data]);
//        }else{
//            [MRProgressHUD showMessage:model.msg inView:[[MRBaseViewController new] getCurrentVC].view];
//        }
//    } withFailurBlock:^(NSError * error) {
//        [MRProgressHUD showMessage:kLoadingFailedText inView:[[MRBaseViewController new] getCurrentVC].view];
//
//    } withUpLoadProgress:^(float progress) {
//
//    }];
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
    
    
}
- (NSUInteger)hash {
    return [self modelHash];
}
- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}
+ (BOOL)saveUserInfo:(MRUserModel *)userInfo{
    return [NSKeyedArchiver archiveRootObject:userInfo toFile:MRUserInfoPath];
}

+ (MRUserModel *)userInfo{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:MRUserInfoPath];
}

+ (BOOL)removeUserInfo{
    return [[NSFileManager defaultManager] removeItemAtPath:MRUserInfoPath error:nil];
}

@end

@implementation MRUserContractModel
@end

