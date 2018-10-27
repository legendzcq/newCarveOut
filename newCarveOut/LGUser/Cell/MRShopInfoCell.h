//
//  JLMShopInfoCell.h
//  JLMStore
//
//  Created by yangshuai on 2017/9/18.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MRShopCellType){
    MRShopCellTypeText  =1,
    MRShopCellTypeImage =2,
    MRShopCellTypeArrow =3,

};
@interface MRShopInfoCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(MRShopCellType)type;
@property (nonatomic,strong) UILabel    * shopTitle;
@property (nonatomic,strong) UILabel    * shopSubTitle;
@property (nonatomic,strong) UIImageView * shopImage;
@property (nonatomic,strong) UIImageView * arrowImage;
@property (nonatomic,strong) UIView * lineView;
@end
