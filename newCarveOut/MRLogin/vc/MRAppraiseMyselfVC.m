//
//  MRAppraiseMyselfVC.m
//  newCarveOut
//
//  Created by 张传奇 on 2018/10/27.
//  Copyright © 2018 张传奇. All rights reserved.
//

#import "MRAppraiseMyselfVC.h"
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>
#import "appraiseModel.h"
#import "MRAppraiseMyselfCell.h"
#import "alertAppraiseView.h"
@interface MRAppraiseMyselfVC () <TTGTextTagCollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *textTagCollectionView1;
@property (strong, nonatomic) NSArray *tags;
@property (nonatomic,strong) NSMutableArray * listArray;
@property (weak, nonatomic) IBOutlet UILabel *selectTagLab;
@property (weak, nonatomic) IBOutlet UIView *backVIew;

@end

@implementation MRAppraiseMyselfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setupUI];
}

-(void)setupUI {
    self.titleLabel.text = @"自我评价";
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"跳过" forState:(UIControlStateNormal)];
    [[self.rightButton rac_signalForControlEvents:(UIControlEventTouchUpInside)]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         
         UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"如果不进行自我评价，将无法填满血槽释放大招，请问您是否继续" preferredStyle:(UIAlertControllerStyleAlert)];
         UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"跳过" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
             
         }];
         UIAlertAction *alertB = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
             
         }];
         
         [alertC addAction:alertA];
         [alertC addAction:alertB];
         [self presentViewController:alertC animated:YES completion:nil];
         
     }];
    
    // Remember to set this to NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tags = @[
              @"Java",@"C", @"Python", @"C++", @"VisualBasic.Net", @"C#", @"PHP",
              @"JavaScript", @"SQL", @"Object-C", @"Ruby", @"Delph/Object Pascal", @"MATLAB", @"Assembly Language", @"swift", @"Go",
              @"Perl", @"R", @"PL/SQL", @"Visual Base"];
    
     _textTagCollectionView1.delegate = self;
        _textTagCollectionView1.showsVerticalScrollIndicator = NO;
    _textTagCollectionView1.selectionLimit = 5;
    // Style1
    TTGTextTagConfig *config = _textTagCollectionView1.defaultConfig;
    
    config.tagTextFont = [UIFont boldSystemFontOfSize:18.0f];
    
    config.tagTextColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    config.tagSelectedTextColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    
    config.tagBackgroundColor = [UIColor colorWithRed:0.98 green:0.91 blue:0.43 alpha:1.00];
    config.tagSelectedBackgroundColor = [UIColor colorWithRed:0.97 green:0.64 blue:0.27 alpha:1.00];
    
    _textTagCollectionView1.horizontalSpacing = 6.0;
    _textTagCollectionView1.verticalSpacing = 8.0;
    
    config.tagBorderColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    config.tagSelectedBorderColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    config.tagBorderWidth = 1;
    config.tagSelectedBorderWidth = 1;
    
//    config.tagShadowColor = [UIColor blackColor];
//    config.tagShadowOffset = CGSizeMake(0, 0.3);
//    config.tagShadowOpacity = 0.3f;
//    config.tagShadowRadius = 0.5f;
//
//    config.tagCornerRadius = 7;
    
    // Set tags
    [_textTagCollectionView1 addTags:_tags];
    
    // Change alignment
    _textTagCollectionView1.alignment = TTGTagCollectionAlignmentFillByExpandingWidthExceptLastLine;
    
    // Load data
    [_textTagCollectionView1 reload];
    
    
    
    if (ios11) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(self.selectTagLab.frame)+52, kWidth-24, kHeight-CGRectGetMaxY(self.selectTagLab.frame)-20) style:(UITableViewStylePlain)];
    [self.backVIew addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MRAppraiseMyselfCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MRAppraiseMyselfCell"];
    
    
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(12, CGRectGetMaxY(self.selectTagLab.frame)+12, kWidth-24,300);
}
#pragma mark - TTGTextTagCollectionViewDelegate

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected tagConfig:(TTGTextTagConfig *)config {
//    _logLabel.text = [NSString stringWithFormat:@"Tap tag: %@, at: %ld, selected: %d", tagText, (long) index, selected];
    NSLog(@"Tap tag: %@, at: %ld, selected: %d", tagText, (long) index, selected);
    if (selected) {
        

        alertAppraiseView *xlAlertView = [[alertAppraiseView alloc] initWithSkill:tagText];
        xlAlertView.resultIndex = ^(CGFloat index){
            appraiseModel * model = [appraiseModel new];
            model.skill = tagText;
            model.rank = [NSString stringWithFormat:@"%.1f",index];
            [self.listArray addObject:model];
            [self.tableView reloadData];
        };
        [xlAlertView showXLAlertView];
    }else
    {
        NSMutableArray * tempArray =[NSMutableArray array];
        for (appraiseModel * obj in self.listArray) {
            if (![obj.skill isEqualToString:tagText]) {
                [tempArray addObject:obj];
            }
        }
        
        self.listArray = tempArray;
        [self.tableView reloadData];
    }
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView updateContentSize:(CGSize)contentSize {
    NSLog(@"text tag collection: %@ new content size: %@", textTagCollectionView, NSStringFromCGSize(contentSize));
}


- (NSMutableArray *)listArray{
    if (_listArray ==nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRAppraiseMyselfCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MRAppraiseMyselfCell"];
//    cell.textLabel.text = self.listArray[indexPath.row];
    cell.model = self.listArray[indexPath.row];
    return cell;
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
        return YES;

}
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}



// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.listArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
    
}

@end
