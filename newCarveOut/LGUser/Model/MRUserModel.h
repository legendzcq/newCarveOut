//
//  MRUserModel.h
//  MRClient
//
//  Created by yangshuai on 2018/8/13.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MRUserModel;
typedef void(^ requestUserDataSuccess)(MRUserModel * model);
@interface MRUserModel : NSObject<NSCoding, NSCopying>
@property (nonatomic,  copy) NSString * aboutUsUrl;//关于我们url
@property (nonatomic,  copy) NSString * authStatus;//认证状态
@property (nonatomic,  copy) NSString * customerName;//客户姓名
@property (nonatomic,  copy) NSString * headPortrait;//头像
@property (nonatomic,  copy) NSString * idCard;//身份证号
@property (nonatomic,  copy) NSString * mobile;//手机号
@property (nonatomic,strong) NSNumber * sex;//性别 1:男2:女
@property (nonatomic,strong) NSNumber * blance;
@property (nonatomic,  copy) NSString * checkGuideUrl;
@property (nonatomic,strong) NSNumber * cleaningId;
@property (nonatomic,strong) NSNumber * collectNumber;
@property (nonatomic,  copy) NSString * joinUsUrl;
@property (nonatomic,strong) NSNumber * orderNumber;
@property (nonatomic,strong) NSNumber * pactSeeNumber;
@property (nonatomic,strong) NSNumber * repairsId;
@property (nonatomic,  copy) NSString * serviceAdvisoryUrl;
@property (nonatomic,strong) NSNumber * settingPayPassword;
@property (nonatomic,strong) NSArray  * steward;
@property (nonatomic,  copy) NSString * userName;
@property (nonatomic,  copy) NSString * nicName;
@property (nonatomic,  copy) NSString * email;
@property (nonatomic,  copy) NSString * area;//房屋面积 ,
@property (nonatomic,strong) NSNumber * contractId;//合同id
@property (nonatomic,  copy) NSString * houseImage;//房屋图片
@property (nonatomic,  copy) NSString * houseName;//房屋名称
@property (nonatomic,strong) NSNumber * rent;//租金 应退房租
@property (nonatomic,strong) NSNumber * id;
@property (nonatomic,strong) NSNumber * contractNumber;//合同编号 ,
@property (nonatomic,  copy) NSString * customerMobile;
@property (nonatomic,strong) NSNumber * houseId;
@property (nonatomic,  copy) NSString * terminationTime;
@property (nonatomic,strong) NSNumber * settlementMoney;//结算金额
@property (nonatomic,strong) NSNumber * serviceMoney;//应退服务费
@property (nonatomic,strong) NSNumber * deposit;//应退押金
@property (nonatomic,strong) NSNumber * breakMoney;//应退违约金
@property (nonatomic,strong) NSNumber * lifeMoney;//应退生活费 ,
@property (nonatomic,strong) NSNumber * sysUserId;//管家id ,
@property (nonatomic,  copy) NSString * sysUserName;//管家姓名 ,
@property (nonatomic,strong) NSNumber * status;//1申请解约2确认信息3已确认信息4已完成
@property (nonatomic,  copy) NSString * createTime;
@property (nonatomic,strong) NSNumber * otherMoney;
@property (nonatomic,strong) NSNumber * produceRent;
@property (nonatomic,strong) NSNumber * produceServiceMoney;
@property (nonatomic,strong) NSNumber * producePenaltyMoney;
@property (nonatomic,strong) NSNumber * retreatRent;
@property (nonatomic,strong) NSNumber * retreatDeposit;
/**
 *  保存用户信息
 *
 */
+ (BOOL)saveUserInfo:(MRUserModel *)userInfo;
/**
 *  获取用户信息
 */
+ (MRUserModel *)userInfo;
/**
 *  删除保存的用户信息
 *
 *  @return 是否成功
 */
+ (BOOL)removeUserInfo;

//个人设置资料
+ (void)requestUserDataSuccessBlock:(requestUserDataSuccess)successBlock;
//上传用户头像
+ (void)updateUserIconWithImage:(UIImage*)image successBlock:(requestUserDataSuccess)successBlock;

@end

@interface MRUserContractModel : NSObject
@property (nonatomic,strong) NSNumber * id;
@property (nonatomic,strong) NSNumber * status;//合同状态 0 已失效 1履行中 2申请退租
@property (nonatomic,  copy) NSString * contractNumber;//合同编号
@property (nonatomic,  copy) NSString * startTime;
@property (nonatomic,  copy) NSString * endTime;
@property (nonatomic,strong) NSNumber * rent;
@property (nonatomic,strong) NSNumber * leaseType;//租赁方式 1月 2季度 3半年 4全年
@property (nonatomic,strong) NSNumber * deliveryStatus;//交割状态 0未确认 已确认
@property (nonatomic,  copy) NSString * idCard;
@property (nonatomic,  copy) NSString * mobile;
@property (nonatomic,strong) NSNumber * customerId;
@property (nonatomic,  copy) NSString * name;
@property (nonatomic,assign) CGFloat    height;
@property (nonatomic,strong) NSNumber * contractTerminationStatus;//退租状态1申请解约2确认信息3已确认信息4已完成 
@end

