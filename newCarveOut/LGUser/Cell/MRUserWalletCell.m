//
//  MRUserWalletCell.m
//  MRClient
//
//  Created by yangshuai on 2018/7/23.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserWalletCell.h"

@implementation MRUserWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
