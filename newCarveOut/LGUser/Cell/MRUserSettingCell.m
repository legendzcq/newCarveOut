//
//  MRUserSettingCell.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/3.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserSettingCell.h"

@implementation MRUserSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    NSArray * titleArray = @[@"我的合同",@"智能门锁",@"待缴账单",@"我的管家",@"在线报修",@"预约保洁",@"入住指南"];
    NSArray* imageArray = @[@"mr_user_mycompact",@"mr_user_mylock",
                        @"mr_user_myorder",@"mr_user_mybutler",@"mr_user_myservice",
                            @"mr_user_mydusting",@"mr_user_myguide"];
    NSMutableArray * viewArray = [NSMutableArray array];
    for (int i=0; i<titleArray.count; i++) {
        if (i<4) {
            UIView * view = [self getBtnViewTitle:titleArray[i] imageName:imageArray[i] tag:i frame:CGRectMake(kWidth/4*i,0, kWidth/4, 75)];
            [self addSubview:view];
            [viewArray addObject:view];
        }else
        {
            UIView * view = [self getBtnViewTitle:titleArray[i] imageName:imageArray[i] tag:i frame:CGRectMake(kWidth/4*(i-4),75, kWidth/4, 75)];
            [self addSubview:view];
            [viewArray addObject:view];
        }
    }
}


+ (CGFloat)cellHeight {
    return 166;
}

-(UIView *)getBtnViewTitle:(NSString *)title imageName:(NSString *)imageName tag:(int)tag frame:(CGRect)frame{
    UIView * backView = [[UIView alloc]initWithFrame:frame];
    backView.backgroundColor = [UIColor whiteColor];
    backView.tag = tag;
    
    UIImageView * logoImg = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth/4-20)*0.5, 24, 20, 20)];
    logoImg.image = kImageNamed(imageName);
    [backView addSubview:logoImg];
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImg.frame)+12, kWidth/4, 15)];
    titleLab.font = kFont(12);
    titleLab.textColor = [UIColor colorWithHexString:@"333333"];
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLab];

    
    [backView addTapGestureBlock:^(UIView *view) {

        if (self.btnClickBlock) {
            self.btnClickBlock(tag);
        }
    }];
    
    return backView;
}
@end
