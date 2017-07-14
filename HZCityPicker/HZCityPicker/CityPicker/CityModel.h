//
//  CityModel.h
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - City
@interface CityModel : NSObject
/*
 *  城市ID
 */
@property (nonatomic, strong) NSString *cityID;

/*
 *  城市名称
 */
@property (nonatomic, strong) NSString *cityName;

/*
 *  短名称
 */
@property (nonatomic, strong) NSString *shortName;

/*
 *  城市名称-拼音
 */
@property (nonatomic, strong) NSString *pinyin;

/*
 *  城市名称-拼音首字母
 */
@property (nonatomic, strong) NSString *initials;


@end


#pragma mark - TLCityGroup
@interface CityGroup : NSObject

/*
 *  分组标题
 */
@property (nonatomic, strong) NSString *groupName;

/*
 *  城市数组
 */
@property (nonatomic, strong) NSMutableArray *arrayCitys;

@end
