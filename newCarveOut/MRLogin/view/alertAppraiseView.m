//
//  alertAppraiseView.m
//  newCarveOut
//
//  Created by 张传奇 on 2018/10/27.
//  Copyright © 2018 张传奇. All rights reserved.
//

#import "alertAppraiseView.h"
#import "CDZStarsControl.h"
#define AlertW 335
@interface alertAppraiseView()<CDZStarsControlDelegate>
@property (nonatomic, strong) CDZStarsControl *starsControl;
@property (strong, nonatomic) UIButton *sureBtn;
@property (nonatomic,assign)CGFloat score;
@property (nonatomic,strong) UIView * alertView;
@property (nonatomic,strong)UILabel * skillLab;
@end

@implementation alertAppraiseView

- (instancetype)initWithSkill:(NSString *)skill {
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
         [self addSubview:self.alertView];
        self.alertView.frame = CGRectMake(0, 0, AlertW, 200);
        self.alertView.layer.position = self.center;
        
        self.skillLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, AlertW-24, 12)];
        self.skillLab.numberOfLines = 0;
        self.skillLab.textColor = [UIColor colorWithHexString:@"a4a4a4"];
        self.skillLab.text = [NSString stringWithFormat:@"您选择的技能：%@",skill];
        self.skillLab.font = [UIFont systemFontOfSize:11];
        [self.alertView addSubview:self.skillLab];
//        [self addSubview:self.starsControl];
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.sureBtn.frame = CGRectMake(0, self.alertView.height-40, AlertW, 40);
        [self.sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sureBtn setBackgroundColor:[UIColor blueColor]];
        [self.sureBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.sureBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        self.sureBtn.layer.mask = maskLayer;
        [self.alertView addSubview:self.sureBtn];
        
         [self.alertView addSubview:self.starsControl];
    }
     return self;
}

- (CDZStarsControl *)starsControl{
    if (!_starsControl) {
        _starsControl = [[CDZStarsControl alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.skillLab.frame)+10, AlertW-60 , 100) stars:5 starSize:CGSizeMake(40, 40) noramlStarImage:[UIImage imageNamed:@"star_normal"] highlightedStarImage:[UIImage imageNamed:@"star_highlighted"]];
        _starsControl.delegate = self;
        _starsControl.allowFraction = YES;
      self.score= _starsControl.score = 2.6f;
    }
    return _starsControl;
}
- (void)starsControl:(CDZStarsControl *)starsControl didChangeScore:(CGFloat)score{
    self.score =score;
}
#pragma mark - 弹出 -
- (void)showXLAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.layer.position = self.center;
    self.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}
-(void)btnClick {
    if (self.resultIndex) {
        self.resultIndex(self.score);
    }
       [self removeFromSuperview];
}
@end
