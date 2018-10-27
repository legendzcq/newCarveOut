//
//  alertAppraiseView.h
//  newCarveOut
//
//  Created by 张传奇 on 2018/10/27.
//  Copyright © 2018 张传奇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AlertResult)(CGFloat index);
@interface alertAppraiseView : UIView

@property (nonatomic,copy) AlertResult resultIndex;
- (instancetype)initWithSkill:(NSString *)skill;

- (void)showXLAlertView;
@end

NS_ASSUME_NONNULL_END
