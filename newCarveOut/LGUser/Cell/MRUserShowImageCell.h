//
//  MRUserShowImageCell.h
//  MRClient
//
//  Created by 张传奇 on 2018/7/3.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRUserShowImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bannerImg;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property(nonatomic,assign) BOOL isShowLine;

+ (CGFloat)cellHeight;
@end
