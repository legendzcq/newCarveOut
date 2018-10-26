//
//  NSDate+JLMTool.h
//  JLMClient
//
//  Created by yangshuai on 2017/11/2.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JLMTool)
/** 获取当前的时间 */
+ (NSString *)currentDateString;
//获取下一天
+ (NSString *)nextDateString;
//获取下一天
+ (NSString *)nextYearDateString;
+ (NSInteger)getTheCountOfTwoDaysWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate;
+ (NSString *)lastDateString;
//获取当前时间戳 以毫秒为单位
+(NSString *)getNowTimeTimestamp;
@end
