//
//  MRAppraiseMyselfCell.m
//  newCarveOut
//
//  Created by 张传奇 on 2018/10/27.
//  Copyright © 2018 张传奇. All rights reserved.
//

#import "MRAppraiseMyselfCell.h"
#import "appraiseModel.h"
@implementation MRAppraiseMyselfCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(appraiseModel *)model {
    _model = model;
    self.skillLab.text = model.skill;
    self.rankLab.text = model.rank;
}

@end
