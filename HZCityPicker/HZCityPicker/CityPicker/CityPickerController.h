//
//  CityPickerController.h
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityPickerDelegate.h"
#import "CityModel.h"

#define     MAX_COMMON_CITY_NUMBER      8
#define     COMMON_CITY_DATA_KEY        @"TLCityPickerCommonCityArray"

@interface CityPickerController : UITableViewController


@property (nonatomic, assign) id<CityPickerDelegate>delegate;

/*
 *  定位城市名字
 */
@property (nonatomic, strong) NSString *locationCityName;

/*
 *  常用城市id数组,自动管理，也可赋值
 */
@property (nonatomic, strong) NSMutableArray *commonCitys;

/*
 *  热门城市id数组
 */
@property (nonatomic, strong) NSArray *hotCitys;


/*
 *  城市数据，可在Getter方法中重新指定
 */
@property (nonatomic, strong) NSMutableArray *data;

@end
