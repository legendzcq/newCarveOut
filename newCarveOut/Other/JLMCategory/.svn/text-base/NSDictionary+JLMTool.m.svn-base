//
//  NSDictionary+JLMTool.m
//  JLMStore
//
//  Created by 张传奇 on 2017/10/26.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "NSDictionary+JLMTool.h"
@implementation NSDictionary (JLMTool)
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
     jsonString =[jsonString stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
