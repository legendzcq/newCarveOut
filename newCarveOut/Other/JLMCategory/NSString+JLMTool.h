//
//  NSString+FFTTool.h
//  CrowdFunding
//
//  Created by 杨帅 on 2017/7/5.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JLMTool)
/**
 *  32位MD5加密
 */
@property (nonatomic,copy,readonly) NSString *md5;

/**
 *  SHA1加密
 */
@property (nonatomic,copy,readonly) NSString *sha1;
/*
 *  document根文件夹
 */
+(NSString *)documentFolder;


/*
 *  caches根文件夹
 */
+(NSString *)cachesFolder;




/**
 *  生成子文件夹
 *
 *  如果子文件夹不存在，则直接创建；如果已经存在，则直接返回
 *
 *  @param subFolder 子文件夹名
 *
 *  @return 文件夹路径
 */
-(NSString *)createSubFolder:(NSString *)subFolder;
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//昵称
+ (BOOL)validateNickName:(NSString*)nickname;
//姓名
+ (BOOL) validateName:(NSString *)name;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//身份证校验
+ (BOOL)verifyIDCardNumber:(NSString *)value;

//纯数字
+ (BOOL)isPureInt:(NSString*)string;
//字母和数字
+(BOOL)isPassword:(NSString*)passWord;

+(BOOL)validatePassword:(NSString*)passWord;
//验证输入的是否是空格或者空
+(BOOL)validateInputSpace:(NSString*)string;
//输入金额中间用逗号分割
+(NSString*)strmethodComma:(NSString*)string;
//判断字符串不是nil或者null
+(BOOL)isNullToString:(NSString*)string;
//金额字符串加逗号
+(NSString *)countNumAndChangeformat:(NSString *)num;
//身份证加星号
+ (NSString *)replaceStringWithString:(NSString*)string Asterisk:(NSInteger)startLocation length:(NSInteger)length;
+ (CGSize)sizeWithText:(NSString *)text height:(CGFloat)height font:(NSInteger)font;

//后台转iso - 8859 -1
+ (NSString *)unicode2ISO88591:(NSString *)string;
+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width font:(NSInteger)font;
+ (NSString*)TimestampToTime:(NSString*)timestamp withPrefixString:(NSString*)string;//时间戳转换成时间
+ (NSString*)TimeToTimestamp:(NSString*)time;//time转换时间戳
/**
 字典转json字符串
 
 @param dict dict description
 @return return value description
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
/**
 格式化金额
 
 @param money money description
 @return return value description
 */
+ (NSString *)fommatMoney:(NSString *)money;

/**
 验证码

 @param passWord passWord description
 @return return value description
 */
+(BOOL)isCodePwd:(NSString*)passWord;
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size;
/**
 微信号

 @param code code description
 @return return value description
 */
+(BOOL)isWXCode:(NSString*)code;
//米自适应数转换千米
+ (NSString*)distanceAdaptation:(CGFloat)distance;
//如果为直辖市 去掉市
+ (NSString*)filtrationAddress:(NSString*)address;

/**
 获取设备uuid

 @return return value description
 */
+ (NSString *)getUUIDString;
//限制登录手机号
+ (NSString *)confineUserPhone:(NSString*)string;
//限制登录密码
+ (NSString *)confineUserPassword:(NSString*)string;
//限制验证码
+ (NSString *)confineVerificationCode:(NSString*)string;
//限制用户名输入
+ (NSString *)confineUserName:(NSString*)string;

@end
