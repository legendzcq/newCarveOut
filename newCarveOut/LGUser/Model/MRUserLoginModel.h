//
//  MRUserLoginModel.h
//  
//
//  Created by yangshuai on 2017/9/19.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRUserLoginModel : NSObject<NSCoding, NSCopying>
/**
 用户ID
 */
@property (nonatomic,strong) NSNumber * id;
/**
 是否认证
 */
@property (nonatomic,assign) BOOL authStatus;
/**
 是否设置支付密码
 */
@property (nonatomic,assign) BOOL settingPayPassword;
/**
token令牌
 */
@property (nonatomic,strong) NSString * token;

/**
 *  保存账号
 *
 *  @param account 账号模型
 */
+ (BOOL)saveAccount:(MRUserLoginModel *)account;
/**
 *  获取账号
 */
+ (MRUserLoginModel *)account;
/**
 *  删除保存的用户信息(就是还原到未登录状态)
 *
 *  @return 是否成功
 */
+ (BOOL)removeAccount;

/**
 判断是否登录
 */
+ (BOOL)isLogin;
@end
