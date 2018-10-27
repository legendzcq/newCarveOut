//
//  AppDelegate.m
//  TLCityPicker
//
//  Created by yuchen on 15/12/15.
//  Copyright © 2015年 yuchen. All rights reserved.
//

#import "TLCityPickerController.h"
#import "TLCityPickerSearchResultController.h"
#import "TLCityHeaderView.h"
#import "TLCityGroupCell.h"
#import "TLCCurrentCityCell.h"
@interface TLCityPickerController () <TLCityGroupCellDelegate, TLSearchResultControllerDelegate,UISearchControllerDelegate,UISearchControllerDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) TLCityPickerSearchResultController *searchResultVC;

@property (nonatomic, strong) NSMutableArray *cityData;
@property (nonatomic, strong) NSMutableArray *localCityData;
@property (nonatomic, strong) NSMutableArray *hotCityData;
@property (nonatomic, strong) NSMutableArray *commonCityData;
@property (nonatomic, strong) NSMutableArray *arraySection;

@end

@implementation TLCityPickerController
@synthesize data = _data;
@synthesize commonCitys = _commonCitys;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"当前城市-%@",kSelectCity]];
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc]initWithImage:kImageNamed(@"return") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonDown:)];
    [cancelBarButton setTintColor:[UIColor colorWithHexString:@"595959"]];
    [self.navigationItem setLeftBarButtonItem:cancelBarButton];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self.tableView setSectionIndexColor:[UIColor colorWithHexString:@"a3a6a6"]];
    self.tableView.separatorInset=UIEdgeInsetsMake(0,0, 0, 0);           //top left bottom right 左右边距相同
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[TLCCurrentCityCell class] forCellReuseIdentifier:@"TLCCurrentCityCell"];
    [self.tableView registerClass:[TLCityGroupCell class] forCellReuseIdentifier:@"TLCityGroupCell"];
    [self.tableView registerClass:[TLCityHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLCityHeaderView"];
    self.tableView.tableFooterView = [UIView new];
    [self loadData];
}
-(void)loadData {
//    [YSNetWorkManager requestWithType:(HttpRequestTypeGet) withUrlString:kCity withParaments:nil withSuccessBlock:^(JLMRequsetInfoModel *object) {
//        //            if ([object[@"code"] integerValue]==0) {
//        if ([object.state integerValue]==0) {
//             NSArray *  arr = object.data[@"cityList"];
//            //解析普通城市
//            [self analyseNormalCity:arr];
//            arr = object.data[@"hotCityList"];
//            [self analyseHotCity:arr];
//            //
//        }else{
//            [JLMProgressHUD showMessage:object.msg inView:self.view];
//        }
//    } withFailureBlock:^(NSError *error) {
//        [JLMProgressHUD showMessage:@"获取当前城市失败" inView:self.view];
//    } progress:^(float progress) {
//    }];
}

- (void)analyseHotCity:(NSArray *)array
{
    self.hotCitys = [NSArray array];
    NSMutableArray * hotcityarray = [NSMutableArray array];
    
    for (NSDictionary *groupDic in array) {
        NSNumber * cityID =[groupDic objectForKey:@"id"];
        [hotcityarray addObject:cityID.stringValue];
    }
    self.hotCitys = hotcityarray;
    [_hotCityData removeAllObjects];
//
    for (NSString *str in self.hotCitys) {
        TLCity *city = nil;
        for (TLCity *item in self.cityData) {
            if ([item.cityID isEqualToString:str]) {
                city = item;
                break;
            }
        }
        if (city == nil) {
            NSLog(@"Not Found City: %@", str);
        }
        else {
            [_hotCityData addObject:city];
        }
    }
    
    [self.tableView reloadData];
}


- (void)analyseNormalCity:(NSArray *)array{
    _data = [[NSMutableArray alloc] init];
    for (NSDictionary *groupDic in array) {
        NSString * groupName =[[ groupDic[@"cityPinyin"] substringToIndex:1] uppercaseString];
        TLCityGroup *group = [[TLCityGroup alloc] init];
        
        if (![self.arraySection containsObject:groupName]) {
            [self.arraySection addObject:groupName];
            group.groupName = groupName;
            [_data addObject:group];
        }else
        {
            for (TLCityGroup *objGroup in _data) {
                if ([objGroup.groupName isEqualToString:groupName]) {
                    group = objGroup;
                    break;
                }
            }
        }
        TLCity *city = [[TLCity alloc] init];
        NSNumber * aid = [groupDic objectForKey:@"id"];
        city.cityID = aid.stringValue;
        city.cityName = [groupDic objectForKey:@"cityName"];
        city.shortName = [groupDic objectForKey:@"cityPinyin"];
        city.pinyin = [groupDic objectForKey:@"cityPinyin"];
        groupName =[ groupDic[@"cityPinyin"] substringToIndex:1];
        city.initials = [groupName uppercaseString];        
        [group.arrayCitys addObject:city];
        [self.cityData addObject:city];
    }
    
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        return 1;
    }
    TLCityGroup *group = [self.data objectAtIndex:section - 2];
    return group.arrayCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.section < 2) {

        if (indexPath.section == 0) {
            TLCCurrentCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLCCurrentCityCell"];
            cell.currentCityLabel.text =_GPSCityName;
            return cell;
            
        }
        else if (indexPath.section == 1) {
            TLCityGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLCityGroupCell"];
            [cell setTitle:@"热门城市"];
            [cell setCityArray:self.hotCityData];
            [cell setDelegate:self];
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 2];
    TLCity *city =  [group.arrayCitys objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];

    return cell;
}

