//
//  MRUserLoginModel.m
//  
//
//  Created by yangshuai on 2017/9/19.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "MRUserLoginModel.h"
#define YLAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation MRUserLoginModel
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
+ (BOOL)saveAccount:(MRUserLoginModel *)account {
    return [NSKeyedArchiver archiveRootObject:account toFile:YLAccountPath];
}

+ (MRUserLoginModel *)account {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:YLAccountPath];
}

+ (BOOL)removeAccount {
    return [[NSFileManager defaultManager] removeItemAtPath:YLAccountPath error:nil];
}
+ (BOOL)isLogin{
   return [self account]==nil?NO:YES;
}

@end
