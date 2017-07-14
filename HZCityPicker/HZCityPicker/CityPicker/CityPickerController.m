//
//  CityPickerController.m
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import "CityPickerController.h"
#import "CityPickerSearchResultController.h"
#import "CityGroupCell.h"
#import "CityHeaderView.h"
@interface CityPickerController ()<CityGroupCellDelegate, SearchResultControllerDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) CityPickerSearchResultController *searchResultVC;

@property (nonatomic, strong) NSMutableArray *cityData;
@property (nonatomic, strong) NSMutableArray *localCityData;
@property (nonatomic, strong) NSMutableArray *hotCityData;
@property (nonatomic, strong) NSMutableArray *arraySection;

@end

@implementation CityPickerController

@synthesize data = _data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    [self.navigationItem setTitle:@"城市选择"];
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonDown:)];
    [self.navigationItem setLeftBarButtonItem:cancelBarButton];
    
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor blackColor]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[CityGroupCell class] forCellReuseIdentifier:@"TLCityGroupCell"];
    [self.tableView registerClass:[CityHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLCityHeaderView"];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        return 1;
    }
    CityGroup *group = [self.data objectAtIndex:section - 2];
    return group.arrayCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2 ) {
        CityGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLCityGroupCell"];
        if (indexPath.section == 0) {
            [cell setTitle:@"定位城市"];
            [cell setCityArray:self.localCityData];
        }
        else {
            [cell setTitle:@"热门城市"];
            [cell setCityArray:self.hotCityData];
        }
        [cell setDelegate:self];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    CityGroup *group = [self.data objectAtIndex:indexPath.section - 2];
    CityModel *city =  [group.arrayCitys objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 2) {
        return nil;
    }
    CityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLCityHeaderView"];
    NSString *title = [_arraySection objectAtIndex:section];
    [headerView setTitle:title];
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [CityGroupCell getCellHeightOfCityArray:self.localCityData];
    }
    else if (indexPath.section == 1){
        return [CityGroupCell getCellHeightOfCityArray:self.hotCityData];
    }
    return 43.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 2) {
        return 0.0f;
    }
    return 23.5f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < 2) {
        return;
    }
    CityGroup *group = [self.data objectAtIndex:indexPath.section - 2];
    CityModel *city = [group.arrayCitys objectAtIndex:indexPath.row];
    [self didSelctedCity:city];
}

//索引测title
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
- (void) cityGroupCellDidSelectCity:(CityModel *)city
{
    [self didSelctedCity:city];
}

#pragma mark TLSearchResultControllerDelegate
- (void) searchResultControllerDidSelectCity:(CityModel *)city
{
    [self.searchController dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self didSelctedCity:city];
}

#pragma mark - Event Response
- (void) cancelButtonDown:(UIBarButtonItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerControllerDidCancel:)]) {
        [_delegate cityPickerControllerDidCancel:self];
    }
}

#pragma mark - Private Methods
- (void) didSelctedCity:(CityModel *)city
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
        [_searchController.searchBar setPlaceholder:@"请输入城市中文名称或拼音"];
        [_searchController.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [_searchController.searchBar sizeToFit];
        [_searchController setSearchResultsUpdater:self.searchResultVC];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    }
    return _searchController;
}

- (CityPickerSearchResultController *) searchResultVC
{
    if (_searchResultVC == nil) {
        _searchResultVC = [[CityPickerSearchResultController alloc] init];
        _searchResultVC.cityData = self.cityData;
        _searchResultVC.searchResultDelegate = self;
        
    
    }
    return _searchResultVC;
}

- (NSMutableArray *) data
{
    if (_data == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
        _data = [[NSMutableArray alloc] init];
        
        
        for (NSDictionary *groupDic in array) {
            CityGroup *group = [[CityGroup alloc] init];
            group.groupName = [groupDic objectForKey:@"initial"];
            for (NSDictionary *dic in [groupDic objectForKey:@"citys"]) {
                CityModel *city = [[CityModel alloc] init];
                city.cityID = [dic objectForKey:@"city_key"];
                city.cityName = [dic objectForKey:@"city_name"];
                city.shortName = [dic objectForKey:@"short_name"];
                city.pinyin = [dic objectForKey:@"pinyin"];
                city.initials = [dic objectForKey:@"initials"];
                [group.arrayCitys addObject:city];
                [self.cityData addObject:city];
            }
            [self.arraySection addObject:group.groupName];
            [_data addObject:group];
        }
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
        if (self.locationCityName != nil) {
            CityModel *city = nil;
            for (CityModel *item in self.cityData) {
                if ([item.cityName isEqualToString:self.locationCityName]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", self.locationCityName);
            }
            else {
                [_localCityData addObject:city];
            }
        }
    }
    return _localCityData;
}

//热门城市
- (NSMutableArray *) hotCityData
{
    if (_hotCityData == nil) {
        _hotCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.hotCitys) {
            CityModel *city = nil;
            for (CityModel *item in self.cityData) {
                if ([item.cityName isEqualToString:str]) {
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

- (NSMutableArray *) arraySection
{
    if (_arraySection == nil) {
        _arraySection = [[NSMutableArray alloc] initWithObjects: @"定位",@"最热", nil];
    }
    return _arraySection;
}

@end
