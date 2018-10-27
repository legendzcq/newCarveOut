//
//  MRUserSettingVC.m
//  MRClient
//
//  Created by 张传奇 on 2018/7/25.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "MRUserSettingVC.h"
#import "MRShopInfoCell.h"
#import "MRShopHeaderCell.h"
#import "JLMImagePicker.h"
#import "MRUserAccountSetingVC.h"
#import "MRChangePwdMainVC.h"
#import "MRUserSafeMainVC.h"
#import "MRUserModel.h"
#import "MRUserMyIdentityVC.h"
#import "MRUserLoginVC.h"
#import "MRBaseTabBarController.h"
@interface MRUserSettingVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,JLMImagePickerDelegate>
@property(nonatomic,strong)UILabel * CacheLab;
@property(nonatomic,strong)MRUserModel * model;
@property(nonatomic,strong)MRShopHeaderCell * headerCell;
@end

@implementation MRUserSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"个人设置";
    [self requestData];
    [self initBottomBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kPersonInfoNotification object:nil];
}
#pragma mark ---- request
- (void)requestData{
//    [MRUserModel requestUserDataSuccessBlock:^(MRUserModel *model) {
    
//        self.model = model;
        [self initTableView];
//    }];
}
#pragma mark ---- init
- (void)initTableView{
    if (self.tableView ==nil) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNaviBarHeight, kWidth, kHeight-kNaviBarHeight-kBottomHeight) style:(UITableViewStylePlain)];
        [self.view addSubview:self.tableView];
        self.tableView.showsVerticalScrollIndicator  = NO;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[MRShopHeaderCell class] forCellReuseIdentifier:@"MRShopHeaderCell"];
        [self.tableView registerClass:[MRShopInfoCell class] forCellReuseIdentifier:@"MRShopInfoCell"];
    }else{
        [self.tableView reloadData];
    }
}
#pragma mark --- delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return [MRShopHeaderCell cellHeight];
    }
    return 51;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRShopInfoCell * cell = [[MRShopInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MRShopInfoCell" cellType:(MRShopCellTypeArrow)];
    if(indexPath.row ==0){
        self.headerCell = [tableView dequeueReusableCellWithIdentifier:@"MRShopHeaderCell"];
        [self.headerCell.shopImage setImageWithURL:kURL(self.model.headPortrait) placeholder:kUserIconPlaceholder];
        return self.headerCell;
    }else if(indexPath.row ==1){
        cell.shopTitle.text = @"证件信息";
        cell.lineView.hidden = NO;
    }else if(indexPath.row ==2){
        cell.shopTitle.text = @"账号信息管理";
        cell.lineView.hidden = NO;
    }
    else if(indexPath.row ==3){
        cell.shopTitle.text = @"安全设置";
        cell.lineView.hidden = NO;
    }else if(indexPath.row ==4){
        cell.shopTitle.text = @"关于我们";
        cell.lineView.hidden = NO;
    }
    else if(indexPath.row ==5){
        cell.shopTitle.text = @"清除缓存";
        cell.shopSubTitle.text = [NSString stringWithFormat:@"%.1fM",[YSNetWorkManager totalCacheSize]];
        self.CacheLab = cell.shopSubTitle ;
        cell.lineView.hidden = NO;
    }
    else if(indexPath.row ==6){
        cell.shopTitle.text = @"当前版本号";
        cell.shopSubTitle.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.lineView.hidden = NO;
        cell.arrowImage.hidden = YES;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self chooseIconImage];
    }
    else if (indexPath.row == 1) {
        if (self.model.authStatus) {
            MRUserMyIdentityVC * vc = [MRUserMyIdentityVC new];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
//            MRUserCheckIdentityVC * vc = [MRUserCheckIdentityVC new];
//            vc.businessDidFinsh = ^(id parameter) {
//                [self requestData];
//            };
//            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.row == 2) {
        MRUserAccountSetingVC * vc = [MRUserAccountSetingVC new];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3) {
        MRUserSafeMainVC * vc = [MRUserSafeMainVC new];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==4){
        if ([self.model.aboutUsUrl isKindOfClass:[NSNull class]]) {
            [MRProgressHUD showMessage:@"aboutUsUrl为空" inView:self.view];
            return;
        }
        MRRootWebView * webView = [[MRRootWebView alloc]init];
        webView.urlString = @"https://www.baidu.com";
//        self.model.aboutUsUrl;
        [self.navigationController pushViewController:webView animated:YES];
    }else if (indexPath.row == 5) {
        [YSNetWorkManager clearCaches];
        self.CacheLab.text =@"0.0M";
        [MRProgressHUD showMessage:@"缓存清除成功" inView:self.view];
    }
}
#pragma mark-拍照或获取图片更换
- (void)chooseIconImage {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            JLMImagePicker *imagePicker = [JLMImagePicker sharedInstance];
            imagePicker.delegate = self;
            [imagePicker showImagePickerWithType:0 InViewController:self Scale:1];
        }else {
            [MRProgressHUD showMessage:@"请到设置中打开照相机功能" inView:self.view afterDelayTime:2];
        }
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        JLMImagePicker *imagePicker = [JLMImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showImagePickerWithType:1 InViewController:self Scale:1];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController: alertController animated: YES completion: nil];
    });
}
#pragma mark ---- JLMImagePickerDelegate
- (void)imagePicker:(JLMImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    [self uploadShopImage:editedImage];
}
- (void)imagePickerDidCancel:(JLMImagePicker *)imagePicker{
    
}
//上传用户头像
- (void)uploadShopImage:(UIImage*)image{
    NSDictionary * dic = @{@"file":@"image.jpg"};
    [MRProgressHUD show:@"正在上传头像中..." inView:[[MRBaseViewController new] getCurrentVC].view];
//    [YSNetWorkManager uploadImageWithOperations:dic withImageArray:@[image] withtargetWidth:300 withUrlString:kUserUpLoadPic withFileName:nil withSuccessBlock:^(MRRequsetInfoModel *model) {
//        NSLog(@"%@",model.data);
//        [self.headerCell.shopImage setImageWithURL:kURL(model.data[@"headPortrait"]) placeholder:kUserIconPlaceholder];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kPersonInfoNotification object:nil];
//        [MRProgressHUD hide];
//    } withFailurBlock:^(NSError *error) {
//        [MRProgressHUD showMessage:kLoadingFailedText inView:[[MRBaseViewController new] getCurrentVC].view];
//        
//    } withUpLoadProgress:^(float progress) {
//        
//    }];
}

-(void)initBottomBtn {
    UIButton * bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [bottomBtn.titleLabel setFont:kFont(14)];
    bottomBtn.backgroundColor = kMainBtnColor;
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
    [bottomBtn addTapGestureBlock:^(UIView *view) {
        [MRProgressHUD show:@"正在退出中..." inView:[[MRBaseViewController new] getCurrentVC].view];
//        [YSNetWorkManager requestWithType:(HttpRequestTypePost) withUrlString:kLogoff withParaments:nil withSuccessBlock:^(MRRequsetInfoModel *model) {
//            [self loginOutClearTheInformation];
//        } withFailureBlock:^(NSError *error) {
//            [self loginOutClearTheInformation];
//        } progress:^(float progress) {
//
//        }];
    }];
}
//退出登录 清除数据并且返回登录页
- (void)loginOutClearTheInformation{
    [MRProgressHUD hide];
    [MRUserLoginModel removeAccount];
    [YSNetWorkManager deallocShareManager];
    [self.navigationController popViewControllerAnimated:YES];
    [[MRBaseTabBarController shardManager] setTabBarItem];
}
@end
