//
//  JLMShopHeaderCell.h
//  JLMStore
//
//  Created by yangshuai on 2017/9/18.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRShopHeaderCell : UITableViewCell
@property (nonatomic,strong) UIImageView * shopImage;
@property (nonatomic,strong) UILabel * shopTitle;
+ (CGFloat)cellHeight;
@end