#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 2) {
        return nil;
    }
    TLCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLCityHeaderView"];
    NSString *title = [_arraySection objectAtIndex:section+1];
    [headerView setTitle:title];
    headerView.backgroundColor = kMainColor;
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [TLCCurrentCityCell cellHeight];
    }
    else if (indexPath.section == 1) {
        return [TLCityGroupCell getCellHeightOfCityArray:self.hotCityData];
    }

    return 45.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 2) {
        return 0.0f;
    }
    return [TLCityHeaderView cellHeight];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < 2) {
        return;
    }
    TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 2];
    TLCity *city = [group.arrayCitys objectAtIndex:indexPath.row];
    [self didSelctedCity:city];
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.arraySection;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [self.tableView scrollRectToVisible:self.searchController.searchBar.frame animated:NO];
        return -1;
    }
    return index - 1;
}

#pragma mark TLCityGroupCellDelegate
- (void) cityGroupCellDidSelectCity:(TLCity *)city{
    [self didSelctedCity:city];
}

#pragma mark TLSearchResultControllerDelegate
#warning ------
- (void) searchResultControllerDidSelectCity:(TLCity *)city{
    self.searchController.active = NO;
    [self didSelctedCity:city];
}

#pragma mark - Event Response
- (void) cancelButtonDown:(UIBarButtonItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerControllerDidCancel:)]) {
        [_delegate cityPickerControllerDidCancel:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Methods
- (void) didSelctedCity:(TLCity *)city
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerController:didSelectCity:)]) {
        [_delegate cityPickerController:self didSelectCity:city];
    }
    
    if (self.commonCitys.count >= MAX_COMMON_CITY_NUMBER) {
        [self.commonCitys removeLastObject];
    }
    for (NSString *str in self.commonCitys) {
        if ([city.cityID isEqualToString:str]) {
            [self.commonCitys removeObject:str];
            break;
        }
    }
    [self.commonCitys insertObject:city.cityID atIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:self.commonCitys forKey:COMMON_CITY_DATA_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setter
- (void) setCommonCitys:(NSMutableArray *)commonCitys
{
    _commonCitys = commonCitys;
    if (commonCitys != nil && commonCitys.count > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:commonCitys forKey:COMMON_CITY_DATA_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - Getter 
- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultVC];
        [_searchController.searchBar setPlaceholder:@"城市/行政区/拼音"];
        [_searchController.searchBar setBarTintColor:kMainColor];
        [_searchController.searchBar sizeToFit];
        [_searchController setSearchResultsUpdater:self.searchResultVC];
//        _searchController.delegate = self;
//
//        _searchController.searchResultsUpdater = self;
//
//        _searchController.searchResultsDataSource = self;
        
        _searchController.searchBar.backgroundColor = kMainColor;
        _searchController.searchBar.searchBarStyle =UISearchBarStyleMinimal;
    }
    return _searchController;
}

- (TLCityPickerSearchResultController *) searchResultVC
{
    if (_searchResultVC == nil) {
        _searchResultVC = [[TLCityPickerSearchResultController alloc] init];
        _searchResultVC.cityData = self.cityData;
        _searchResultVC.searchResultDelegate = self;
    }
    return _searchResultVC;
}

- (NSMutableArray *) data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}


- (NSMutableArray *) cityData
{
    if (_cityData == nil) {
        _cityData = [[NSMutableArray alloc] init];
    }
    return _cityData;
}

- (NSMutableArray *) localCityData
{
    if (_localCityData == nil) {
        _localCityData = [[NSMutableArray alloc] init];
        if (self.loactionCityName != nil) {
            
            
            TLCity *city = nil;
            for (TLCity *item in self.cityData) {
                if ([item.cityName isEqualToString:self.loactionCityName]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", self.locationCityID);
            }
            else {
                [_localCityData addObject:city];
            }
        }

        
        
        
        
        if (self.locationCityID != nil) {
            TLCity *city = nil;
            for (TLCity *item in self.cityData) {
                if ([item.cityID isEqualToString:self.locationCityID]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", self.locationCityID);
            }
            else {
                [_localCityData addObject:city];
            }
        }
    }
    return _localCityData;
}

- (NSMutableArray *) hotCityData
{
    if (_hotCityData == nil) {
        _hotCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.hotCitys) {
            TLCity *city = nil;
            for (TLCity *item in self.cityData) {
                if ([item.cityID isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_hotCityData addObject:city];
            }
        }
    }
    return _hotCityData;
}

- (NSMutableArray *) commonCityData
{
    if (_commonCityData == nil) {
        _commonCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.commonCitys) {
            TLCity *city = nil;
            for (TLCity *item in self.cityData) {
                if ([item.cityID isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_commonCityData addObject:city];
            }
        }
    }
    return _commonCityData;
}

- (NSMutableArray *) arraySection
{
    if (_arraySection == nil) {
        _arraySection = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, @"定位", @"热门", nil];
    }
    return _arraySection;
}

- (NSMutableArray *) commonCitys
{
    if (_commonCitys == nil) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:COMMON_CITY_DATA_KEY];
        _commonCitys = (array == nil ? [[NSMutableArray alloc] init] : [[NSMutableArray alloc] initWithArray:array copyItems:YES]);
    }
    return _commonCitys;
}

@end
