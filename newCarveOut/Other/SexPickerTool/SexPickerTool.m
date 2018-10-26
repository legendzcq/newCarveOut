//
//  SexPickerTool.m
//  PickerView
//
//  Created by  zengchunjun on 2017/4/20.
//  Copyright © 2017年  zengchunjun. All rights reserved.
//

#import "SexPickerTool.h"

@interface SexPickerTool ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (weak, nonatomic)UIPickerView *pickerView;

@property (nonatomic,copy)NSString *sexPick;


@end

@implementation SexPickerTool

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithObjects:@"男",@"女", nil];
    }
    return _dataSource;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"SexPickerTool" owner:nil options:nil]firstObject];
        [self setupUI];
    }

    return self;
}

- (void)setupUI {
    
    UIView * topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    topBackView.backgroundColor = [UIColor colorWithHexString:@"f2f5f6"];
    [self addSubview:topBackView];
    
    UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.titleLabel.font = kFont(15);
    [finishBtn setTitleColor:[UIColor colorWithHexString:@"f18c09"] forState:UIControlStateNormal];
    [topBackView addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topBackView.mas_right).offset(-12);
        make.centerY.equalTo(topBackView.mas_centerY);
    }];
//    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        self.callBlock(self.sexPick);
//    }];
    [[finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.callBlock(self.sexPick);
    }];
    
    UIView * line = [[UIView alloc]init];
    [topBackView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBackView);
        make.right.equalTo(topBackView);
        make.bottom.equalTo(topBackView);
        make.height.mas_equalTo(@0.5);
    }];
        line.backgroundColor = kLineColor;
    // 选择框
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kWidth, 195)];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
     pickerView.backgroundColor = [UIColor colorWithHexString:@"f4f5f6"];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self addSubview:pickerView];
    self.pickerView = pickerView;
    self.pickerView.showsSelectionIndicator = YES;
    
    self.sexPick = self.dataSource[0];
}

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    
//
//}

//- (IBAction)pickDone:(UIButton *)sender {
//    self.callBlock(self.sexPick);
//}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.sexPick = self.dataSource[row];
}

@end
