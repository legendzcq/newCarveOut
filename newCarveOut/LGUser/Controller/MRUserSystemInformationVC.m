//
//  MRUserSystemInformationVC.m
//  MRClient
//
//  Created by yangshuai on 2018/7/13.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserSystemInformationVC.h"
#import "MRUserSystemInformationCell.h"
#import "MRUserInformationModel.h"

@interface MRUserSystemInformationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度
@property (nonatomic,strong) NSMutableArray * listArray;
@property (nonatomic,assign) NSInteger  pageCount;
@property (nonatomic,assign) NSInteger lastPage;//是否最后一页 1真 0假
@end

@implementation MRUserSystemInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"系统消息";
    [self requestData];
}
- (void)createTableView{
    if (self.listArray.count == 0) {
        [self showStatus:@"暂无数据,点击重试" imageName:@"mr_public_nodata" type:nil tapViewWithBlock:^{
            [self requestData];
        }];
    }else{
        [self hide];
        if (self.tableView == nil) {
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kWidth, kHeight-kNaviBarHeight) style:(UITableViewStylePlain)];
            self.tableView.backgroundColor = kTabBGColor;
            self.tableView.showsVerticalScrollIndicator  = NO;
            self.tableView.separatorStyle = NO;
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.rowHeight = UITableViewAutomaticDimension;
            self.tableView.estimatedRowHeight = 100;
            [self.view addSubview:self.tableView];
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self requestData];
            }];
        }else{
            [self.tableView reloadData];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRUserSystemInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MRUserSystemInformationCell"];
    if (cell == nil) {
        cell = [[MRUserSystemInformationCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MRUserSystemInformationCell" withStyle:2];
//        if (indexPath.row %2 ==0) {
//        }else{
//            cell = [[MRUserSystemInformationCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MRUserSystemInformationCell" withStyle:2];
//        }
    }
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height)
    {
        return height.floatValue;
    }
    else
    {
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = @(cell.frame.size.height);
    NSLog(@"%@",height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}

#pragma mark - Getters
- (NSMutableDictionary *)heightAtIndexPath
{
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [NSMutableDictionary dictionary];
    }
    return _heightAtIndexPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (NSMutableArray *)listArray{
    if (_listArray==nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
-(void)requestData{
//    [YSNetWorkManager requestWithType:HttpRequestTypeGet withUrlString:kInformationNotice withParaments:nil withSuccessBlock:^(MRRequsetInfoModel *model) {
//        [self.listArray removeAllObjects];
//        for (NSDictionary * dict in model.data) {
//            [self.listArray addObject: [MRUserInformationModel modelWithDictionary:dict]];
//        }
//        [self createTableView];
//        [MRProgressHUD hide];
//    } withFailureBlock:^(NSError *error) {
//        [MRProgressHUD hide];
//        [self createTableView];
//    }];
}
@end
