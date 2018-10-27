//
//  MRUserShowImageCell.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/3.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserShowImageCell.h"

@implementation MRUserShowImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.isShowLine = YES;
      self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setIsShowLine:(BOOL)isShowLine {
    _isShowLine = isShowLine;
    if (isShowLine) {
        self.topLineView.hidden = NO;
        self.bottomLineView.hidden = NO;
    }else
    {
        self.topLineView.hidden = YES;
        self.bottomLineView.hidden = YES;
    }
}
+(CGFloat)cellHeight{
    return 124;
}
@end
