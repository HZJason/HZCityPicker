//
//  CityPickerDelegate.h
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityModel;
@class CityPickerController;

@protocol CityPickerDelegate <NSObject>

- (void) cityPickerController:(CityPickerController *)cityPickerViewController
                didSelectCity:(CityModel *)city;

- (void) cityPickerControllerDidCancel:(CityPickerController *)cityPickerViewController;

@end

@protocol CityGroupCellDelegate <NSObject>

- (void) cityGroupCellDidSelectCity:(CityModel *)city;

@end

@protocol SearchResultControllerDelegate <NSObject>

- (void) searchResultControllerDidSelectCity:(CityModel *)city;

@end
