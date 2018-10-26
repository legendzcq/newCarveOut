//
//  AppDelegate.m
//  TLCityPicker
//
//  Created by yuchen on 15/12/15.
//  Copyright © 2015年 yuchen. All rights reserved.
//


#import "TLCityHeaderView.h"

@interface TLCityHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLCityHeaderView
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
         self.backgroundColor = kMainColor;
        [self addSubview:self.titleLabel];

    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(12, 0, self.frame.size.width - 10, self.frame.size.height)];
}

#pragma mark - Setter
- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        
    }
    return _titleLabel;
}

+ (CGFloat)cellHeight {
    return 30.0f;
}
@end
