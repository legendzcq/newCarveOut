//
//  NSDictionary+JLMTool.h
//  JLMStore
//
//  Created by 张传奇 on 2017/10/26.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JLMTool)

/**
 json字符串转字典

 @param jsonString jsonString description
 @return return value description
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
