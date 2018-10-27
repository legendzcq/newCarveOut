//
//  JLMModuleViewController.h
//  JLMClient
//
//  Created by yangshuai on 2017/10/26.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "JLMBaseViewController.h"
//#import "JLMPublicFoodsCell.h"
//#import "JLMPublicHotelCell.h"
#import <SDCycleScrollView.h>
@interface JLMModuleViewController : JLMBaseViewController

@property (nonatomic,strong) UIButton * searchBtn;//导航搜索按钮


@property (nonatomic,strong) NSMutableArray * listArray;//列表数组


@property (nonatomic,strong) NSMutableArray * bannerArray;//轮播图片model

@end
