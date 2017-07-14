//
//  CityPickerSearchResultController.m
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import "CityPickerSearchResultController.h"
#import "CityModel.h"
@interface CityPickerSearchResultController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation CityPickerSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    CityModel *city =  [self.data objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CityModel *city = [self.data objectAtIndex:indexPath.row];
    if (_searchResultDelegate && [_searchResultDelegate respondsToSelector:@selector(searchResultControllerDidSelectCity:)]) {
        [_searchResultDelegate searchResultControllerDidSelectCity:city];
    }
}


#pragma mark - UISearchResultsUpdating
- (void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //自定义中文取消
    searchController.searchBar.showsCancelButton = YES;
    UIButton *canceLBtn = [searchController.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    NSString *searchText = searchController.searchBar.text;
    [self.data removeAllObjects];
    for (CityModel *city in self.cityData){
        if ([city.cityName containsString:searchText] || [city.pinyin containsString:searchText] || [city.initials containsString:searchText]) {
            [self.data addObject:city];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Getter
- (NSMutableArray *) data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}


@end
