//
//  NSString+FFTTool.m
//  CrowdFunding
//
//  Created by 杨帅 on 2017/7/5.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import "NSString+JLMTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
@implementation NSString (JLMTool)


//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//身份证
+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7+ ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10  + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6+ [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile{
    NSString *phoneRegex = @"^[0-9]{11}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];

}
//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[\u4E00-\u9FA5A-Za-z0-9_]{2,10}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//昵称
+ (BOOL)validateNickName:(NSString *)nickname{
    NSString *userNameRegex = @"^[\u4E00-\u9FA5A-Za-z0-9_]{2,10}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:nickname];
    return B;
}
//姓名
+ (BOOL)validateName:(NSString *)name{
    NSRange range1 = [name rangeOfString:@"·"];
    NSRange range2 = [name rangeOfString:@"•"];
    if(range1.location != NSNotFound ||   // 中文 ·
       range2.location != NSNotFound )    // 英文 •
    {
        //一般中间带 `•`的名字长度不会超过15位，如果有那就设高一点
        if ([name length] < 2 || [name length] > 15)
        {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+[·•][\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:name options:0 range:NSMakeRange(0, [name length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
    else
    {
        //一般正常的名字长度不会少于2位并且不超过8位，如果有那就设高一点
        if ([name length] < 2 || [name length] > 10) {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:name options:0 range:NSMakeRange(0, [name length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//纯数字
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
//字母或数字
+(BOOL)isPassword:(NSString*)passWord
{
    NSString *pass = @"(^[A-Za-z0-9]{1,8}$)";
    NSPredicate *passWordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pass];
    
    return [passWordTest evaluateWithObject:passWord];
    
    
}
+ (BOOL)validatePassword:(NSString *)passWord
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:passWord];
    return isMatch;
}
//验证码
+(BOOL)isCodePwd:(NSString*)passWord
{
    NSString *pass = @"(^[0-9]{6,6}$)";
    NSPredicate *passWordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pass];
    
    return [passWordTest evaluateWithObject:passWord];
    
}
+ (BOOL)validateInputSpace:(NSString *)string{
    if (string.length == 0 || string == nil || [string isKindOfClass:[NSNull class]]) {
        return NO;
    }else{
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [string stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return NO;
        } else {
            return YES;
        }
    }
}
+ (BOOL)isNullToString:(NSString *)string{
    if (string == nil || string == NULL) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (string.length ==0) {
        return NO;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    return YES;
}

+(NSString*)strmethodComma:(NSString*)string
{
    NSString *sign = nil;
    if ([string hasPrefix:@"-"]||[string hasPrefix:@"+"]) {
        sign = [string substringToIndex:1];
        string = [string substringFromIndex:1];
    }
    
    NSString *pointLast = [string substringFromIndex:[string length]-3];
    NSString *pointFront = [string substringToIndex:[string length]-3];
    
    int commaNum = (int)([pointFront length]-1)/3;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < commaNum+1; i++) {
        int index = (int)[pointFront length] - (i+1)*3;
        int leng = 3;
        if(index < 0)
        {
            leng = 3+index;
            index = 0;
            
        }
        NSRange range = {index,leng};
        NSString *stq = [pointFront substringWithRange:range];
        [arr addObject:stq];
    }
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = (int)[arr count]-1; i>=0; i--) {
        
        [arr2 addObject:arr[i]];
    }
    NSString *commaString = [[arr2 componentsJoinedByString:@","] stringByAppendingString:pointLast];
    if (sign) {
        commaString = [sign stringByAppendingString:commaString];
    }
    return commaString;
    
}
+ (NSString*)orderPriceWithRounding:(NSNumber*)price{
    if ([price floatValue]<10 &&[price floatValue] !=0 ) {
        return [NSString stringWithFormat:@"%.2f",[price floatValue]/100];
    }else{
        NSString * str = [NSString stringWithFormat:@"%.2f",[price floatValue]/100];
        if ([[str substringFromIndex:str.length-1]  isEqualToString:@"0"] &&[[str substringFromIndex:str.length-2]  isEqualToString:@"00"]) {
            return [NSString stringWithFormat:@"%.0f",[price floatValue]/100];
        }else if([[str substringFromIndex:str.length-1]  isEqualToString:@"0"] &&![[str substringFromIndex:str.length-2]  isEqualToString:@"0"]){
            return [NSString stringWithFormat:@"%.1f",[price floatValue]/100];
        }else{
            return [NSString stringWithFormat:@"%.2f",[price floatValue]/100];
        }
    }
    
}
+ (NSString*)orderPriceWithCDKey:(NSNumber*)price{
    if ([price floatValue]<10 &&[price floatValue] !=0 ) {
        return [NSString stringWithFormat:@"%.2f",[price floatValue]/100];
    }else{
        NSString * str = [NSString stringWithFormat:@"%.2f",[price floatValue]/100];
        if ([[str substringFromIndex:str.length-1]  isEqualToString:@"0"] &&[[str substringFromIndex:str.length-2]  isEqualToString:@"00"]) {
            return [NSString stringWithFormat:@"%.0f",[price floatValue]/100];
        }else if([[str substringFromIndex:str.length-1]  isEqualToString:@"0"] &&![[str substringFromIndex:str.length-2]  isEqualToString:@"0"]){
            return [NSString stringWithFormat:@"%.1f",[price floatValue]/100];
        }else{
            return [NSString stringWithFormat:@"%.2f",[price floatValue]/100];
        }
    }
}
+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width font:(NSInteger)font{
    return [text boundingRectWithSize:CGSizeMake(kWidth-width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
}
+ (CGSize)sizeWithText:(NSString *)text height:(CGFloat)height font:(NSInteger)font{
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
}
/**
 *  32位MD5加密
 */
-(NSString *)md5{
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result copy];
}




/**
 *  SHA1加密
 */
-(NSString *)sha1{
    
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result copy];
}
/*
 *  document根文件夹
 */
+(NSString *)documentFolder{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



/*
 *  caches根文件夹
 */
+(NSString *)cachesFolder{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
/**
 *  生成子文件夹
 *
 *  如果子文件夹不存在，则直接创建；如果已经存在，则直接返回
 *
 *  @param subFolder 子文件夹名
 *
 *  @return 文件夹路径
 */
-(NSString *)createSubFolder:(NSString *)subFolder{
    
    NSString *subFolderPath=[NSString stringWithFormat:@"%@/%@",self,subFolder];
    
    BOOL isDir = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:subFolderPath isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:subFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return subFolderPath;
}
+ (NSString *)TimestampToTime:(NSString *)timestamp withPrefixString:(NSString *)string{
    NSTimeInterval _interval=[timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSString stringWithFormat:@"%@%@",string,[objDateformat stringFromDate: date]];
}
+ (NSString *)TimeToTimestamp:(NSString *)time{
    return [NSString new];
}
//后台转iso - 8859 -1
+ (NSString *)unicode2ISO88591:(NSString *)string{
    if (![NSString isNullToString:string]) {
        return @"";
    }
    NSStringEncoding enc =      CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    return [NSString stringWithCString:[string UTF8String] encoding:enc];
}
+(NSString *)countNumAndChangeformat:(NSString *)num{
    if (![NSString isNullToString:num]) {
        return @"0";
    }
    if ([num floatValue]<1000) {
        return num;
    }
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}
+ (NSString *)replaceStringWithString:(NSString*)string Asterisk:(NSInteger)startLocation length:(NSInteger)length {
    for (NSInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        string = [string stringByReplacingCharactersInRange:range withString:@"*"]; startLocation ++;
    }
    return string;
}
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    NSLog(@"+++++%@+++++",mutStr);
    return mutStr;
    
}
+ (NSString *)fommatMoney:(NSString *)money
{
    // 判断是否null 若是赋值为0 防止崩溃
    if (([money isEqual:[NSNull null]] || money == nil)) {
        money = @"0";
    }
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    // 注意传入参数的数据长度，可用double
    NSString *newmoney = [formatter stringFromNumber:[NSNumber numberWithFloat:[money floatValue]]];
    
    
    
    //    NSNumber * aomout =   [NSNumber numberWithString:money];
    //    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //    formatter.positiveFormat = @",###.##"; // 正数格式
    //    // 注意传入参数的数据长度，可用double
    //    NSString *newmoney = [formatter stringFromNumber:aomout];
    newmoney = [NSString stringWithFormat:@"￥%@", newmoney];
    if(!([newmoney rangeOfString:@"."].location != NSNotFound))//_roaldSearchText
    {
        newmoney = [NSString stringWithFormat:@"%@.00",newmoney];
    }
    
    return [newmoney substringToIndex:newmoney.length-1];
}
//根据字符串的字体和size(此处size设置为字符串宽和MAXFLOAT)返回多行显示时的字符串size
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size {
    
    CGSize resultSize;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        //段落样式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        //字体大小，换行模式
        NSDictionary *attributes = @{NSFontAttributeName : font , NSParagraphStyleAttributeName : style};
        resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    } else {
        //计算正文的高度
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return resultSize;
}
//微信号
+(BOOL)isWXCode:(NSString*)code{
    NSString *pass = @"^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}+$";
    NSPredicate *passWordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pass];

    return [passWordTest evaluateWithObject:code];
//    return YES;
}
//距离自适应
+ (NSString *)distanceAdaptation:(CGFloat)distance{
    if(distance <1000){
        return [NSString stringWithFormat:@"%.0fm",distance];
    }else{
        distance = distance/1000;
        if (fmodf(distance, 1)==0) {//如果有一位小数点
            return [NSString stringWithFormat:@"%.0fkm",distance];
        } else if (fmodf(distance*10, 1)==0) {//如果有两位小数点
            return [NSString stringWithFormat:@"%.1fkm",distance];
        } else {
            NSString * disString = [NSString stringWithFormat:@"%.2f",distance];
            NSArray *array = [disString componentsSeparatedByString:@"."];
            if ([array[1] isEqualToString:@"00"]) {
                return [NSString stringWithFormat:@"%.0fkm",distance];
            }else{
                return [NSString stringWithFormat:@"%.2fkm",distance];
            }
        }
    }
}
+ (NSString*)filtrationAddress:(NSString*)address{
   return  [address stringByReplacingOccurrencesOfString:@"市" withString:@""];
}
+ (NSString *)getUUIDString
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}
+ (NSString *)confineUserPhone:(NSString*)string{
    if (string.length >11) {
        return  [string substringToIndex:11];
    }
    return string;
}
+(NSString *)confineUserPassword:(NSString *)string{
    if (string.length >18) {
        return  [string substringToIndex:18];
    }
    return string;
}
+(NSString *)confineVerificationCode:(NSString *)string{
    if (string.length >6) {
        return  [string substringToIndex:6];
    }
    return string;
}
+(NSString *)confineUserName:(NSString *)string{
    if (string.length >7) {
        return  [string substringToIndex:7];
    }
    return string;
}

@end
