//
//  MRUserSystemInformationCell.m
//  MRClient
//
//  Created by yangshuai on 2018/7/13.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserSystemInformationCell.h"
#import "MRUserInformationModel.h"
@interface MRUserSystemInformationCell()

@end
@implementation MRUserSystemInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withStyle:(NSInteger)cellStyle{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = 0;
    self.backgroundColor = kWhiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createUIWithStyle:cellStyle];
    return self;
}
- (void)createUIWithStyle:(NSInteger)cellStyle{
    if (cellStyle==1) {
        UILabel * detailLabel = [[UILabel alloc] init];
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self).offset(-21);
        }];
        detailLabel.font = kFont(11);
        detailLabel.textColor = kUnSelected;
        detailLabel.text = @"查看详情";
        
        UIImageView * arrowImage = [[UIImageView alloc]init];
        [self addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(detailLabel);
            make.size.mas_offset(CGSizeMake(6, 11));
        }];
        arrowImage.image = kImageNamed(@"mr_user_arrow");
        
        UIView * line = [[UIView alloc]init];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(detailLabel.mas_top).offset(-16);
            make.size.mas_offset(CGSizeMake(kWidth-24, 0.5));
        }];
        line.backgroundColor = kLineColor;
        
        self.subTitleLabel = [[UILabel alloc]init];
        [self addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(line).offset(-24);
            make.right.equalTo(self).offset(-12);
        }];
        self.subTitleLabel.font = kFont(11);
        self.subTitleLabel.textColor = kUnSelected;
        self.subTitleLabel.numberOfLines = 0;
        self.subTitleLabel.text = @"self.subTitleLabel = [[UILabel alloc]init];self.subTitleLabel = [[UILabel alloc]init];self.subTitleLabel = [[UILabel alloc]init];self.subTitleLabel = [[UILabel alloc]init];";
        
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self.subTitleLabel.mas_top).offset(-10);
            make.right.equalTo(self).offset(-12);
        }];
        self.titleLabel.text = @"哈哈哈哈哈";
        self.titleLabel.font = kFont(13);
        
        UIView * timeView = [[UIView alloc]init];
        timeView.backgroundColor = kTabBGColor;
        [self addSubview:timeView];
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.titleLabel.mas_top);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kWidth, 48));
        }];

        self.timeLabel = [[UILabel alloc] init];
        [timeView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        self.timeLabel.font = kFont(11);
        self.timeLabel.text = @"12:12:12";
        self.timeLabel.textColor = kSubtitleColor;
        

    }else{
        UIView * timeView = [[UIView alloc]init];
        timeView.backgroundColor = kTabBGColor;
        [self addSubview:timeView];
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kWidth, 48));
        }];
        
        self.timeLabel = [[UILabel alloc] init];
        [timeView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(timeView);
        }];
        self.timeLabel.font = kFont(11);
        self.timeLabel.text = @"12:12:12";
        self.timeLabel.textColor = kSubtitleColor;
        
        
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.top.equalTo(timeView.mas_bottom).offset(24);
            make.right.equalTo(self).offset(-12);
            make.height.mas_equalTo(@14);

        }];
        self.titleLabel.text = @"哈哈哈哈哈";
        self.titleLabel.font = kFont(13);
        
        self.subTitleLabel = [[UILabel alloc]init];
        [self addSubview:self.subTitleLabel];
        self.subTitleLabel.numberOfLines = 0;
        self.subTitleLabel.text = @"self.subTitleLabel = [[UILabel alloc]init];self.subTitleLabel = [[UILabel alloc]init];self.subTitleLabel = [[UILabel alloc]init];self.subTitleLabel = [[UILabel alloc]init];";
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self).offset(-21);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.right.equalTo(self).offset(-12);
        }];
        self.subTitleLabel.font = kFont(11);
        self.subTitleLabel.textColor = kUnSelected;
    }
}




-(void)setInfoModel:(MRUserInformationModel *)infoModel
{
    _infoModel = infoModel;
    self.titleLabel.text = infoModel.title;
    self.subTitleLabel.text = infoModel.informationContent;
}





@end
