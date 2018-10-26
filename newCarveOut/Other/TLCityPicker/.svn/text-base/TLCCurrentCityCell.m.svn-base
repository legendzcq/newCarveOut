//
//  TLCCurrentCityCell.m
//  JLMClient
//
//  Created by 张传奇 on 2017/10/26.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "TLCCurrentCityCell.h"
@interface TLCCurrentCityCell()

@end
@implementation TLCCurrentCityCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.currentCityLabel];
    self.backgroundColor = [UIColor whiteColor];
    self.textLabel.text = @"当前：";
    self.textLabel.font = kFont(14);
    self.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self addSubview:self.currentCityLabel];
}

- (UILabel *)currentCityLabel
{
    if (_currentCityLabel == nil) {
        _currentCityLabel = [[UILabel alloc] init];
        [_currentCityLabel setText:kSelectCity];
        [_currentCityLabel setTextColor:[UIColor grayColor]];
        [_currentCityLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_currentCityLabel setTextColor:[UIColor colorWithHexString:@"f18c09"]];
    }
    return _currentCityLabel;
    
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.currentCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];

}
+ (NSInteger)cellHeight
{
    
    return 45;
}
@end
