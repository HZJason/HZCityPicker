//
//  CityPickerSearchResultController.h
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityPickerDelegate.h"
@interface CityPickerSearchResultController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic, assign) id<SearchResultControllerDelegate>searchResultDelegate;

@property (nonatomic, strong) NSArray *cityData;
@end
