//
//  MRUserSettingCell.h
//  MRClient
//
//  Created by 张传奇 on 2018/7/3.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRUserSettingCell : UITableViewCell
+ (CGFloat)cellHeight;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,copy) void (^btnClickBlock)(NSInteger index);
@end
