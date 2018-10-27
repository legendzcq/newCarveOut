//
//  JLMShopInfoCell.m
//  JLMStore
//
//  Created by yangshuai on 2017/9/18.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "MRShopInfoCell.h"

@implementation MRShopInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = NO;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(MRShopCellType)type{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        [self initWithType:type];
    }
    return self;
}
- (void)initWithType:(MRShopCellType)type{
    self.shopTitle = [[UILabel alloc]init];
    [self addSubview:self.shopTitle];
    [self.shopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
    }];
    UIView * line = [[UIView alloc]init];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];
    line.backgroundColor = kLineColor;
    self.lineView = line;
    self.shopTitle.font = kFont(14);
    self.shopTitle.text = @"商铺名称";
    self.shopTitle.textColor = [UIColor colorWithHexString:@"666666"];
    if (type == MRShopCellTypeText) {
        self.shopSubTitle = [[UILabel alloc]init];
        [self addSubview:self.shopSubTitle];
        [self.shopSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(self);
        }];
        self.shopSubTitle.textColor = [UIColor colorWithHexString:@"666666"];
        self.shopSubTitle.font = kFont(14);
        
    }else if(type == MRShopCellTypeImage){
        self.arrowImage = [[UIImageView alloc]init];
        [self addSubview:self.arrowImage];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(self);
            make.size.mas_offset(CGSizeMake(6, 10));
        }];
        self.arrowImage.image = kImageNamed(@"mr_order_arrow_push");
        
        self.shopImage = [[UIImageView alloc] init];
        [self addSubview:self.shopImage];
        [self.shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImage).offset(-12);
            make.centerY.equalTo(self);
            make.size.mas_offset(CGSizeMake(17.5, 17.5));
        }];
        self.shopImage.image = [UIImage imageNamed:@"mr_order_arrow_push"];
    }else{
        self.arrowImage = [[UIImageView alloc]init];
        [self addSubview:self.arrowImage];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(self);
            make.size.mas_offset(CGSizeMake(6, 10));
        }];
        self.arrowImage.image = kImageNamed(@"mr_order_arrow_push");
        
        self.shopSubTitle = [[UILabel alloc]init];
        [self addSubview:self.shopSubTitle];
        [self.shopSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImage).offset(-20);
            make.centerY.equalTo(self);
        }];
        self.shopSubTitle.textColor = [UIColor colorWithHexString:@"666666"];;
        self.shopSubTitle.font = kFont(14);
    }
}
@end
