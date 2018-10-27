//
//  JLMShopHeaderCell.m
//  JLMStore
//
//  Created by yangshuai on 2017/9/18.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "MRShopHeaderCell.h"

@implementation MRShopHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
      self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.shopTitle = [[UILabel alloc]init];
    [self.contentView addSubview:self.shopTitle];
    [self.shopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView);
    }];
    self.shopTitle.text = @"用户头像";
    self.shopTitle.font = kFont(14);
    self.shopTitle.textColor = [UIColor colorWithHexString:@"666666"];
    
//    UIImageView * arrow = [[UIImageView alloc] init];
//    [self addSubview:arrow];
//    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-12);
//        make.centerY.equalTo(self);
//        make.size.mas_offset(CGSizeMake(6, 10));
//    }];
    
    UILabel * bottomTitleLab = [[UILabel alloc]init];
    bottomTitleLab.text = @"点击头像设置";
    bottomTitleLab.font = kFont(11);
    bottomTitleLab.textColor = [UIColor colorWithHexString:@"999999"];
    [self.contentView addSubview:bottomTitleLab];
    [bottomTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.shopTitle.mas_bottom).offset(8);
    }];
    
//    arrow.image = [UIImage imageNamed:@"mr_order_arrow_push"];
    self.shopImage = [[UIImageView alloc]initWithImage:kUserIconPlaceholder];
    [self addSubview:self.shopImage];
    [self.shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-12);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    self.shopImage.layer.masksToBounds = YES;
    self.shopImage.layer.cornerRadius = 30;

    UIView * line = [[UIView alloc]init];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];
    line.backgroundColor = kLineColor;
}
+(CGFloat)cellHeight{
    return 104;
}
@end
