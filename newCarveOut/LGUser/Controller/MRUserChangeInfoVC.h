//
//  MRUserChangeInfoVC.h
//  MRClient
//
//  Created by 张传奇 on 2018/8/1.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRBaseViewController.h"
#import "MRUserModel.h"
typedef NS_ENUM(NSUInteger,ChangeInfoType){
    ChangeInfoTypeName = 0,
    ChangeInfoTypeEmail,
};

@interface MRUserChangeInfoVC : MRBaseViewController
@property(nonatomic)ChangeInfoType infoType;
@property(nonatomic,  copy)NSString * string;//邮箱或者昵称
@end
