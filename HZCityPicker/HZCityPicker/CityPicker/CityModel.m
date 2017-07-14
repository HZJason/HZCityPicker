//
//  CityModel.m
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

@end


#pragma mark - CityGroup
@implementation CityGroup

- (NSMutableArray *) arrayCitys
{
    if (_arrayCitys == nil) {
        _arrayCitys = [[NSMutableArray alloc] init];
    }
    return _arrayCitys;
}

@end
