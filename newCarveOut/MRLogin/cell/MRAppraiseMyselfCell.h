//
//  MRAppraiseMyselfCell.h
//  newCarveOut
//
//  Created by 张传奇 on 2018/10/27.
//  Copyright © 2018 张传奇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class appraiseModel;
NS_ASSUME_NONNULL_BEGIN

@interface MRAppraiseMyselfCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *skillLab;
@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (nonatomic,strong) appraiseModel * model;
@end

NS_ASSUME_NONNULL_END
