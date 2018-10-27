//
//  MRUserSystemInformationCell.h
//  MRClient
//
//  Created by yangshuai on 2018/7/13.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MRUserInformationModel;
@interface MRUserSystemInformationCell : UITableViewCell
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * subTitleLabel;
//style 1可查看详情 2不可查看详情
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withStyle:(NSInteger)cellStyle;
@property (nonatomic,strong)MRUserInformationModel * infoModel;
@end
