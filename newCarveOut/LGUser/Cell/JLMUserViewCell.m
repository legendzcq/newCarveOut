//
//  JLMUserViewCell.m
//  JLMClient
//
//  Created by 张传奇 on 2017/11/6.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMUserViewCell.h"

@implementation JLMUserViewCell

+ (instancetype)userTableViewCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"JLMUserViewCell";
    JLMUserViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[JLMUserViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
    }
    return cell;
}

+ (CGFloat)cellHeight {
    return 52;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.frame = CGRectMake(12, 16, 25, 23.5);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+8, 20, 150, 18);
    self.textLabel.font = [UIFont boldSystemFontOfSize:16];
    self.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
}

@end
