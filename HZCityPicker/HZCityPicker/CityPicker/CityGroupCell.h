//
//  CityGroupCell.h
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "CityPickerDelegate.h"
@interface CityGroupCell : UITableViewCell

@property (nonatomic, assign) id<CityGroupCellDelegate>delegate;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSArray *cityArray;

+ (CGFloat) getCellHeightOfCityArray:(NSArray *)cityArray;
@end
