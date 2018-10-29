//
//  AnswerViewController.h
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRBaseViewController.h"
@interface AnswerViewController : MRBaseViewController //答题界面

@property (nonatomic,copy) NSString *name;
/**
 交卷
 */
@property (nonatomic, copy, nullable) void(^assignmentChange)(AnswerViewController * asset, id error);
@end
